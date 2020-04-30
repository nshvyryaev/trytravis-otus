variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
  # Значение по умолчанию
  default = "europe-west1"
}
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "europe-west1-b"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable disk_image {
  description = "Disk image"
}
variable private_key_path {
  # Описание переменной
  description = "Path to the private key used for ssh access"
  default     = "~/.ssh/appuser"
}
variable instance_count {
  description = "Count of instances to run"
  default     = 2
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db"
}
variable ssh_ip_ranges {
  description = "List of allowed IP for SSH connection"
  default     = ["0.0.0.0/0"]
}
