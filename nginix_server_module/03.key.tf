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