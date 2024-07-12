variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "ap-south-1"
}

variable "route53_zone_id" {
  description = "The Route 53 hosted zone ID"
  type        = string
}

variable "strapi_subdomain" {
  description = "The subdomain for the Strapi application"
  type        = string
}

variable "react_subdomain" {
  description = "The subdomain for the React application"
  type        = string
}

variable "strapi_docker_image" {
  description = "The Docker image for the Strapi application"
  type        = string
}

variable "react_docker_image" {
  description = "The Docker image for the React application"
  type        = string
}
