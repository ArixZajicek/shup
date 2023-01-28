# shup
_Short for SHell setUP_

Quickly set up your favorite bash prompt, aliases, .nanorc, and more. Scripts set differing bash/nano colors when being run by the root user.

## Usage Example
When hosted on a PHP enabled server, all scripts can be listed and will be combined into one.
```
curl -LSs arix.cc/shup?bash&nano&pubkeys=ArixZajicek | bash
```

Alternatively, the individual scripts can be served statically and used without PHP. They just must be downloaded and executed individually (and pubkeys.sh must have the GH_USER environment variable set), i.e.:
```
curl -LSs arix.cc/shup/scripts/bash.sh | bash
curl -LSs arix.cc/shup/scripts/nano.sh | bash
curl -LSs arix.cc/shup/scripts/pubkeys.sh | GH_USER=ArixZajicek bash
```

## To-Do
- Add single `all` option to set everything up without explictly listing each script
- Remove `tput` from prompt colors, instead use raw character codes
- ~~More dynamic config file handling~~ DONE
	- ~~Would be nice to just have an unpackable tarball for all files~~ No longer needed
- ~~Non-hard-coded URL path (use a .env file?)~~ No longer an issue
- ~~Allow root prompt without downloading script~~ Refactored, just run as root if you want root scripts
- ~~Switch `wget` to `curl`~~ DONE
- ~~Simplify .nanorc and .nanorc_root to only essential changes~~ DONE
