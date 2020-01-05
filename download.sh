#/usr/bin/env sh

# Copyright (c) 2019 Joseph R. Quinn <quinn.josephr@protonmail.com>
# SPDX-License-Identifier: ISC

for _fpath in AIX BSD Cygwin Darwin Debian Mandriva openSUSE Redhat Solaris; do
	rm -rf Completion/$_fpath
	sed "s#\s*Completion/$_fpath/\*/\*##g" -i Src/Zle/complete.mdd
done

rm -Rf ./Test/{A01grammar,V09datetime}.ztst