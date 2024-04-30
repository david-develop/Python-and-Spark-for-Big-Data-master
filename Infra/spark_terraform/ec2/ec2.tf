resource "aws_key_pair" "ec2_spark_key" {
    key_name   = "ec2_spark_key"
    public_key = file("C:/Users/d.peralta/.ssh/id_rsa.pub")
}

resource "aws_instance" "ec2" {
    ami = "ami-0dbc3d7bc646e8516"
    instance_type = "t2.micro"
    security_groups = [var.sg_name]
    # subnet_id = var.vpc_subnet_ec2_id
    associate_public_ip_address = true
    key_name = aws_key_pair.ec2_spark_key.key_name
    tags = {
        Name = "Spark EC2"
    }
}