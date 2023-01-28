# shup
_Short for SHell setUP_

Quickly set up your favorite bash prompt, aliases, .nanorc, and more. Scripts set differing bash/nano colors when being run by the root user.

## Usage Example
When hosted on a PHP enabled server, all scripts can be listed and will be combined into one. This will include every script except for keys.sh.
```
curl -LSs shup.arix.cc | bash
```

To also include the keys.sh script, you must provide your github username, as such.
```
curl -LSs shup.arix.cc?gh=ArixZajicek | bash
```

To only run some scripts, you can list them out comma-separated in the run parameter.
```
curl -LSs shup.arix.cc?run=nano,bash | bash
```

Note again that to run the keys script, you must provide your github username.
```
curl -LSs shup.arix.cc?run=nano,keys&gh=ArixZajicek | bash
```

To get a list of available scripts, add the `list` param.
```
curl -LSs shup.arix.cc?list | bash
```

Alternatively, the individual scripts can be served statically and used without PHP. They just must be downloaded and executed individually (and pubkeys.sh must have the GH_USER environment variable set), i.e.:
```
curl -LSs arix.cc/shup/scripts/bash.sh | bash
curl -LSs arix.cc/shup/scripts/nano.sh | bash
curl -LSs arix.cc/shup/scripts/pubkeys.sh | GH_USER=ArixZajicek bash
```

## To-Do
- Remove `tput` from prompt colors, instead use raw character codes
- ~~Add single `all` option to set everything up without explictly listing each script~~ default behavior now
- ~~More dynamic config file handling~~ DONE
	- ~~Would be nice to just have an unpackable tarball for all files~~ No longer needed
- ~~Non-hard-coded URL path (use a .env file?)~~ No longer an issue
- ~~Allow root prompt without downloading script~~ Refactored, just run as root if you want root scripts
- ~~Switch `wget` to `curl`~~ DONE
- ~~Simplify .nanorc and .nanorc_root to only essential changes~~ DONE
