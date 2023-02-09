# shup
_Short for SHell setUP_

Quickly set up your favorite bash prompt, aliases, .nanorc, and more!

## Rapid Usage
When hosted on a PHP enabled server, all scripts can be listed and will be combined into one for quick setup. The following will include every script except for those that require additional parameters.
```
curl -LSs shup.arix.cc | bash
```

To run all of the above and additionally include a script that periodically refreshes your `~/.ssh/authorized_keys` with those in your GitHub account, include your GitHub username.
```
curl -LSs shup.arix.cc?gh=ArixZajicek | bash
```

## Extended Usage
To get a list of available scripts first, add the `list` param.
```
curl -LSs shup.arix.cc?list | bash
```

To only run specific scripts, you can list them out comma-separated in the run parameter.
```
curl -LSs shup.arix.cc?run=nano,bash | bash
```

Some scripts (i.e. keys.sh and kcron.sh with `gh`) require extra variables to be passed. You may send those as additional GET parameters while still running all selected scripts at once.
```
curl -LSs 'shup.arix.cc?run=nano,keys&gh=ArixZajicek' | bash
```

## Offline Usage
Of course, the individual scripts can be served statically and used without PHP. They just must be downloaded and executed individually. Note that kcron.sh requires the keys.sh script to be manually copied first.
```
# .bash_aliases updates
curl -LSs shup.arix.cc/scripts/bash.sh | bash
# nano color and usefulness changes
curl -LSs shup.arix.cc/scripts/nano.sh | bash
# One-time github PK retrieval to authorized_keys
curl -LSs shup.arix.cc/scripts/keys.sh | GH_USER=ArixZajicek bash
# Periodic GitHub PK retrieval (keys.sh must be manually retrieved)
curl -LSs shup.arix.cc/scripts/keys.sh -o ~/.ssh/github_key_pull.sh && chmod +x ~/.ssh/github_key_pull.sh
curl -LSs shup.arix.cc/scripts/kcron.sh | GH_USER=ArixZajicek bash
```

## Remaining To-Dos
- none?
