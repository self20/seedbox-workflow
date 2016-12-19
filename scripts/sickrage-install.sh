#!/bin/bash
#
# includes
script="/tmp/seedbox-workflow"
"$script"/inc/variables.sh

clear

echo "Installation de Sickrage"
echo ""
echo "Attention l'utilisateur de sickrage doit correspondre a celui de rtorrent."
read -p "Appuyer sur une touche pour continuer ..."
echo ""
echo ""

# choix chemin d'installation
read -p "Chemin d'installation: " dirsickrage

# Choix utilisateur
cd "$script"
echo ""
read -p "Entrer l'utilisateur qui executera sickrage: " usersickrage
echo -e "usersickrage=\"$usersickrage\"" >> inc/variables.sh

# installation dépendances
apt-get install git-core python python-cheetah -y

# clone du repo sickrage et attribution des droits
git clone git://github.com/SickRage/SickRage.git "$dirsickrage"
cd "$dirsickrage"
chown -R "$usersickrage":"$usersickrage" "$dirsickrage"

# copie script demarrage et droit 
cp "$dirsickrage"/runscripts/init.debian /etc/init.d/sickrage
chmod +x /etc/init.d/sickrage
chown "$usersickrage":"$usersickrage" /etc/init.d/sickrage

# creation config demarrage 
echo -e "SR_USER=$usersickrage \nSR_HOME=$dirsickrage/ \nSR_DATA=$dirsickrage/ \nSR_GROUP=$usersickrage" >> /etc/default/sickrage
update-rc.d sickrage defaults
service sickrage start
sleep 5
service sickrage stop
sleep 5
cd "$script"/datas
cp config-sickrage.ini "$dirsickrage"/config.ini
chown "$usersickrage":"$usersickrage" "$dirsickrage"/config.ini
service sickrage start

# ajout a rutorrent.conf

sed -i '/fin config rutorrent/ a \\t## début config sickrage ##\nlocation /sickrage {\nproxy_pass        http://127.0.0.1:8081;\nproxy_redirect    off;\nproxy_set_header  Host             $http_host;\nproxy_set_header  X-Real-IP        $remote_addr;\nproxy_set_header  X-Forwarded-For  $proxy_add_x_forwarded_for;\n}' /etc/nginx/sites-enabled/rutorrent.conf
service nginx restart
cd "$script"
./seedbox-workflow.sh
