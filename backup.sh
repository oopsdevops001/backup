#!/bin/sh
set -x
set -e
env
echo "current working dir: `pwd`"
if [ -z "$SRC" ];
then
echo '$src variable is not set.'
exit 1
fi

if [ -z "$TARGET" ];
then
echo '$target variable is not set.'
exit 1
fi

if [ -z "$BACKUP_NAME" ];
then
export BACKUP_NAME=backup_data
fi

rclone copy $SRC $BACKUP_NAME
zipfilename="$(date +%Y%m%d).zip"
if [ -z "$PASSWORD" ];
then
zip -r ${zipfilename} $BACKUP_NAME
else
zip -P $PASSWORD -r ${zipfilename} $BACKUP_NAME
fi
./rclone copy ${zipfilename} $TARGET
rm ${zipfilename}
