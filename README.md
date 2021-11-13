# shup
_Short for SHell setUP_
Set up your favorite bash prompt, aliases, and .nanorc on any system.

## Set-up
1. Host these files on a static or PHP-enabled site.
2. Edit `remotepath` in shup.sh to reflect the location of these files.

## Usage
Static site:
`curl -Ls arix.cc/shup/shup.sh | bash`

PHP-enabled site:
`curl -Ls arix.cc/shup | bash`

Note: Because of the nature of piping into a bash shell, it is not possible to respond 'yes' to the prompt asking if you would like to apply the configs for the root user. If you would like this prompt, you must download the file first, which can all be done with this line:

`curl -Ls arix.cc/shup > shup.sh && chmod 700 shup.sh && ./shup.sh && rm shup.sh`

## To-Do
- More dynamic .rc file handling
	- Would be nice to just have an unpackable tarball for all files
- Non-hard-coded URL path (use a .env file?)
- Allow root prompt without downloading script