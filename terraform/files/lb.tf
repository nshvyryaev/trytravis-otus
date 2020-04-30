module "gce-lb-fr" {
  source       = "./loadbalancer"
  region       = var.region
  name         = "group1-lb"
  service_port = 9292
  target_tags  = ["reddit-app"]
  instances    = [for instance in google_compute_instance.app : instance.self_link]
}
output "balancer_external_ip" {
  value = module.gce-lb-fr.external_ip
}
