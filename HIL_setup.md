## Tunnel Setup Instructions

### 1. Raspberry Pi Initial Setup

1.1 Connect Raspberry Pi to internet  
1.2 Enable ssh

```bash
sudo raspi-config
```

### 2. Installations

3. Install updates

```bash
sudo apt update
sudo apt upgrade
```

4. Install Cloudflared

```bash
curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64.deb -o cloudflared.deb
sudo dpkg -i cloudflared.deb
```

5. Authenticate Cloudflare Tunnel
```bash
cloudflared tunnel login
```

6. Create New Tunnel
```bash
cloudflared tunnel create HILx
```

7. Configure Tunnel
```bash
sudo mkdir -p /etc/cloudflared
sudo nano /etc/cloudflared/config.yml
```

Add the following content to the `config.yml`
```yaml
tunnel: HIL2
credentials-file: /home/pi/.cloudflared/<tunnelID>.json

ingress:
  - hostname: hilx.ethananderson.dev
    service: ssh://localhost:22
  - service: http_status:404

```

8. Run the Tunnel
```bash
cloudflared tunnel run HILx
```

9. Set up Automatic Tunnel on Boot
```bash
sudo cloudflared service install
sudo systemctl enable cloudflared
```

10. Add another SSH Config Entry on Host Device
```bash
Host hilx.ethananderson.dev
  ProxyCommand /usr/bin/cloudflared access ssh --hostname %h

```
