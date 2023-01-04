# import os
import re
import json

###fils addr
config_file_addr='config.json'
acsess_LOG_file_addr="acsess.log"

###reading json
f = open(config_file_addr)
config = json.load(f)
f.close()
###UNBLOCK ALL 
for inbounds in config['inbounds']:
    try:
        for clients in inbounds['settings']['clients']:
            if  re.search("[BLOCKED]", clients['id']):
                clients['id']=clients['id'].replace("[BLOCKED]", "")
            else:
                pass
    except:
        pass
###write to config.json
jsonString = json.dumps(config)
jsonFile = open(config_file_addr, "w")
jsonFile.write(jsonString)
jsonFile.close()
###reading acsess_log
my_file = open(acsess_LOG_file_addr, "r")
data = my_file.read()
my_file.close()
### deleteling file
# if os.path.exists("acsess.log"):
#   os.remove("acsess.log")
# else:
#   pass
###check which user has how many ips
data_list = data.split("\n")
data_dict={}
for data in data_list:
    x = re.findall("\d*\/\d*\/\d* \d*:\d*:\d* (\d*.\d*.\d*.\d*):\d* .* email: (.*@.*\..*)", data)
    try :
        email=x[0][1]
        ip=x[0][0]
        if email in data_dict:
            if not ip in data_dict[email]:
                data_dict[email]+=[ip]
            else:
                pass
        else:
            data_dict[email]=[ip]
    except:
        pass

for data in data_dict:
    data_dict[data]=len(data_dict[data])

restrictedUsers_dict = {key:value for (key, value) in data_dict.items() if value >= 4}
restrictedUsers_emails=restrictedUsers_dict.keys()

#print(list(restrictedUsers_emails))
###reading json
f = open(config_file_addr)
config = json.load(f)
f.close()
###BLOCK ALL restrictedUsers
for inbounds in config['inbounds']:
    try:

        for clients in inbounds['settings']['clients']:
            try:
                if  clients['email'] in restrictedUsers_emails:
                    clients['id']=clients['id']+"[BLOCKED]"
                else:
                    pass
            except:
                pass

    except:
        pass
    
#print(config)

###write to config.json
jsonString = json.dumps(config)
jsonFile = open(config_file_addr, "w")
jsonFile.write(jsonString)
jsonFile.close()

###restart docker or v2ray

