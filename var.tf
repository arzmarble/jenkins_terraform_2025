# VPC
variable "AZ_1" {
    default = "ap-southeast-1a"
}

variable "AZ_2" {
    default = "ap-southeast-1b"
}

# EC2
variable "ami_id" {
    type = map(any)
    default = {
        ap-southeast-1a = "ami-00d8fc944fb171e29"
        ap-southeast-1b = "ami-00d8fc944fb171e29"
    }
}

variable "instnace_type" {
    default = "t3.micro"
}

variable "MYIP" {
    default = "58.11.27.15/32"
}
