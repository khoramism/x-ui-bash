#/bin/bash 

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

cat Greetings_file.txt

REAL_IP=$(curl -s -m 5 ifconfig.io)
#echo $REAL_IP

echo "${red}PLEASE ANSWER THESE QUESTIONS ${reset}"

echo "where is your server located ${red}bridge(Iran)${reset} or ${green}Upstream${reset}?"
read Location
if [ "$Location" = "Upstream" ] || [ "$Location" = "upstream" ] || [ "$Location" = "not iran" ]  ; then
    echo $Location is located out of iran
    $OutsideIran = true
else
    echo $Location is located in iran 
    $OutsideIran = false
fi

echo "would you like to add a domain or subdomain name ${red}yes(y)${reset} or ${green} no (n) ${reset}?"
read doesContainDomain 
if [ "$doesContainDomain" = "y" ] || [ "$doesContainDomain" = "yes" ] ; then
    echo "Please Enter your subdomain or domain name"
    read DomainName
    echo "Your domain name is $DomainName which should point to $REAL_IP at your dns resolver /n with the proxy option greyed or off"
    echo "let's install acme and socat for ssl "
    apt install curl socat -y
    curl https://get.acme.sh | sh
    echo "remember that we need to open port ${red} 80 ${reset} for socat server."
    echo "Set the default provider to Let’s Encrypt:"
    ~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    echo "please provide a valid email address to register in letsencrypt"
    read ValidEmail 
    ~/.acme.sh/acme.sh --register-account -m xxxx@xxxx.com
    ~/.acme.sh/acme.sh --issue -d $DomainName --standalone
    echo "we have successfuly granted the ssl keys now let's move them"
    mkdir -p /root/cert
    ~/.acme.sh/acme.sh --installcert -d $DomainName --key-file /root/cert/private.key --fullchain-file /root/cert/cert.crt
    SSL_DONE = true
else
    echo "let us move on then"
    SSL_DONE = true   
fi 

echo "would you like a ${red}x-ui${reset} or ${green}just a vmess ${reset}?"
read TypeOfService 

if [ "$TypeOfService" = "x-ui" ] || [ "$TypeOfService" = " x-ui" ] || [ "$TypeOfService" = "xui" ]  ; then
    echo $TypeOfService is x-ui
    UseXUI = true
else
    echo $TypeOfService vmess we will use milad rahimi repo  
    UseXUI = false
fi

apt-get install -y ncurses
cat ./Greetings_file.txt


if  [ "$SSL_DONE" = true ] && [ "$UseXUI" = true ]   ; then 
    bash ./install_x_ui_docker.sh 
fi

echo "Now let's install Docker!"
bash install_docker.sh 
echo "docker installed!"

if "$UseXUI" = false && "$OutsideIran" = true  ; then 
    bash ./install_v2ray_upstream.sh 
fi 