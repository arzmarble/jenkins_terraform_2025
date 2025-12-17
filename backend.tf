terraform {
  # Backup State in S3 Bucket
  backend "s3" {
    bucket = "uaj-terraform-backend"
    key    = "state/terraform.tfstate"
    region = "ap-southeast-1"
  }
}