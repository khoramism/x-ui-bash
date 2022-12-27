
REAL_IP=$(curl -s -m 5 ifconfig.io)
mkdir x-ui && cd x-ui
docker-compose up -d
echo "you can visit it at http://$REAL_IP:54321 /n Remember to change the port and password of panel"