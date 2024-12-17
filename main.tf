variable "ami_id" {
    description = "ID de la AMI"
    default = "ami-0b4624933067d393a"
    
  }

variable "instance_type" {
  description = "Tipo de la instancia EC2"
  default = "t3.micro"
  
}

variable "server_name" {
  description = "Nombre del servidor web"
  default = "nginx-server"

}

variable "enviroment" {
  description = "Ambiente de la aplicacion"
  default = "test"
  
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "nginx-server" {
  ami           = var.ami_id
  instance_type = var.instance_type

    user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y nginx
                sudo systemctl enable nginx
                sudo systemctl start nginx
                sudo firewall-cmd --permanent --add-service=http || true
                sudo firewall-cmd --reload || true
              EOF


  key_name = aws_key_pair.nginx_server_ssh.key_name
  vpc_security_group_ids = [
    aws_security_group.nginx_server_sg.id
  ]

  tags = {
    Name = var.server_name
    Enviroment = var.enviroment
    Owner = "ivanocampo07@gmail.com"
    Team = "Cloud-deveploment"
    Project = "practica"
  }
}

resource "aws_key_pair" "nginx_server_ssh" {
  key_name   = "${var.server_name}-ssh"
  public_key = file("${var.server_name}.key.pub")

  tags = {
    Name = "${var.server_name}-ssh"
    Enviroment = var.enviroment
    Owner = "ivanocampo07@gmail.com"
    Team = "Cloud-deveploment"
    Project = "practica"
  }
}

resource "aws_security_group" "nginx_server_sg" {
  name        = "${var.server_name}-sg"
  description = "Allow SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.server_name}-security-group"
    Enviroment = var.enviroment
    Owner = "ivanocampo07@gmail.com"
    Team = "Cloud-deveploment"
    Project = "practica"
  }
}

  output "server_public_ip" {
    description = "direccion IP publica del a instancia EC2"
    value = aws_instance.nginx-server.public_ip  
  }

  output "server_public_dns" {
    description = "DNS publicO de la instancia EC2"
    value = aws_instance.nginx-server.public_dns  
  }

  