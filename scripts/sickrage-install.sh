#!/bin/bash
#
# includes
script="/tmp/seedbox-workflow"
"$script"/inc/variables.sh
# shellcheck source=/dev/null
. "$script"/inc/func.sh

clear

echo "Installation de Sickrage"
echo ""
echo "Attention l'utilisateur de sickrage doit correspondre a celui de rtorrent."
read -p "Appuyer sur une touche pour continuer ..."

# choix chemin d'installation
read -p "Chemin d'installation: " dirsickrage
#echo -e "dirsickrage=\"$dirsickrage\"" >> "$variables"

# Choix utilisateur
read -p "Entrer l'utilisateur qui executera sickrage: " usersickrage

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
cd "$script"
./seedbox-workflow.sh
