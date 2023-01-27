# shup
_Short for SHell setUP_

Quickly set up your favorite bash prompt, aliases, .nanorc, and more.

## Usage Example
`curl -LSs arix.cc/shup/index.php?bash&nano&pubkeys=ArixZajicek | bash`

## To-Do
- Add single `all` option to set everything up without explictly listing each script
- Remove `tput` from prompt colors, instead use raw character codes
- ~~More dynamic config file handling~~ DONE
	- ~~Would be nice to just have an unpackable tarball for all files~~ No longer needed
- ~~Non-hard-coded URL path (use a .env file?)~~ No longer an issue
- ~~Allow root prompt without downloading script~~ Refactored, just run as root if you want root scripts
- ~~Switch `wget` to `curl`~~ DONE
- ~~Simplify .nanorc and .nanorc_root to only essential changes~~ DONE
