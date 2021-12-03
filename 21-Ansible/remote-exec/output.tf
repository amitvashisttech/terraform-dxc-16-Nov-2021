output "frontend_ips" {
 value = aws_instance.frontend.*.public_ip
}

