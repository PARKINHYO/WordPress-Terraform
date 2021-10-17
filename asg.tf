##########################################################################################
# 앱 접속을 위한 key pair를 테라폼 리소스를 사용하여 만듭니다. 
# 테라폼 모듈을 사용하여 ALB 및 ASG를 위한 Security Group를 만듭니다. 
# 테라폼 모듈을 사용하여 애플리케이션을 위한 ALB, ASG를 생성합니다. 
# ASG 설정에 따라서 준비된 이미지를 사용하여 애플리케이션 서버를 생성합니다. 
##########################################################################################

#################################################################################################################################
# 키생성하는 방법
# 로컬의 WSL(window일 경우)상에서 ssh-keygen 명령어를 통해 공개키 및 비밀키를 만듭니다. 
# 명령어 : ssh-keygen -t rsa -b 4096 -N "" -f app-key
# 비밀키는 접속 시 사용하고, .pub 형태로된 공개키를 서버에 등록해야 합니다. 
# aws_key_pair리소스를 만든 뒤 key_name 설정, public_key를 변수 형태로 대입시켜 줍니다. 
# 테라폼 클라우드 본인 계정 workspace 내에 variables를 등록하는 곳에 TF_VAR_app_keypair 형태로 공개키를 환경변수에 등록하면,
# app_keypair의 변수를 default 값이 아닌 환경 변수 값으로 읽어 인식합니다. 
# ex) https://user-images.githubusercontent.com/47745785/137576671-9f6e4c39-65ce-4c8d-859c-d04501f50598.png
#################################################################################################################################



# key pair
resource "aws_key_pair" "tf_singa_keypair_app_wp_inhyo" {
  key_name   = "app-key"
  public_key = var.app_keypair
}



# ALB HTTP를 위한 Security Group
module "alb_http_sg" {

  # Security Group 모듈 안의 http-80 서브 모듈을 활용해서 http Security Group를 완성
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "~> 4.0"

  name   = var.alb_http_sg_name # 이름
  vpc_id = module.vpc.vpc_id    # 생성한 VPC id

  ingress_cidr_blocks = ["0.0.0.0/0"] # 어디서든 http를 통해 웹을 접속할 수 있게 전부다 열어줌

  tags = var.alb_http_sg_tags # 태그

}



# ALB SSH를 위한 Security Group
module "alb_bastion_sg" {
  # Security Group 모듈 안의 ssh 서브 모듈을 활용해서 ssh Security Group를 완성
  source  = "terraform-aws-modules/security-group/aws//modules/ssh"
  version = "~> 4.0"

  name   = var.alb_bastion_sg_name # 이름
  vpc_id = module.vpc.vpc_id       # 생성한 VPC id

  ingress_cidr_blocks = var.alb_bastion_sg_ingress_cidr_blocks # Bastion 서버 내부 ip

  tags = var.alb_bastion_sg_tags # 태그
}



# ALB 모듈을 통해 ALB 생성
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = var.alb_name # 이름

  vpc_id          = module.vpc.vpc_id                      # VPC id 
  subnets         = module.vpc.public_subnets              # public subnet 대역에 ALB를 만들어야 다른 네트워크 영역에서 웹에 접근이 가능
  security_groups = [module.alb_http_sg.security_group_id] # Security Group(HTTP) 연결

  # HTTP 관련 설정
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  # 타겟 그룹 관련 설정
  target_groups = [
    {
      name             = var.alb_tg_name
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    },
  ]

  tags = var.alb_tags # 태그
}



# ASG를 위한 Security Group을 생성
module "asg_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name   = var.asg_sg_name   # 이름 
  vpc_id = module.vpc.vpc_id # VPC id

  # ALB에서 만든 Security Group 2개(HTTP, SSH)를 가지고 와서 Security Group을 만든다. 
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.alb_http_sg.security_group_id # ALB에서 만든 HTTP Security Group id
    },
    {
      # rule                     = "ssh-tcp"
      from_port = 22
      to_port = 22
      protocol = 6
      description = "submodule rule로 지정하니깐 적용이 안됨.."
      source_security_group_id = module.alb_bastion_sg.security_group_id # ALB에서 만든 SSH Security Group id
    }
  ]

  number_of_computed_ingress_with_source_security_group_id = 1 # computed_ingress_with_source_security_group_id 갯수

  egress_rules = ["all-all"] # outbound 전체로 열어준다. 

  tags = var.asg_sg_tags # 태그
}



# ASG. Launch template을 테라폼 모듈을 통해서 만든다. 
module "default_lt" {
  source = "terraform-aws-modules/autoscaling/aws"

  name = var.lt_name # 이름

  vpc_zone_identifier       = module.vpc.private_subnets # 애플리케이션 서브넷인 private subnet을 설정한다. 
  min_size                  = var.min_size               # 애플리케이션 최소 갯수
  max_size                  = var.max_size               # 애플리케이션 최대 갯수
  desired_capacity          = var.desired_capacity       # 항상 running 상태여야 하는 애플리케이션 서버 갯수
  wait_for_capacity_timeout = 0                          # ASG instance 상태의 healthy가 뜰 때까지 기다리는 시간. 0으로 하면 계속 기다린다.
  enable_monitoring         = true                       # 모니터링

  # launch template 사용 여부를 bool 형태로 설정해줘야 한다. default가 false이다. 
  use_lt    = var.use_lt    # launch template을 사용한다. 
  create_lt = var.create_lt # launch template을 만든다.  

  image_id      = var.image_id      # 애플리케이션 서버의 ami 
  instance_type = var.instance_type # 애플리케이션 서버 인스턴스 유형

  target_group_arns = module.alb.target_group_arns                        # ALB arn
  security_groups   = [module.asg_sg.security_group_id]                   # ASG에 쓸 Security Group id
  key_name          = aws_key_pair.tf_singa_keypair_app_wp_inhyo.key_name # 애플리케이션 keypair

  tags = var.lt_tags # 태그
}
