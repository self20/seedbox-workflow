#!/bin/bash
#
# includes
INCLUDES="inc"
# shellcheck source=/dev/null
. "$INCLUDES"/variables.sh


echo "Installation de Rutorrent-bonobox"
echo ""
echo "Ne pas redémmarer a la fin de l'installation"
echo ""
read -p "Appuyer sur une touche pour continuer ..."
# Mise a jour
apt-get update && apt-get upgrade -y

# installation de git
apt-get install git-core -y

# Clone de rutorrent-bonobox
cd /tmp
git clone https://github.com/exrat/rutorrent-bonobox
cd rutorrent-bonobox

# Installation de rutorrent-bonobox
chmod a+x bonobox.sh && ./bonobox.sh
read -p "Appuyer sur une touche pour continuer ..."

# Retour au Menu principal
cd /tmp/seedbox-workflow
./seedbox-workflow.sh
