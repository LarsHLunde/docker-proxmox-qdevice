# docker-proxmox-qdevice
A Docker instance made to run as third quorom disk for a 2 server Proxmox Cluster

## How to install
```
git clone https://github.com/LarsHLunde/docker-proxmox-qdevice.git
cd docker-proxmox-qdevice
docker build -t qdevice .
docker run \
  -p 5403:5403 \
  -p 22:2222 \
  --name qdevice \
  --restart unless-stopped \
  qdevice
docker start qdevice
```