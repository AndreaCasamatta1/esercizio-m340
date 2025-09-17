#!/bin/bash
# Fonte: https://httpd.apache.org/docs/2.4/
# Installo Apache + PHP e abilito i moduli necessari

set -e

sudo apt-get update -y
sudo apt-get install -y apache2 php php-mysql libapache2-mod-php

sudo systemctl enable --now apache2
echo "WEB pronto, DocumentRoot montata via synced_folder"
