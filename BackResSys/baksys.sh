#!/bin/sh

## Calling variables to create filename.
 
LOGFILE="/var/log/bakressys/backup.log"
 
TODAY=$(date +"%y-%m-%d")

HOST=$(hostname)

DISTRO=$(
cat /etc/*-release > /tmp/name.txt
cut -d'=' -f2- /tmp/name.txt > /tmp/name2.txt
sed '3!d' /tmp/name2.txt
rm /tmp/name.txt /tmp/name2.txt
)

## the directories that are excluded, their permissions will be backed up, but not the contents
DIRS="/proc /media /lost+found /mnt /sys"

## location of backup directory. it is excluded from the backup automatically
BAKLOC=$(
/backup/location/
)

## defining the name of the backup
filename="$HOST.$DISTRO.$TODAY.tgz"

## sourcing the config file - I'm putting this after my default variables so that the script has a default
## set of variables it can return to - excluding directories, backup location, etc.

	CONF="/etc/backressys.conf"
	# If the file exists we can use it:
	if [ -f "${CONF}" ]; then
		# the safeguard for those that didn't bother to configure things
		# is that the default backup location is "/backup/location/", and odds are
		# that particular path does not exist. There is a very small chance that it does.
 
		## source "${CONF}" - before I run this command, clean the file from possible mistakes/hacks
		configfile="$CONF"
		configfile_secured='/tmp/backressys-safe.conf'

		# check if the file contains something we don't want
		if egrep -q -v '^#|^[^ ]*=[^;]*' "$configfile"; then
			#echo "Config file is unclean, cleaning it..." >&2
			# filter the original to a new file
			egrep '^#|^[^ ]*=[^;&]*'  "$configfile" > "$configfile_secured"
			configfile="$configfile_secured"
		fi

		# now source it, either the original or the filtered variant
		source "$configfile"

	else
		# Woops, no config:
		echo "You didn't set a configuration file, exiting."; exit 127;
	fi

# Done with the config file, commence with the rest of the script






##--------------------------------end variables-----------------------------------##

## check that backup location exists
if [ -d "${BAKLOC}" ]; then
else
 # Directory not found
 echo "Backup location does not exist, exiting."; exit 127;
fi


## if "${BAKLOC}/permissions.dat" file doesn't exist, create it and save permissions for excluded dirs
[ -e "${BAKLOC}/permissions.dat" ] || for DIR in $DIRS; do echo "${DIR} $(stat -c "%a %u %g" "${DIR}")"; done > "${BAKLOC}/permissions.dat"

## create the tarball,
tar cvpzf $BAKLOC$filename --exclude=/proc --exclude=$BAKLOC --exclude=/lost+found --exclude=/media --exclude=/mnt --exclude=/sys /

## md5sum the tarball, put the sum in the same directory
md5sum $BAKLOC$filename > $BAKLOC$filename.md5sum

