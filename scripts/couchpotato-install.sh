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

cd "$script"
./seedbox-workflow.sh
