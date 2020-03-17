# nshvyryaev_infra
nshvyryaev Infra repository

## Connecting to the GCP hosts via SSH
Use bastion host to connect to an instance with internal IP only.
Bastion host is `35.189.220.151`.

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
