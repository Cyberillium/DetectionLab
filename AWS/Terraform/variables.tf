variable "region" {
  default = "us-west-1"
}

variable "profile" {
  default = "terraform"
}

variable "custom-tags" {
  type        = map(string)
  description = "Optional mapping for additional tags to apply to all related AWS resources"
  default     = {}
}

variable "instance_name_prefix" {
  description = "Optional string to prefix at the front of instance names in case you need to run multiple DetectionLab environments in the same AWS account"
  default     = ""
}

variable "availability_zone" {
  description = "https://www.terraform.io/docs/providers/aws/d/availability_zone.html"
  default     = ""
}

variable "shared_credentials_file" {
  description = "Path to your AWS credentials file"
  type        = string
  default     = "/home/username/.aws/credentials"
}

variable "public_key_name" {
  description = "A name for AWS Keypair to use to auth to logger. Can be anything you specify."
  default     = "id_logger"
}

variable "public_key_path" {
  description = "Path to the public key to be loaded into the logger authorized_keys file"
  type        = string
  default     = "/home/username/.ssh/id_logger.pub"
}

variable "private_key_path" {
  description = "Path to the private key to use to authenticate to logger."
  type        = string
  default     = "/home/username/.ssh/id_logger"
}

variable "ip_whitelist" {
  description = "A list of CIDRs that will be allowed to access the EC2 instances"
  type        = list(string)
  default     = [""]
}

variable "external_dns_servers" {
  description = "Configure lab to allow external DNS resolution"
  type        = list(string)
  default     = ["8.8.8.8"]
}

# Use Data Sources to resolve the AMI-ID for the Ubuntu 20.04 AMI
data "aws_ami" "logger_ami" {
  owners = ["505638924199"]

  filter {
    name   = "name"
    values = ["detectionlab-logger"]
  }
}

# Use Data Sources to resolve the AMI-ID for the pre-built DC host
data "aws_ami" "dc_ami" {
  owners = ["505638924199"]

  filter {
    name   = "name"
    values = ["detectionlab-dc"]
  }
}

# Use Data Sources to resolve the AMI-ID for the pre-built WEF host
data "aws_ami" "wef_ami" {
  owners      = ["505638924199"]
  most_recent = true

  filter {
    name   = "name"
    values = ["detectionlab-wef"]
  }
}

# Use Data Sources to resolve the AMI-ID for the pre-built Win10 host
data "aws_ami" "win10_ami" {
  owners      = ["505638924199"]
  most_recent = true

  filter {
    name   = "name"
    values = ["detectionlab-win10"]
  }
}

# If you are building your own AMIs, replace the default values below with
# the AMI IDs
variable "logger_ami" {
  type    = string
  default = ""
}

variable "dc_ami" {
  type    = string
  default = ""
}

variable "wef_ami" {
  type    = string
  default = ""
}

variable "exchange_ami" {
  type    = string
  default = ""
}

variable "win10_ami" {
  type    = string
  default = ""
}

variable "instance_type_server" {
  type    = string
  default = "t3.medium"
}

variable "instance_type_client" {
  type    = string
  default = "t2.large"
}



variable "VPN_client_cidr_block" {
  description = "The IPv4 address range, in CIDR notation being /22 or greater, from which to assign client IP addresses"
  default     = "192.168.0.0/22"
}

variable "VPN_name" {
  default = "DetectionLab VPN"
}

variable "VPN_server_cert" {
  description = "Server certificate"
}

variable "VPN_client_cert" {
  description = "Client/Root certificate"
}

variable "VPN_split_tunnel" {
  default     = true
  description = "With split_tunnel false, all client traffic will go through the VPN."

}

variable "VPN_dns_servers" {
  type    = list(any)
  default = []
}