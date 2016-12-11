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
# Multi utilisateurs.
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


# includes
INCLUDES="inc"
# shellcheck source=/dev/null
. "$INCLUDES"/variables.sh


# rendre executable les scripts
chmod -R +x "$script"/*.sh
clear


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
echo "H5ai              (https://larsjung.de/h5ai/)
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
echo " "
echo "5.  Installation Config Nginx"
echo "6.  Installation de Cerbot"
echo ""
echo "7.  Installation Complete"
echo " "
echo "9.  Reboot"
echo "0.  Exit"
echo ""
echo ""
read -p "Entrer votre choix: " menu
if [ $menu = "1" ]
then
        "$script"/seedbox-install.sh
elif [ $menu = "2" ]
then
        "$script"/sickrage-install.sh
elif [ $menu = "3" ]
then
        "$script"/filebot-install.sh
elif [ $menu = "4" ]
then
        "$script"/couchpotato-install.sh
elif [ $menu = "5" ]
then
        "$script"/nginx-conf.sh
elif [ $menu = "6" ]
then
        "$script"/certbot.sh
elif [ $menu = "7" ]
then
        "$script"/full-install.sh
elif [ $menu = "9" ]
then
        reboot
elif [ $menu = "0" ]
then
        clear echo "Bye"
else
        echo "Bye Bye"
fi
exit
