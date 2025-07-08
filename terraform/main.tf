provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  key_name      = var.key_name

  tags = {
    Name = "FlaskAppEC2"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install docker -y
              service docker start
              usermod -aG docker ec2-user
              docker run -d -p 5000:5000 --name flask-app yourdockerhubusername/cicd-flask-app
              EOF
}

output "public_ip" {
  value = aws_instance.ec2.public_ip
}