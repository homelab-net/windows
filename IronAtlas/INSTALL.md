# Iron Atlas Tier 2 (CONUS, Meshtastic-only) Install Guide

## 1) Create folder structure

```bash
sudo mkdir -p /IronAtlas/{config,vault,bin,logs}
sudo mkdir -p /IronAtlas/vault/{caddy,uptime-kuma,grafana,mosquitto,node-red,maps,openwebrx,tak,meshtastic,rag-appliance}
sudo mkdir -p /IronAtlas/vault/maps/{mbtiles,osm}
sudo mkdir -p /IronAtlas/config/{frontend,mosquitto,graphhopper}

# Ownership (replace IronAtlas if your real username differs)
sudo chown -R IronAtlas:IronAtlas /IronAtlas
```

## 2) Install Docker and docker compose plugin

```bash
sudo apt update
sudo apt install -y docker.io docker-compose-plugin
```

## 3) Ensure Docker boots on start (required)

```bash
sudo systemctl enable docker
sudo systemctl start docker
systemctl is-enabled docker
```

## 4) Allow running docker without sudo (optional convenience)

```bash
sudo usermod -aG docker IronAtlas
```

Log out/in or reboot to apply group change.

## 5) Put compose file and configs in place

Copy this repository's `IronAtlas/` directory to `/IronAtlas` so the following exist:

- `/IronAtlas/docker-compose.yml`
- `/IronAtlas/config/Caddyfile`
- `/IronAtlas/config/frontend/index.html`
- `/IronAtlas/config/mosquitto/mosquitto.conf`
- `/IronAtlas/config/graphhopper/config.yml`
- `/IronAtlas/bin/usb-check.sh`

## 6) Create MQTT password

```bash
sudo touch /IronAtlas/config/mosquitto/passwordfile
sudo chown -R IronAtlas:IronAtlas /IronAtlas/config/mosquitto

docker run --rm -it \
  -v /IronAtlas/config/mosquitto:/mosq \
  eclipse-mosquitto:2 \
  sh -lc 'mosquitto_passwd -c /mosq/passwordfile IronAtlas'
```

## 7) Start stack

```bash
cd /IronAtlas
docker compose up -d
docker compose ps
```

## 8) Reboot test

```bash
sudo reboot
# after reboot
cd /IronAtlas
docker compose ps
```

## 9) Map data placement

- MBTiles: `/IronAtlas/vault/maps/mbtiles/`
- Routing PBF: `/IronAtlas/vault/maps/osm/conus.pbf`

## 10) Firewall hardening (UFW)

```bash
sudo apt update
sudo apt install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
# sudo ufw allow 22/tcp   # optional
sudo ufw enable
sudo ufw status verbose
```

## 11) Automatic security updates

```bash
sudo apt install -y unattended-upgrades
sudo dpkg-reconfigure -plow unattended-upgrades
```

## 12) USB auto-detection via udev

1. Identify devices:

```bash
ls -l /dev/serial/by-id/
dmesg --follow
```

2. Get IDs:

```bash
udevadm info -a -n /dev/ttyACM0 | head -n 120
```

3. Create rules:

```bash
sudo nano /etc/udev/rules.d/99-ironatlas-usb.rules
```

Template:

```udev
# GPS device -> /dev/ironatlas-gps
SUBSYSTEM=="tty", ATTRS{idVendor}=="XXXX", ATTRS{idProduct}=="YYYY", SYMLINK+="ironatlas-gps"

# Meshtastic serial device -> /dev/ironatlas-mesh
SUBSYSTEM=="tty", ATTRS{idVendor}=="AAAA", ATTRS{idProduct}=="BBBB", SYMLINK+="ironatlas-mesh"
```

4. Reload/test:

```bash
sudo udevadm control --reload-rules
sudo udevadm trigger
ls -l /dev/ironatlas-gps /dev/ironatlas-mesh
```

5. Run helper script anytime:

```bash
/IronAtlas/bin/usb-check.sh
```

## 13) Verification URLs

- `http://<appliance-ip>/`
- `http://<appliance-ip>/status/`
- `http://<appliance-ip>/grafana/`
- `http://<appliance-ip>/nodered/`
- `http://<appliance-ip>/tiles/`
- `http://<appliance-ip>/route/`
- `http://<appliance-ip>/sdr/`
- `http://<appliance-ip>/rag/`
- `http://<appliance-ip>/healthz`

## Notes

- `tak-server` and `meshtastic-bridge` are profile-gated placeholders (`tak`, `mesh`) so first boot works without selected images.
- RAG mount path is fixed: `/IronAtlas/vault/rag-appliance:/app`.
- Default credentials are username `IronAtlas` and password `RedDawn`; rotate before shipping.
