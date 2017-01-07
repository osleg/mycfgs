#!/bin/bash

ICONVBIN='/usr/bin/iconv' # path to iconv binary

if [[ $# -lt 3 ]]; then
    echo "$0 dir from_charset to_charset"
    exit
fi

for f in $(find $1 -type f); do
    echo "Converting $f"
    /bin/mv $f $f.old
    $ICONVBIN -f $2 -t $3 $f.old > $f
done
