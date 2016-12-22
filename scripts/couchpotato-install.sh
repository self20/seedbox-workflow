#!/bin/bash
#
# includes
script="/tmp/seedbox-workflow"
"$script"/inc/variables.sh
# includes
INCLUDES="inc"
# shellcheck source=/dev/null
. "$INCLUDES"/variables.sh

# installation dependances
apt-get install git-core python python-cheetah -y

# clone du repo
git clone https://github.com/CouchPotato/CouchPotatoServer.git /opt/couchpotato

# atribution des droits
chown -R "$usersickrage":"$usersickrage" /opt/couchpotato

# configuration demmarage
cp /opt/couchpotato/init/ubuntu /etc/init.d/couchpotato
echo -e "CP_HOME=/opt/couchpotato\nCP_USER=$usersickrage" >> /etc/default/couchpotato
chown "$usersickrage":"$usersickrage" /etc/default/couchpotato
chmod +x /etc/init.d/couchpotato
update-rc.d couchpotato defaults
service couchpotato start

# ajout t411
service couchpotato stop
cd /tmp
git clone https://github.com/djoole/couchpotato.provider.t411.git /tmp/t411
cd t411
cp -r t411 /var/opt/couchpotato/custom_plugins
chown "$usersickrage":"$usersickrage" /var/opt/couchpotato/custom_plugins/t411
service couchpotato stop

# proxy nginx
service couchpotato stop
sed -i '/fin config sickrage/ a \\t## début config couchpotato ##\nlocation /couchpotato {\nproxy_pass http://127.0.0.1:5050;\nproxy_set_header Host $host;\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n}\n\t## fin config couchpotato ##' /etc/nginx/sites-enabled/rutorrent.conf
sed -i "s/url_base =/url_base = \/couchpotato/" /var/opt/couchpotato/settings.conf
service couchpotato start
service nginx restart
cd "$script"
./seedbox-workflow.sh
