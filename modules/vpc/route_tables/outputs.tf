output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = aws_route_table.public.*.id
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = aws_route_table.private.*.id
}

//output "intra_route_table_ids" {
//  description = "List of IDs of intra route tables"
//  value       = aws_route_table.intra.*.id
//}