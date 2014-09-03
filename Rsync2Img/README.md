# Rsync Babylon Backup [v0.1]
***

### Goal  

`Rsync Babylon Backup` is a bash script that creates a [babylon tower backup](http://en.wikipedia.org/wiki/Backup_rotation_scheme#Grandfather-father-son) using 
rsync. It uses hard links in order to save space, and supports many options.


**Note**: Requires superuser permissions.


### Installation

Extract the files to any location, then adjust the cron entry of your set up accordingly.
Be sure to run the initial setup code located in the script.

	$ # create disk image -
	$ dd if=/dev/zero of=/location/of/backup.img bs=1M count=0 seek=4096 # seek is size in mb
	$ mke3fs -F backup.img # or mke2fs -j -F
	$ mount image 
	$ mount -o loop $BACKUP_IMAGE $MOUNT_POINT
	$ # Make directories
	$ mkdir -p $MOUNT_POINT/Daily/
	$ mkdir -p $MOUNT_POINT/Weekly/
	$ mkdir -p $MOUNT_POINT/Monthly/
	$

### Usage

You can either run the script manually, or configure cron.


### FAQ

> Is this stable?

Yes, I used it for a few months on an Ubuntu installation.


#### License

`Rsync Babylon Backup` is licensed with GPL. Go wild!

#### Contributors
Ivan Smirnov

Based on work by:
Andrew J. Nelson - http://webgnuru.com/linux/rsync_incremental.php  
Mike Rubel - http://www.mikerubel.org/computers/rsync_snapshots/  


