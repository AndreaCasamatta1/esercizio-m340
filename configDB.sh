#!/bin/bash
# Installaa MariaDB, la lega all'IP interno e crea DB + utente non-root limitato alla web
# si ferma all'errore
set -e

DB_USER="user"
DB_PASS="pass"
DB_NAME="multimacchina"
WEB_IP="10.10.20.10"
DB_IP="10.10.20.11"

sudo apt-get update -y
sudo apt-get install -y mariadb-server

# Fonte: https://mariadb.com/kb/en/server-system-variables/#bind_address
# Imposto bind-address sull'IP interno della VM db (gestisce anche righe commentate)
sudo sed -i -E "s/^[#[:space:]]*bind-address\s*=.*/bind-address = ${DB_IP}/" /etc/mysql/mariadb.conf.d/50-server.cnf

sudo systemctl enable --now mariadb

# Creo DB e utente applicativo limitato all'IP della web; utf8mb4 = pieno supporto Unicode/emoji
sudo mysql -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
sudo mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'${WEB_IP}' IDENTIFIED BY '${DB_PASS}';"
sudo mysql -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'${WEB_IP}';"
sudo mysql -e "FLUSH PRIVILEGES;"
# Applico le modifiche
sudo systemctl restart mariadb
echo "DB pronto su ${DB_IP}:3306; DB=${DB_NAME}; utente=${DB_USER}@${WEB_IP}"