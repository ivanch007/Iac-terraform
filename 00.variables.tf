variable "ami_id" {
    description = "ID de la AMI"
    default = "ami-0b4624933067d393a"
    
  }

variable "instance_type" {
  description = "Tipo de la instancia EC2"
  default = "t3 .micro"
  
}

variable "server_name" {
  description = "Nombre del servidor web"
  default = "nginx-server"

}

variable "enviroment" {
  description = "Ambiente de la aplicacion"
  default = "test"
  
}
