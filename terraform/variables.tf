variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type (t3.medium or t2.large recommended for Jenkins + SonarQube + Docker)"
  type        = string
  default     = "t3.medium"
}

variable "ami_id" {
  description = "Ubuntu 22.04 LTS AMI ID for your region"
  type        = string
  default     = "ami-0c7217cdde317cfec" # Replace with valid Ubuntu AMI in your region
}

variable "key_name" {
  description = "Name of existing AWS EC2 Key Pair to SSH into instance"
  type        = string
}
