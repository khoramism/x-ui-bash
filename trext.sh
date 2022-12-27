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
else
    echo $Location is located in iran 
fi

echo "would you like to add a domain or subdomain name ${red}yes(y)${reset} or ${green} no (n) ${reset}?"
read doesContainDomain 
if [ "$doesContainDomain" = "y" ] || [ "$doesContainDomain" = "yes" ] ; then
    echo "Please Enter your subdomain or domain name"
    read DomainName
    echo "Your domain name is $DomainName which should point to $REAL_IP at your dns resolver /n with the proxy option greyed or off"
else
    echo "let us move on then"   
fi 

echo "would you like a ${red}x-ui${reset} or ${green}just a vmess ${reset}?"
read TypeOfService 

if [ "$TypeOfService" = "x-ui" ] || [ "$TypeOfService" = " x-ui" ] || [ "$TypeOfService" = "xui" ]  ; then
    echo $TypeOfService is x-ui
else
    echo $TypeOfService vmess we will use milad rahimi repo  
fi
