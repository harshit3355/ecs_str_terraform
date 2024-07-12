output "react_alb_dns_name" {
  description = "The DNS name of the React ALB"
  value       = aws_lb.react.dns_name
}

output "strapi_alb_dns_name" {
  description = "The DNS name of the Strapi ALB"
  value       = aws_lb.strapi.dns_name
}

output "react_service_url" {
  description = "The URL of the React service"
  value       = "http://${aws_route53_record.react.name}"
}

output "strapi_service_url" {
  description = "The URL of the Strapi service"
  value       = "http://${aws_route53_record.strapi.name}"
}
