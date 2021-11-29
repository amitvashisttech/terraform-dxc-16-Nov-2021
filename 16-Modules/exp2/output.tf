output "PublicIP_Frontend" {
  value = module.frontend.PublicIP_East_Frontend
}



output "PublicIP_Backend" {
  value = module.backend.PublicIP_East_Frontend
}
