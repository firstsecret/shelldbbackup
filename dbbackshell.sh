#!/bin/bash

# 
# backup path
BACKUP=/data/backup/db

DATETIME=$(date +%Y_%m_%d_%H%M%S)
#echo $DATETIME

echo "--------------begin backup-------------------"
echo "--backup path = $BACKUP/$DATETIME.tar.gz--"

#host
HOST=localhost
#user
DB_USER=root
#passwd
DB_PWD=root
#db
DATABASE=data
[ ! -d "$BACKUP/$DATETIME" ] && mkdir -p "$BACKUP/$DATETIME"

mysqldump -u${DB_USER} -p${DB_PWD} --host=$HOST $DATABASE | gzip > $BACKUP/$DATETIME/$DATETIME.sql.gz

cd $BACKUP

tar -zcvf $DATETIME.tar.gz $DATETIME
rm -rf $BACKUP/$DATETIME

find $BACKUP -mtime +10 -name "*.tar.gz" -exec rm -rf {} \;

echo "==========backup successful!!=========";

