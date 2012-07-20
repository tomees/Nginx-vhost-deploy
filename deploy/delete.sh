#!/bin/bash

LN_FILE=$NGINX_SITES_ENABLED/$DOMAIN
CONFIG_FILE=$NGINX_CONFIG/$DOMAIN

if [ -f $LN_FILE ]; then
	sudo rm $LN_FILE
	echo "Vhost deaktivován"
else
	echo "Vhost nebyl aktivní"
fi

if [ -f $CONFIG_FILE ]; then
	sudo rm $CONFIG_FILE
	echo "Konfigurační soubor odstraněn"
else
	echo "Konfigurační soubor nenalezen"
fi