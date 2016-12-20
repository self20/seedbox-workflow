#!/bin/bash
#
# includes
script="/tmp/seedbox-workflow"
"$script"/inc/variables.sh

clear

# ajout depo
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update

#install dependances
apt-get install oracle-java8-installer -y

# install filebot
cd /tmp
wget "http://freefr.dl.sourceforge.net/project/filebot/filebot/FileBot_4.7.2/FileBot_4.7.2-portable.zip"
unzip FileBot_4.7.2-portable.zip -d filebot
cp -R filebot /home/"$usersickrage"/.filebot
chown -R "$usersickrage":"$usersickrage" /home/"$usersickrage"/.filebot
chmod a+x /home/"$usersickrage"/.filebot/filebot.sh
chmod a+x /home/"$usersickrage"/.filebot/update-filebot.sh

# creation des repertoires
mkdir /home/"$usersickrage"/Media
chown "$usersickrage":"$usersickrage" /home/"$usersickrage"/Media
chmod 755 /home/"$usersickrage"/Media

# script reliant rtorrent a filebot
cp /tmp/"$script"/datas/rtorrent-postprocess /home/"$usersickrage"/rtorrent-postprocess
chown "$usersickrage":"$usersickrage" /home/"$usersickrage"/rtorrent-postprocess
chmod a+x /home/"$usersickrage"/rtorrent-postprocess

cd "$script"
./seedbox-workflow.sh
