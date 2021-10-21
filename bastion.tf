#################################################################################################################################
# ec2 모듈을 사용해서 bastion용 ec2 리소스를 만듭니다. 
# ec2 리소스를 만들기에 앞서 필요한 keypair 및 security group을 keypair 리소스와 security group 모듈을 통해 만들고, ec2 모듈에서 사용합니다. 

# bastion-variables.tf에 bastion과 관련된 변수들을 선언하고, var.xxx 형태로 변수를 호출하여 모듈 및 리소스의 속성들에 활용합니다.
# 완성된 리소스의 결과를 확인하기 위해 bastion-outputs.tf에 확인 할 결과들을 출력합니다. 
#################################################################################################################################


#################################################################################################################################
# 키생성하는 방법
# 로컬의 WSL(window일 경우)상에서 ssh-keygen 명령어를 통해 공개키 및 비밀키를 만듭니다. 
# 명령어 : ssh-keygen -t rsa -b 4096 -N "" -f bastion-key
# 비밀키는 접속 시 사용하고, .pub 형태로된 공개키를 서버에 등록해야 합니다. 
# aws_key_pair리소스를 만든 뒤 key_name 설정, public_key를 변수 형태로 대입시켜 줍니다. 
# 테라폼 클라우드 본인 계정 workspace 내에 variables를 등록하는 곳에 TF_VAR_bastion_keypair 형태로 공개키를 환경변수에 등록하면,
# bastion_keypair의 변수를 default 값이 아닌 환경 변수 값으로 읽어 인식합니다. 
# https://user-images.githubusercontent.com/47745785/137576671-9f6e4c39-65ce-4c8d-859c-d04501f50598.png
#################################################################################################################################

# bastion 서버에 접속에 필요한 공개키를 등록합니다. 
resource "aws_key_pair" "tf_singa_keypair_bast_wp_inhyo" {
  key_name   = "bastion-key"
  public_key = var.bastion_keypair
}

# 코드 수정시에 Elastic IP를 다시 할당하지 않고 배스천 서버에 재사용해서 
# 항상 처음 할당된 Elastic IP를 사용하게 됩니다. 
resource "aws_eip_association" "tf_singa_eip_associ_inhyo" {
  instance_id   = module.bast_ec2.id
  allocation_id = aws_eip.tf_singa_bast_eip_inhyo.id
}

# bastion 서버에 elastic ip를 할당하기 위해 eip 리소스로 고정 ip를 1개 성생합니다. 
resource "aws_eip" "tf_singa_bast_eip_inhyo" {
  vpc = true
}

# bastion용 security group을 모듈을 통해 생성합니다. 
module "bast_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name   = var.bastion_sg_name
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = [var.home_ip, var.company_ip]
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]

  tags = var.bastion_sg_tags
}

# bastion ec2 서버를 모듈을 통해 생성합니다. 
module "bast_ec2" {
  # 모듈 소스, 버전 지정
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"


  name                        = var.bastion_name                                     # 서버 이름
  ami                         = var.bastion_ami                                      # ubuntu 20.04 이미지
  instance_type               = var.bastion_instance_type                            # 인스턴스 유형
  key_name                    = aws_key_pair.tf_singa_keypair_bast_wp_inhyo.key_name # 위에서 만든 키 이름
  vpc_security_group_ids      = [module.bast_sg.security_group_id]                   # 위에서 생성한 security group 모듈의 id
  subnet_id                   = element(module.vpc.public_subnets, 0)                # vpc 모듈 public subnet 첫 번째 원소 10.70.11.0/24
  availability_zone           = element(module.vpc.azs, 0)                           # vpc 모듈 가용영역 속성의 첫 번째 값 1a
  associate_public_ip_address = true                                                 # public ip 할당 허용
  private_ip                  = var.bastion_private_ip
  tags                        = var.bastion_tags # 태그
}