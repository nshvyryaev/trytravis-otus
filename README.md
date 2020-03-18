# nshvyryaev_infra
nshvyryaev Infra repository

## Infrastructure
There are two instances:
* bastion_IP = 35.189.220.151
* someinternalhost_IP = 10.132.0.3

Only bastion has external IP.

## Connecting to the GCP hosts via SSH
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

## VPN
VPN is based on Pritunl server. Configuration could be found at `cloud-bastion.ovpn`.

Pritunl web admin panel has valid TLS certificate
signed for `35-189-220-151.sslip.io` domain
