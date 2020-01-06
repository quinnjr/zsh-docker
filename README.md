# quinnjr/zsh-docker

![Build Status](https://api.travis-ci.org/quinnjr/zsh-docker.svg?branch=master)

A small, statically compiled [Z-shell](https://zsh.org) container.

## Differnces with zsh-users/zsh-docker

|Name|Latest Image|Size|Volumes|
|----|------------|----|-------|
|[zshusers/zsh](https://hub.docker.com/r/zshusers/zsh)|Daily build|64.1 MB|None|
|[quinnjr/zsh-docker](https://hub.docker.com/r/quinnjr/zsh-docker)|Latest stable release|9.2 MB|/etc/zsh<br/>/usr/share/zsh/functions<br/>/usr/share/zsh/scripts|

## Current Available versions
- v5.7.1 _[latest]_
- 5.7
- 5.6.2
- 5.6.1
- 5.6
- 5.5.1
- 5.5
- 5.4.2
- 5.4.1
- 5.4
- 5.3.1
- 5.3
- 5.2
- 5.1.1
- 5.1
- 5.0.8
- 5.0.7
- 5.0.6
- 5.0.5
- 5.0.4
- 5.0.3
- 5.0.2
- 5.0.1
- 5.0.0
- 4.3.17

(Further 4.x versions can be made upon request)

## Todo
- Minimize initial dependecies.
- Work around lousy Yodl dependency for documentation generation.
- Consider droping gdbm
