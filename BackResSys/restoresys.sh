#!/bin/sh

BAKLOC=$(
/location/here/ ## same as the baksys location - use same config file
)

HOST=$(hostname)

## start script
## become root to get permission
su

cd /
##  extract backup file, find it by looking for HOST and tgz mark
tar -xvpfz "${BAKLOC}$HOST*.tgz" -C /

## recreate directories removed when backing up

mkdir "${DIRS}"
[ -e "${BAKLOC}/permissions.dat" ] && cat "${BAKLOC}/permissions.dat" | while read DIR MODE USER GROUP; do install -m $MODE -o $USER -g $GROUP $DIR; done
