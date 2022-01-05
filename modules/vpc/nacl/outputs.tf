output "public_network_acl_id" {
  description = "ID of the public network ACL"
  value       = concat(aws_network_acl.this.*.id, [""])[0]
}