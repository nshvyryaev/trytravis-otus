variable zone {
  description = "Zone"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db"
}
variable private_key_path {
  description = "Path to the private key used for ssh access"
}
