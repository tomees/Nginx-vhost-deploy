#!/bin/bash
source config.sh
source functions.sh

o=(remove create)

if ! in_array "$1" "${o[@]}"; then
	echo "Tato funkce neexistuje"
fi

exit

CURRENT_DIR=`dirname $0`

if [[ "$1" == "remove" ]]; then
	echo "Mažu projekt"
	exit 1
fi

if [ -z $1 ]; then
	echo "No domain name given"
	exit 1
fi
DOMAIN=$1

# check the domain is roughly valid!
PATTERN="^([[:alnum:]]([[:alnum:]\-]{0,61}[[:alnum:]])?\.)+[[:alpha:]]{2,6}$"
if [[ "$DOMAIN" =~ $PATTERN ]]; then
	DOMAIN=`echo $DOMAIN | tr '[A-Z]' '[a-z]'`
	echo "Creating hosting for:" $DOMAIN
else
	echo "invalid domain name"
	exit 1 
fi

#Replace dots with underscores
SITE_DIR=`echo $DOMAIN | $SED 's/\./_/g'`

# Now we need to copy the virtual host template
CONFIG=$NGINX_CONFIG/$DOMAIN.conf
sudo cp $CURRENT_DIR/virtual_host.template $CONFIG
sudo $SED -i "s/DOMAIN/$DOMAIN/g" $CONFIG
sudo $SED -i "s!ROOT!$WEB_DIR/$SITE_DIR!g" $CONFIG

# set up web root
sudo mkdir $WEB_DIR/$SITE_DIR
sudo chown root:root -R $WEB_DIR/$SITE_DIR
sudo chmod 775 $CONFIG

# create symlink to enable site
sudo ln -s $CONFIG $NGINX_SITES_ENABLED/$DOMAIN.conf

# reload Nginx to pull in new config
sudo /etc/init.d/nginx reload

# put the template index.html file into the new domains web dir
sudo cp $CURRENT_DIR/index.html.template $WEB_DIR/$SITE_DIR/index.html
sudo $SED -i "s/SITE/$DOMAIN/g" $WEB_DIR/$SITE_DIR/index.html
sudo chown tomas:www-data $WEB_DIR/$SITE_DIR/index.html

echo "Site Created for $DOMAIN"
