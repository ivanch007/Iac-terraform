provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "nginx-server" {
  ami           = "ami-00eb69d236edcfaf8"
  instance_type = "t3.micro"

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
    Name = "nginx-server"
    Enviroment = "test"
    Owner = "ivanocampo07@gmail.com"
    Team = "Cloud-deveploment"
    Project = "practica"
  }
}

resource "aws_key_pair" "nginx_server_ssh" {
  key_name   = "nginx-server-ssh"
  public_key = file("nginx-server.key.pub")

  tags = {
    Name = "nginx-server-ssh"
    Enviroment = "test"
    Owner = "ivanocampo07@gmail.com"
    Team = "Cloud-deveploment"
    Project = "practica"
  }
}

resource "aws_security_group" "nginx_server_sg" {
  name        = "nginx-server-sg"
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
    Name = "nginx-server-security-group"
    Enviroment = "test"
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
