variable "tenant_name" {
  description = "Name of the Tenant"
  type = string
}
variable "location" {
  description = "Region for hosting"
  type = string
}
variable "vm_size" {
  description = "Virtual Machine configuration"
  type = string
}
variable "vm_disk_size" {
  description = "Virtual Machine configuration"
  type = number
}
variable "git_pat" {
  description = "Personal access token for cloning git repo"
  type = string
}
variable "git_branch" {
  description = "Deployment branch"
  type = string
}
variable "shutdown_time" {
  description = "Enter value in mins for self shutdown"
  type = number
}
variable "expiration_hours" {
  description = "Enter value in hours for self termination"
  type = number
}
variable "nginx_server_ip" {
  description = "Enter the ip address of nginx server"
  type = string
}
variable "domain_name" {
  description = "Enter the your desired domain (weberp.xcelpros.com)"
  type = string
}
variable "sub_domain_name" {
  description = "Enter the your desired subdomain add, Will produce <subdomain>.weberp.xcelpros.com"
  type = string
}
variable "aws_region" {
  description = "Enter the region where the route53 is hosted"
  type = string
}
variable "aws_zoneid" {
  description = "Enter the zone id of the route53 hosing"
  type = string
}
variable "aws_access_key" {
  description = "Enter the aws_access_key to access route53 hosing"
  type = string
}
variable "aws_secret_key" {
  description = "Enter the aws_secret_key to access route53 hosing"
  type = string
}
variable "tenant_pem" {
  description = "Enter the tenant_pem to create ssh access to hosing"
  type = string
}
variable "nginx_pem" {
  description = "Enter the nginx_pem to access the nginx hosing"
  type = string
}
variable "env_source_content" {
  description = "Enter the sectrets for this project"
  type = string
}
