terraform {
  required_version = "~> 0.12.8"
}

provider "google" {
  version = "~> 2.15"
  project = var.project
  region  = var.region
}


resource "google_compute_instance" "app" {
  count = var.instance_count
  name         = "reddit-app${count.index}"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  tags         = ["reddit-app"]
  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    # путь до публичного ключа
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface[0].access_config[0].nat_ip
    user  = "appuser"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

module "gce-lb-fr" {
  source       = "./loadbalancer"
  region       = var.region
  name         = "group1-lb"
  service_port = 9292
  target_tags  = ["reddit-app"]
  instances = [for instance in google_compute_instance.app : instance.self_link]
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"
  # Название сети, в которой действует правило
  network = "default"
  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]
  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}

resource "google_compute_project_metadata_item" "ssh-keys" {
  key   = "ssh-keys"
  value = join("\n", [for name in ["1", "2", "3"] : "appuser${name}:${chomp(file(var.public_key_path))}"])
}
