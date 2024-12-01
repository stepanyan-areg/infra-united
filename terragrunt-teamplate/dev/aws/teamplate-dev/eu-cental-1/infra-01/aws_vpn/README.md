# AWS VPN

Prerequisite:
- Openvpn client installed

To access VPN do the following after deploying the module:
1. Run the following command locally to get the full client config
```
cd aws_vpn
terragrunt init
terragrunt output -json full_client_configuration | jq -r . > dev-scanners-config.ovpn
```
2. Import the config file `dev-scanners-config.ovpn` in Openvpn client and save the new connection