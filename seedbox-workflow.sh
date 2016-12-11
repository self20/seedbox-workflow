#!/bin/bash
#
# Script d'installation d'une seedbox workflow.
#
# Contenue: 
#
# Rutorrent-bonobox "https://github.com/exrat/rutorrent-bonobox"
# Sickrage "https://github.com/SickRage/SickRage"
# Couchpotato "https://github.com/CouchPotato/CouchPotatoServer"
# Plex "https://www.plex.tv/fr/"
# Filebot "http://www.filebot.net/"
# Tardistart "https://www.pastoutdesuite.fr/tardistart"
# H5ai "https://larsjung.de/h5ai/"
#
# 
# Installation pas a pas ou complete.
#
# Auteur: Luniun
# Je ne suis l'auteur que de ce script.
# Version: 1.0-alpha
#
# Prérequis:
#
# Un serveur dedier sous debian 8 fraichement installer.
# systmd et ca-certificates
# apt-get install systmd systemd-sysv ca-certificates -y
# Redémarrage neccesaire.
#
# Installation:
# git clone https://github.com/luniun/seedbox-workflow.git /tmp/seedbox-workflow
# chmod +x /tmp/seedbox-workflow/seedbox-workflow.sh
# cd /tmp/seedbox-workflow/
# ./seedbox-workflow.sh
clear

# includes
INCLUDES="inc"
# shellcheck source=/dev/null
. "$INCLUDES"/variables.sh

cd

# rendre executable les scripts
chmod +x "$script"/scripts/*.sh


# Introduction
echo "### Merci d'utiliser seedbox-workflow"
echo ""
echo "## Ce script permet d'installer :"
echo ""
echo "rutorrent-bonobox (https://github.com/exrat/rutorrent-bonobox)"
echo "Sickrage          (https://github.com/SickRage/SickRage)"
echo "Couchpotato       (https://github.com/sarakha63/persomov)"
echo "Plex Media Server (https://www.plex.tv/fr)"
echo "Filebot           (http://www.filebot.net)"
echo "TardiStart        (https://www.pastoutdesuite.fr/tardistart)"
echo "H5ai              (https://larsjung.de/h5ai/)"
echo ""
echo ""
read -p "Appuyer sur une touche pour continuer ..."
clear

# Menu
echo "Menu principal: "
echo ""
echo ""
echo "1.  installation de Rutorrent-bonobox"
echo "2.  installation de Sickrage"
echo "3.  installation de Filebot"
echo "4.  Installation de Couchpotato"
echo "5.  Installation de Tardistart"
echo "6.  Installation de h5ai"
echo "7.  Installation de plex"
echo " "
echo "8.  Installation Config Nginx"
echo "9.  Installation de Cerbot"
echo ""
echo "10.  Installation Complete"
echo ""
echo "11. Ajout/modifier Utilisateur"
echo ""
echo "0.  Exit"
echo ""
echo ""
read -p "Entrer votre choix: " menup
if [ $menup = "1" ]
then
        "$script"/scripts/seedbox-install.sh
elif [ $menup = "2" ]
then
        "$script"/scripts/sickrage-install.sh
elif [ $menup = "3" ]
then
        "$script"/scripts/filebot-install.sh
elif [ $menup = "4" ]
then
        "$script"/scripts/couchpotato-install.sh
elif [ $menup = "5" ]
then
        "$script"/scripts/tardistart.sh
elif [ $menup = "7" ]
then
        "$script"/scripts/plex.sh
elif [ $menup = "8" ]
then
        "$script"/scripts/nginx-conf.sh
elif [ $menup = "9" ]
then
        "$script"/scripts/certbot.sh
elif [ $menup = "10" ]
then
        "$script"/scripts/full-install.sh
elif [ $menup = "11" ]
then
        "$scrip"/scripts/user.sh
elif [ $menup = "0" ]
then
        clear
else
        echo "Bye Bye"
fi
exit
