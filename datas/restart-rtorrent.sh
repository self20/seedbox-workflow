#!/bin/bash

for user in $usersickrage; do

   file=/home/$usersickrage/.session/rtorrent.lock # a adapter au besoin

   pid=$(ps -u $usersickrage -o pid,command | grep '[0-9] rtorrent$' | cut -d "r" -f1) # extraction du pid de rtorrent de l'utilisateur

   if [ ! $pid ];then # si rtorrent est actif pid ne sera pas vide
      rm -f $file # on supprime rtorrent.lock car ca peut empêcher rtorrent de démarrer
      bash /etc/init.d/$usersickrage-rtorrent restart
      echo "$(date) : le rtorrent de $usersickrage a ete redemarre" >> /var/log/rtorrent-check.log
   fi

done
