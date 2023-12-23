packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "image" {

  ami_name      = local.image-name
  instance_type = "t2.micro"
  source_ami    = var.source_ami_id
  ssh_username  = "ec2-user"

  tags = {
    Name    = local.image-name
    Project = var.project_name
    Env     = var.project_env
  }
}

build {

  sources = ["source.amazon-ebs.image"]

  provisioner "file" {
    source      = "../website"
    destination = "/tmp/"
  }

  provisioner "shell" {
    script          = "./userdata.sh"
    execute_command = "sudo {{.Path}}"
  }

}
