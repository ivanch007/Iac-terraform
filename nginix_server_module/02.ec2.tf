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


  associate_public_ip_address = true
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