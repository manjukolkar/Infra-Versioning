# Create S3 bucket
resource "aws_s3_bucket" "demo_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = "DemoS3Bucket"
    Environment = "Dev"
  }
}

# Create EC2 instance
resource "aws_instance" "demo_ec2" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 (us-east-1)
  instance_type = var.ec2_instance_type

  tags = {
    Name        = "DemoEC2Instance"
    Environment = "Dev"
  }
}
