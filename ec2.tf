# Bastion Host Amazon Linux 2 Server

resource "aws_instance" "two_tier_bastion_host" {
  ami                    = "ami-013e83f579886baeb"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.two_tier_key_pair.key_name
  subnet_id              = module.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.bastion_host_sg.id]

  tags = {
    Name = "Two-Tier-Bastion-Host"
  }
}

# Servers in the application tier

module "Two-Tier-App-Server-01" {
  source                 = "./modules/ec2"
  Name                   = "Two-Tier_App_001"
  subnet_id              = module.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.two_tier_app_sg.id]
}

module "Two-Tier-App-Server-02" {
  source                 = "./modules/ec2"
  Name                   = "Two-Tier_App_002"
  subnet_id              = module.private_subnet_2.id
  vpc_security_group_ids = [aws_security_group.two_tier_app_sg.id]
}
