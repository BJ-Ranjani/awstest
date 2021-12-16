resource "aws_instance" "web" {
  ami           = "ami-0509c15d6eb3fcaa4"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}
