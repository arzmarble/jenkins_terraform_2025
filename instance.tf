# Create EC2 Instance Public 1
resource "aws_instance" "ec2-pub1" {
    ami = var.ami_id[var.AZ_1]
    instance_type = var.instnace_type
    subnet_id = aws_subnet.pub-1.id
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.UAJ-sg.id]
    key_name = aws_key_pair.key_pair.key_name
    tags = {
        Name    = "T1-Instance"
        Project = "Test"
    }
}

# Print PublicIP 1
output "PublicIP-Linux-1" {
  value = aws_instance.ec2-pub1.public_ip
}

# Create EC2 Instance Public 2
resource "aws_instance" "ec2-pub2" {
    ami = var.ami_id[var.AZ_2]
    instance_type = var.instnace_type
    subnet_id = aws_subnet.pub-2.id
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.UAJ-sg.id]
    key_name = aws_key_pair.key_pair.key_name
    tags = {
        Name    = "T2-Instance"
        Project = "Test"
    }
}

# Print PublicIP 2
output "PublicIP-Linux-2" {
  value = aws_instance.ec2-pub2.public_ip
}