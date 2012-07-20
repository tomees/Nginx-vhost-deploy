#!/bin/bash

CURRENT_DIR=`dirname $0`

source $CURRENT_DIR/deploy/config.sh

case "$1" in
        create)
                echo "Deploy z GITu a vytvoření vhostu"
                echo "------------------------------------"
                REPO=$2
                source $CURRENT_DIR/deploy/create.sh
                echo "Repozitář naklonován."
                DOMAIN="$VHOST.local"
                echo $DOMAIN
                ;;

        vhost)
                echo "Vytvoření vhostu pro doménu"
                echo "------------------------------------"
                DOMAIN=$2
                source $CURRENT_DIR/deploy/vhost.sh
                echo "Hotovo!"
                ;;
        delete)
                echo "Smazání vhostu i zdrojových souborů"
                echo "------------------------------------"
                DOMAIN=$2
                source $CURRENT_DIR/deploy/delete.sh

                echo "Hotovo!"
                ;;
        *)
                echo "Usage: xx {start|stop|restart|reload|force-reload|status|configtest}" >&2
                exit 1
                ;;
esac


