output "ip_address" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "hostname" {
  value = azurerm_public_ip.public_ip.fqdn
}