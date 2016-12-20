#!/bin/bash


aptitude install alsa alsa-oss oss-compat libasound2-plugins -y
apt-get install curl -y
echo "deb http://shell.ninthgate.se/packages/debian jessie main" | tee -a /etc/apt/sources.list.d/plexmediaserver.list
curl http://shell.ninthgate.se/packages/shell.ninthgate.se.gpg.key | apt-key add -
apt-get update
apt-get install plexmediaserver -y
service plexmediaserver start
pause 5
service plexmediaserver stop
pause 2
service plexmediaserver start

cd /tmp/seedbox-workflow.sh
./seedbox-workflow.sh
