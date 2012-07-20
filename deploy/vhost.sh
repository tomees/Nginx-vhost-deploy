#!/bin/bash

if [ -z $DOMAIN ]; then
	echo "No domain name given"
	exit 1
fi

# check the domain is roughly valid!
PATTERN="^([[:alnum:]]([[:alnum:]\-]{0,61}[[:alnum:]])?\.)+[[:alpha:]]{2,6}$"
if [[ "$DOMAIN" =~ $PATTERN ]]; then
	DOMAIN=`echo $DOMAIN | tr '[A-Z]' '[a-z]'`
	echo "Vytvářím vhost pro doménu" $DOMAIN
else
	echo "CHYBA: špatný formát domény"
	exit 1 
fi

#Replace dots with underscores
SITE_DIR=`echo $DOMAIN | $SED 's/\./_/g'`

# Now we need to copy the virtual host template
CONFIG=$NGINX_CONFIG/$DOMAIN
sudo cp $CURRENT_DIR/deploy/virtual_host.template $CONFIG
sudo $SED -i "s/DOMAIN/$DOMAIN/g" $CONFIG
sudo $SED -i "s!ROOT!$WEB_DIR/$SITE_DIR!g" $CONFIG

sudo chmod 600 $CONFIG

echo "Vhost $DOMAIN vytvořen"

sudo ln -s $CONFIG $NGINX_SITES_ENABLED/$DOMAIN

echo "Vhost $DOMAIN aktivován"