variable "env" {
  type        = string
  description = "Datafoundation formatted env. Ex `data-staging`"
}

variable "region" {
  type        = string
  description = "AWS region for the Provider"

}

# VPC configurations
variable "aws_vpc_id" {
  description = "Id of the VPC where you want to deploy EKS"
  type        = string
}

variable "aws_private_subnets_id" {
  description = "List of private subnet's id where will be deployed"
  type = list(string)
}

# Repositories configuration
variable "repositories" {
  type = map(
    list(
      object(
        {
          name = string,
          image = object({
            repository = string,
            tag = string
          }),
          repo_path = string
        }
      )
    )
  )
  default = {}
}