# resource "tls_private_key" "ec2_spark_pk" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

resource "aws_key_pair" "ec2_spark_key" {
  key_name   = "ec2_spark_key"
  public_key = file("C:/Users/d.peralta/.ssh/id_rsa.pub")
}

resource "aws_instance" "ec2_spark" {
  ami             = "ami-0e001c9271cf7f3b9"
  instance_type   = "t2.micro"
  security_groups = [var.sg_name]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2_spark_key.key_name
  # user_data = file("server_script.sh")
  tags = {
    Name = "Spark EC2 2"
  }
}

output "ec2_public_ip" {
  value = aws_instance.ec2_spark.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.ec2_spark.public_dns
}

/* resource "aws_eip" "web_ip" {
  instance = aws_instance.ec2_spark.id
} */