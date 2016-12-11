#!/bin/bash
script="/tmp/seedbox-workflow"
service nginx stop
rm /etc/nginx/sites-enabled/rutorrent.conf
cp "$script"/datas/conf-nginx /etc/nginx/sites-enabled/rutorrent.conf
service nginx start
cd $script
./seedbox-workflow.sh
