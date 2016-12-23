#!/bin/bash
#
# includes
script="/tmp/seedbox-workflow"
"$script"/inc/variables.sh

cd /var/www/base
wget http://release.larsjung.de/h5ai/h5ai-0.29.0.zip
unzip h5ai-0.29.0.zip

