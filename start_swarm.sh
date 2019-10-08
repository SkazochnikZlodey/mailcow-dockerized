# /bin/bash

mkdir -p /external/services/mail_server/{data,helper-scripts}
cp ./data /external/services/mails_server/data/postfix/custom.conf

cp ./helper-scripts /external/services/mails_server/helper-scripts
#echo "Create the overlay network that will be used for our stack (mailnetwork):"
docker network create --ip-range=172.22.1.0/24 --attachable --ipv6  --subnet fd4d:6169:6c63:6f77::/64 --driver=bridge mailcowdockerized_mailcow-network

echo Deploy the Mail_server Stack:

docker-compose pull

env $(cat .env | grep ^[A-Z] | xargs) docker stack deploy --compose-file mailserver-compose-swarm.yml mail_server

#docker-compose up -d


echo Waiting 5 sec.
sleep 5


echo Stacks review:

docker stack ls

echo ..Done ?..
