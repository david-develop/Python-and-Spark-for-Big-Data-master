

variable "ingress" {
    type = list(number)
    default = [80,443,22,8888,8081]
}

output "sg_name" {
    value = aws_security_group.ec2_traffic.name
}

resource "aws_security_group" "ec2_traffic" {
    name = "Allow Web Traffic"

    dynamic "ingress" {
        iterator = port
        for_each = var.ingress
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}