variable "region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "us-east-1"
}

variable "app_id" {
  description = "Application ID governance tag. Must begin with APP-."
  type        = string
  default     = "APP-12345"
}

variable "env" {
  description = "Environment."
  type        = string
  default     = "dev"
}

variable "lob" {
  description = "Account Name."
  type        = string
  default     = "sample"
}

variable "kms_key_id" {
  description = "KMS alias ARN."
  type        = string
  default     = "arn:aws:kms:us-east-1:123456789012:alias/applications-kms-example"
}

variable "instance" {
  description = "EC2 instance configuration."

  type = object({
    iam_instance_profile        = string
    instance_type               = string
    key_name                    = optional(string)
    monitoring                  = optional(bool, true)
    name                        = string
    strategic_ami_build         = string
    strategic_os_type           = string
    user_data                   = optional(string)
    user_data_base64            = optional(string)
    user_data_replace_on_change = optional(bool, false)

    root_volume = object({
      size = number
      type = optional(string, "gp3")
    })
  })

  default = {
    iam_instance_profile = "example-instance-profile"
    instance_type        = "t3.large"
    name                 = "example-ec2"

    strategic_os_type   = "windows"
    strategic_ami_build = "latest"

    root_volume = {
      size = 100
      type = "gp3"
    }
  }
}

variable "network" {
  description = "Primary network interface configuration."

  type = object({
    private_ip         = optional(string)
    security_group_ids = set(string)
    subnet_id          = string
  })

  default = {
    subnet_id          = "subnet-xxxxxxxx"
    security_group_ids = ["sg-xxxxxxxx"]
  }
}

variable "additional_volumes" {
  description = "Additional EBS volumes."

  type = map(object({
    device_name = string
    size        = optional(number)
    snapshot_id = optional(string)
    type        = optional(string, "gp3")
  }))

  default = {
    data = {
      device_name = "/dev/sdf"
      size        = 50
      type        = "gp3"
    }
  }
}

variable "tags" {
  description = "Application-specific tags, merged on top of mandatory governance tags."
  type        = map(string)

  default = {
    Owner = "Platform Team"
  }
}
