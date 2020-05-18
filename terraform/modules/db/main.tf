resource "google_compute_instance" "db" {
  name         = "reddit-db"
  machine_type = "g1-small"
  tags         = ["reddit-db"]
  zone         = var.zone
  boot_disk {
    initialize_params {
      image = var.db_disk_image
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

//  connection {
//    type  = "ssh"
//    host  = self.network_interface[0].access_config[0].nat_ip
//    user  = "appuser"
//    agent = false
//    private_key = file(var.private_key_path)
//  }
//
//  provisioner "remote-exec" {
//    inline = [
//      "cat /etc/mongod.conf",
//      "sudo sed -i 's/  bindIp.*/  bindIp: 127.0.0.1,${self.network_interface.0.network_ip}/' /etc/mongod.conf",
//      "sudo service mongod restart",
//    ]
//  }
}

resource "google_compute_firewall" "firewall_mongo" {
  name    = "allow-mongo-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }
  target_tags = ["reddit-db"]
  source_tags = ["reddit-app"]
}
