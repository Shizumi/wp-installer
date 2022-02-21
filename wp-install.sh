#!/bin/bash

if ! type "wp" > /dev/null 2>&1; then
echo "This script requires the 'wp' command of 'wp-cli'.";
exit 1;
fi

echo -n "locale (ja) --> "
read LOCALE

if [ -z $LOCALE ] ; then
	LOCALE=ja
fi

while [ ! $DBNAME ]
do
	echo -n "DB Name --> "
	read DBNAME
done

while [ ! $DBUSER ]
do
	echo -n "DB User --> "
	read DBUSER
done

while [ ! $DBPASS ]
do
	echo -n "DB Pass --> "
	read -s DBPASS
done

echo -ne "\nDB Host (localhost) --> "
read DBHOST

if [ -z $DBHOST ] ; then
	DBHOST=localhost
fi

echo -n "DB Prefix (wp_) --> "
read DBPREFIX

if [ -z $DBPREFIX ] ; then
	DBPREFIX=wp_
fi

while [ ! $SITEURL ]
do
	echo -n "Site URL --> "
	read SITEURL
done

while [ ! $SITETITLE ]
do
	echo -n "Site title --> "
	read SITETITLE
done

while [ ! $ADMINUSER ]
do
	echo -n "Admin user --> "
	read ADMINUSER
done

while [ ! $ADMINEMAIL ]
do
	echo -n "Admin email --> "
	read ADMINEMAIL
done

echo -n "skip email? (y/N) --> "
read SKIPEMAIL

SKIP=
if [ "$SKIPEMAIL"=="y" ] ; then
	SKIP=--skip-email
fi


wp core download --locale=$LOCALE
wp config create --dbname=$DBNAME --dbuser=$DBUSER --dbpass="$DBPASS" --dbprefix=$DBPREFIX --dbhost=$DBHOST --locale=$LOCALE
wp core install --url="$SITEURL" --title="$SITETITLE" --admin_user=$ADMINUSER --admin_email=$ADMINEMAIL $SKIP
