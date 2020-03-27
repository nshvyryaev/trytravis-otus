# nshvyryaev_infra
nshvyryaev Infra repository

## HW3 Cloud bastion access
### Infrastructure
There are two instances:
bastion_IP = 35.189.220.151
someinternalhost_IP = 10.132.0.3

Only bastion has external IP.

### Connecting to the GCP hosts via SSH
Use bastion host to connect to an instance with internal IP only.

Connect in one command:
`ssh -i {identity_file} -A -t {user}@{bastion_external_IP} ssh {some_internal_host_IP}`

Connection command example:
`ssh -i ~/.ssh/otus/appuser -A -t appuser@35.189.220.151 ssh 10.132.0.3`

To use ssh alias `someinternalhost` add following config to your `~/.ssh/config`:
```text
Host someinternalhost
	ForwardAgent yes
	HostName 10.132.0.3
	User appuser
	IdentityFile ~/.ssh/otus/appuser
	ProxyCommand ssh -W %h:%p appuser@35.189.220.151
```

### VPN
VPN is based on Pritunl server. Configuration could be found at `cloud-bastion.ovpn`.

Pritunl web admin panel has valid TLS certificate
signed for `35-189-220-151.sslip.io` domain

## HW4 Cloud deploy
### Variables for testing
testapp_IP = 35.240.45.64
testapp_port = 9292
### Command to create instance with startup script
Execute from project root.
```bash
gcloud compute instances create reddit-app-auto\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=startup_script.sh
```

### Command to create firewall rule
```bash
gcloud compute firewall-rules create default-puma-server \
    --direction=INGRESS \
    --priority=1000 \
    --network=default \
    --action=ALLOW \
    --rules=tcp:9292 \
    --source-ranges=0.0.0.0/0 \
    --target-tags=puma-server
```

## HW5 Packer base
### Creating images with packer
Run commands from directory `packer`. Use `variables.json.example` to create files with variables.
#### Base image without application
Create `variables.json` file with required parameters.
Run `packer build -var-file=variables.json ubuntu16.json`
#### Full image with application
Create `immutable_variables.json` file with required parameters.
Run `packer build -var-file=immutable_variables.json immutable.json`
#### Create an instance using image
Run `create-reddit-vm.sh` to create an instance from full image.
No more actions needed - server will operate as soon as an instance will be ready.

## HW6 Terraform 1
Terraform configuration is added to the project. See `terraform` directory for configuration details.
Use `terraform.tfvars.example` as an example of what can be configured via variables.
### Adding multiple SSH keys
#### Found issues
SSH keys are stored in single variable 'ssh-keys', that means that Terraform:
1. Removes manually added keys
2. You need to concatenate username into value separating key and user with colon
3. You need to concatenate multiple keys into single value and separate them with new line
### Load balancing
Added using Google module `https://github.com/terraform-google-modules/terraform-google-lb`.
Code was copied to add instances to targets pool without auto scaling.

Use `instance_count` variable to set desired count of instances in load balancer targets pool.
