packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "nginx" {
    ami_name = "nginx-${local.timestamp}"

    source_ami_filter {
        filters = {
            name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-*-amd64-server-20220912"
            root-device-type    = "ebs"
            virtualization-type = "hvm"
        }
    most_recent = true
    owners      = ["099720109477"]
    }

    instance_type = "t2.micro"
    region = "us-east-1"
    ssh_username = "ubuntu"
}

build {
    sources = [
        "source.amazon-ebs.nginx"
    ]

    provisioner "file" {
        source = "./html_files.zip"
        destination = "/home/ubuntu/html_files.zip"
    }

    provisioner "shell" {
        script = "./nginx.sh"
    }
}