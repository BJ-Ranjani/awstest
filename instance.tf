provider “aws” {
}


resource "aws_instance" "example" {
     ami = ami-0f8d58f08e7d12df0
     instance_type = "t2.micro"
}
