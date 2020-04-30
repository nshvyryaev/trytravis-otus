variable zone {
  description = "Zone"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app"
}
variable private_key_path {
  description = "Path to the private key used for ssh access"
}
variable db_internal_ip {
  description = "Database URL. Specify if other than localhost"
  default = "localhost"
}
variable db_external_ip {
  description = "Database IP for SSH"
}
