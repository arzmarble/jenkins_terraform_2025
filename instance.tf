# Create EC2 Instance
resource "aws_instance" "new-ec2" {
    ami = var.ami_id[var.AZ_1]
    instance_type = var.instnace_type
    subnet_id = aws_subnet.pub-1.id
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.UAJ-sg.id]
    key_name = aws_key_pair.key_pair.key_name
    tags = {
        Name    = "T-Instance"
        Project = "Test"
    }
}

# Print PublicIP
output "PublicIP-Linux2" {
  value = aws_instance.new-ec2.public_ip
}