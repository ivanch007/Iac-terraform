module "nginix_server_dev" {
    source = "./nginix_server_module"

    ami_id = "ami-0b4624933067d393a"
    instance_type = "t2.micro"
    server_name = "nginx-server-dev"
    enviroment = "dev"
    
}

module "nginix_server_qa" {
    source = "./nginix_server_module"

    ami_id = "ami-0b4624933067d393a"
    instance_type = "t2.micro"
    server_name = "nginx-server-qa"
    enviroment = "qa"
    
}
  output "nginix_dev_public_ip" {
    description = "direccion IP publica del a instancia EC2"
    value = module.nginix_server_dev.server_public_ip  
  }

  output "nginix_dev_public_dns" {
    description = "DNS publicO de la instancia EC2"
    value = module.nginix_server_dev.server_public_dns  
  }

  ## Output de qa ##

  output "nginix_qa_public_ip" {
    description = "direccion IP publica del a instancia EC2"
    value = module.nginix_server_qa.server_public_ip  
  }

  output "nginix_qa_public_dns" {
    description = "DNS publicO de la instancia EC2"
    value = module.nginix_server_qa.server_public_dns  
  }


