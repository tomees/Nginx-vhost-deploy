VHOST=`echo $REPO | sed -r 's|git@([a-z0-9.]+):([a-z0-9\-]*/)*||;s|.git||'`
WEB_DIR=$WEB_DIR/$VHOST



if [ ! -d $WEB_DIR ]; then
	echo "Klonuji repozitář ..."
	git clone $REPO $WEB_DIR
else
	if [ ! -z $3 ] && [ $3 == "--force" ]; then
		echo "Mažu adresář $WEB_DIR ..."
		sudo rm -R $WEB_DIR
		echo "Klonuji repozitář ..."
		git clone $REPO $WEB_DIR
	else
		echo "CHYBA: Složka s webem pro toto repo již existuje, použijte příkaz 'deploy.sh create \$repo --force'"
		exit 1
	fi
fi
