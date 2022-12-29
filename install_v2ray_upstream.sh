cd v2ray-upstream-server
touch upstream_server_conf.txt
python3 setup_upstream_server.py 
REAL_IP=$(curl -s -m 5 ifconfig.io)
touch upstream_server_conf.txt
echo "IP : $REAL_IP" >> upstream_server_conf.txt
docker compose up -d
