variable zone {
  description = "Zone"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app"
}
variable private_key_path {
  # Описание переменной
  description = "Path to the private key used for ssh access"
}
