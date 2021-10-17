#################################################################################################################################
# ec2 모듈을 사용해서 db용 ec2 리소스를 만듭니다. 
# ec2 리소스를 만들기에 앞서 필요한 keypair 및 security group을 keypair 리소스와 security group 모듈을 통해 만들고, ec2 모듈에서 사용합니다. 

# db-variables.tf에 db과 관련된 변수들을 선언하고, var.xxx 형태로 변수를 호출하여 모듈 및 리소스의 속성들에 활용합니다.
# 완성된 리소스의 결과를 확인하기 위해 db-outputs.tf에 확인 할 결과들을 출력합니다. 
#################################################################################################################################


#################################################################################################################################
# 키생성하는 방법
# 로컬의 WSL(window일 경우)상에서 ssh-keygen 명령어를 통해 공개키 및 비밀키를 만듭니다. 
# 명령어 : ssh-keygen -t rsa -b 4096 -N "" -f db-key
# 비밀키는 접속 시 사용하고, .pub 형태로된 공개키를 서버에 등록해야 합니다. 
# aws_key_pair리소스를 만든 뒤 key_name 설정, public_key를 변수 형태로 대입시켜 줍니다. 
# 테라폼 클라우드 본인 계정 workspace 내에 variables를 등록하는 곳에 TF_VAR_db_keypair 형태로 공개키를 환경변수에 등록하면,
# db_keypair의 변수를 default 값이 아닌 환경 변수 값으로 읽어 인식합니다. 
# ex) https://user-images.githubusercontent.com/47745785/137576671-9f6e4c39-65ce-4c8d-859c-d04501f50598.png
#################################################################################################################################

# db 서버에 접속에 필요한 공개키를 등록합니다. 
resource "aws_key_pair" "tf_singa_keypair_db_wp_inhyo" {
  key_name   = "db-key"
  public_key = var.db_keypair
}

# db용 security group을 모듈을 통해 생성합니다. (mysql)
module "db_mysql_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name   = var.db_mysql_sg_name
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = var.db_mysql_sg_cidr_blocks # 이거 바꿔 10.70.21.0/24, 10.70.22.0/24
  ingress_rules       = ["mysql-tcp"]
  egress_rules        = ["all-all"]

  tags = var.db_mysql_sg_tags
}

# db용 security group을 모듈을 통해 생성합니다. (ssh)
module "db_ssh_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name   = var.db_ssh_sg_name
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = var.db_ssh_sg_cidr_blocks # 이거 바꿔 10.70.21.0/24, 10.70.22.0/24, 10.70.11.11/32
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]


  tags = var.db_ssh_sg_tags
}

# db ec2 서버를 모듈을 통해 생성합니다. 
module "db_ec2" {
  # 모듈 소스, 버전 지정
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                   = var.db_name                                                                # 서버 이름
  ami                    = var.db_ami                                                                 # ubuntu 20.04 이미지
  instance_type          = var.db_instance_type                                                       # 인스턴스 유형
  key_name               = aws_key_pair.tf_singa_keypair_db_wp_inhyo.key_name                         # 위에서 만든 키 이름
  vpc_security_group_ids = [module.db_mysql_sg.security_group_id, module.db_ssh_sg.security_group_id] # 위에서 생성한 security group 모듈의 id
  subnet_id              = element(module.vpc.intra_subnets, 0)                                       # vpc 모듈 public subnet 첫 번째 원소 10.70.11.0/24
  availability_zone      = element(module.vpc.azs, 0)                                                 # vpc 모듈 가용영역 속성의 첫 번째 값 1a
  private_ip             = var.db_private_ip
  tags                   = var.db_tags
}