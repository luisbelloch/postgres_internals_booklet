#!/bin/sh
filename=`date "+pginternals-%Y%m%d.tar"`
test -e $filename.gz && rm $filename.gz
git archive --format=tar --output $filename HEAD
gzip -9 $filename
