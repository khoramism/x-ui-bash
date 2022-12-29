#/bin/bash
apt install -y apt-utils
sleep 1
apt-get remove docker docker-engine docker.io containerd runc
sleep 1 
apt-get update 
sleep 1 
apt-get install -y ca-certificates curl gnupg lsb-release git cron
sleep 1 
apt-get update
sleep 1  
curl -fsSL https://get.docker.com -o get-docker.sh
sleep 1 
sh get-docker.sh
groupadd docker
sermod -aG docker $USER
newgrp docker
