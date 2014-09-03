# Backup Scripts [v1.0]
***


This is a small collection of backup scripts I have used over the years. They are general enough that they may be of use to people with some simple tweaks. As always, when performing system actions be mindful of what you type, and triple check everything if using dd.

**Note**: This is one of my earliest works, back from 2010. As such, I am posting this purely for historic reasons - the code is pretty ugly, and these days I use much better methods.


### Usage

#### BackResSys

This performs a tar.gz backup of a system, excluding certain directories.

- `backressys.conf` contains various configurations, such as directories to exclude, naming convention of the target file, etc.
- `baksys.sh` is the backup script
- `restoresys.sh` is the restore script

#### Rsync2Img

See the README in the folder.

### FAQ

> Should I use this code?
s
BackResSys is pretty old, and essentially is a simple wrapper for tar.gz. There are better tools out there. The Rsync2Img tools is much better, and works as intended. 

#### License

All of these files are licensed with GPL. I hope they are useful to some.

#### Contributors

Ivan Smirnov
