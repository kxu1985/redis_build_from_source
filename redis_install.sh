sudo apt update
sudo apt-get -y install build-essential tcl
curl -O http://download.redis.io/redis-stable.tar.gz
tar xzvf redis-stable.tar.gz
cd redis-stable
make
sudo make install
sudo mkdir /etc/redis
sudo cp ~/redis-stable/redis.conf /etc/redis
sudo sed -i "s/#\ supervised\ auto/supervised\ systemd/" /etc/redis/redis.conf
sudo sed -i "s/dir\ .\//dir\ \/var\/lib\/redis/" /etc/redis/redis.conf

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

sudo adduser --system --group --no-create-home redis
sudo mkdir /var/lib/redis
sudo chown redis:redis /var/lib/redis
sudo chmod 770 /var/lib/redis
sudo systemctl start redis
sudo systemctl status redis
