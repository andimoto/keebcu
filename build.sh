#!/bin/bash
scadFile=$1.scad
confFile=conf/$1.conf

echo $scadFile
echo $confFile
LINE=`grep -n BUILD_LINE $scadFile | cut -d : -f 1`
echo $LINE
