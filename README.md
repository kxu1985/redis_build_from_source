# Install Redis on Ubuntu 18.04

## Install from distribution package
Reference: https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-18-04
- Run `sudo apt update`
- Run `sudo apt install -y redis-server`
- Run `sudo vim /etc/redis/redis.conf`
- Change `supervised no` to `supervised systemd`
- Run `sudo systemctl restart redis.service`
- Check redis service status by running `sudo systemctl status redis`
- Launch CLI by running `redis-cli`
- Test by typing `ping`
- Test by typing `set <key> <value>`
- Test by typing `get <key>`
  
## Install from source
Reference: https://www.digitalocean.com/community/tutorials/how-to-install-redis-from-source-on-ubuntu-18-04
- Run `sudo apt update`
- Run `sudo apt-get -y install build-essential tcl`
- Run `curl -O http://download.redis.io/redis-stable.tar.gz`
- Run `tar xzvf redis-stable.tar.gz`
- Run `cd redis-stable`
- Run `make`
- Run `sudo make install`
- Run `sudo mkdir /etc/redis`
- Run `sudo cp ~/redis-stable/redis.conf /etc/redis`
- Run `sudo sed -i "s/#\ supervised\ auto/supervised\ systemd/" /etc/redis/redis.conf`
- Run `sudo sed -i "s/dir\ .\//dir\ \/var\/lib\/redis/" /etc/redis/redis.conf`
- Run 
```
cat <<EOF | sudo tee /etc/systemd/system/redis.service
[Unit]
Description=Redis In-Memory Data Store
After=network.target

[Service]
User=redis
Group=redis
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always

[Install]
WantedBy=multi-user.target
EOF
```
- Run `sudo adduser --system --group --no-create-home redis`
- Run `sudo mkdir /var/lib/redis`
- Run `sudo chown redis:redis /var/lib/redis`
- Run `sudo chmod 770 /var/lib/redis`
- Run `sudo systemctl start redis`
- Run `sudo systemctl status redis`
- Launch CLI by running `redis-cli`
- Test by typing `ping`
- Test by typing `set <key> <value>`
- Test by typing `get <key>`

## Install Redis from Script (Optional)
- Run `bash redis_install.sh`
