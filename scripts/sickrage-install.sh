#!/bin/bash
#
# includes
INCLUDES="inc"
# shellcheck source=/dev/null
. "$INCLUDES"/variables.sh

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
#echo -e "usersickrage=\"$usersickrage\"" >> "$variables"

# installation dépendances
apt-get install git-core python python-cheetah -y

# clone du repo sickrage et attribution des droits
git clone git://github.com/SickRage/SickRage.git "$dirsickrage"
cd "$dirsickrage"
chown -R "$usersickrage":"$usersickrage" "$dirsickrage"
cp "$dirsickrage"/runscripts/init.debian /etc/init.d/sickrage
chmod +x /etc/init.d/sickrage
echo -e "SR_USER=$usersickrage \nSR_HOME=$dirsickrage \nSR_DATA=$dirsickrage \nSR_GROUP=$usersickrage" >> /etc/default/sickrage
chown "$usersickrage":"$usersickrage" /etc/default/sickrage
update-rc.d sickrage defaults
service sickrage start
service sickrage stop
rm /opt/sickrage/config.ini
cp "$script"/datas/config-sickrage.ini "$dirsickrage"/config.ini
chown "$usersickrage":"$usersickrage" "$dirsickrage"/config.ini
service sickrage start
$exescript
