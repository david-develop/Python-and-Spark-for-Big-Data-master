

variable "ingress" {
    type = list(number)
    default = [80,443,22,8888]
}

variable "egress" {
    type = list(number)
    default = [80,443,22,8888]
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
            to_port = port. value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

        dynamic "egress" {
        iterator = port
        for_each = var.egress
        content {
            from_port = port.value
            to_port = port. value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}