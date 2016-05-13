#!/bin/bash
cd `dirname $0`

for i in `find .  -maxdepth 1 -and -not -name sources -and -not -name '.*' -type d`
do
    rm -rf $i
done

rm -rf index.html index.rss local.css style.css favicon.ico
rm -rf sources/archives

ikiwiki-calendar -f setup
ikiwiki --setup setup
