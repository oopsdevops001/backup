#!/bin/sh

if [ -z $SRC ];
then
echo '$src variable is not set.'
exit 1
fi

if [ -z $TARGET ];
then
echo '$target variable is not set.'
exit 1
fi

if [ -z $BACKUP_NAME ];
then
echo '$backup_name file is not set.'
exit 1
fi

rclone copy $SRC $BACKUP_NAME
zipfilename="$(date +%Y%m%d).zip"
zip -r ${zipfilename} $BACKUP_NAME
./rclone copy ${zipfilename} $TARGET/$BACKUP_NAME/${zipfilename}
rm ${zipfilename}
