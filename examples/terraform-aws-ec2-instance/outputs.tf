output "resources" {
  description = "Map of all EC2 resources created by the example."
  value       = module.app_ec2.resources
}
