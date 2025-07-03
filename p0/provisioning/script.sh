#!/bin/bash

if [ $# -ne 1 ]; then
       echo "Syntax error: $0 MOUNT_POINT"
       exit -1
fi

MOUNT_POINT=$1
DATABASE=`basename $MOUNT_POINT`
FILE=$MOUNT_POINT/info
INDEX=/var/www/html/index.php

if ! grep -qs "$MOUNT_POINT" /proc/mounts; then
	mount /dev/sdb $MOUNT_POINT
fi

apt update
apt-get -y install curl vim unzip lynx lshw
chown -R vagrant:vagrant $MOUNT_POINT
echo "CREATE DATABASE IF NOT EXISTS $DATABASE;" > /vagrant/dbserver/sql/db.sql

uname -a > $FILE
id >> $FILE
date >> $FILE
lsblk >> $FILE
VERSION=`cat /etc/debian_version`
echo "Debian $VERSION" >> $FILE
lshw -class storage -short >> $FILE

if [ -f "$FILE" ]; then
	cat $INDEX >> $FILE
else
	echo "$INDEX not found!" >> $FILE
fi
