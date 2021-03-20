#!/bin/bash

#if you have not installed OpenSCAD over package manager, download OpenSCAD (as appImage for example)
#and set 'export OPENSCADPATH=<DIRECTORY>/OpenSCAD-***.appImage'

#check if openscad is available
#search in default PATH and then search if OPENSCADPATH is set
echo "Check OpenSCAD PATH..."
if [ -x openscad ]
then
	echo "OpenSCAD found..."
	OPENSCADPATH=openscad
else
  if [ -z $OPENSCADPATH ]
  then
    echo "OpenSCAD not found! Install OpenSCAD or set 'export OPENSCADPATH=path/to/openscad'"
    exit 0
  else
    echo "OpenSCAD PATH is $OPENSCADPATH"
  fi
fi

#set vars
keebcu=$1
scadFile=$keebcu.scad
confFile=conf/$keebcu.conf
echo "scad File: $scadFile"
echo "config File: $confFile"

# get line until print out scad file into temporary scad file
LINE=`grep -n BUILD_LINE $scadFile | cut -d : -f 1`

# get layout out of config file
# layout=`cat $confFile | grep layout | cut -d : -f 2`
# if [ -z $layout ]
# then
#   echo "No layout found in config file! Exit..."
#   echo "*** Set Variable 'layout=<varName>' in conf/<config file> ***"
#   echo "*** varName should be the name of the array which describe the layout ***"
#   exit 0
# else
#   echo "Building layout $layout..."
# fi

# get all modules to build
modules=`cat conf/template_to_copy.conf | grep module | cut -d :  -f 2`
echo "************************"
echo "Building:"
for i in $modules; do
    echo module: $i
done
echo "************************"



# create temporary directory for build
outputDir=stl/$keebcu
tempDir=temp$RANDOM
mkdir $tempDir

#check output directory exists
if [ -d $outputDir ]
then
	echo "Output directory is $outputDir"
else
	echo "Creating Output directory $outputDir"
	mkdir $outputDir
fi

#copy constants.scad and keyboardParts.scad into tempDir
cp constants.scad $tempDir
cp keyboardParts.scad $tempDir

echo
for i in $modules; do
    echo "################### calling module: $i ###################"
		head -n $LINE $scadFile > $tempDir/temp$scadFile
		echo $i >> $tempDir/temp$scadFile
		outputFile=`echo "$i" | cut -d \( -f 1`
		outputFile=$keebcu\_$outputFile\.stl
		echo $outputFile
		$OPENSCADPATH -o $outputDir/$outputFile $tempDir/temp$scadFile
		if [ $? == 0 ]
		then
			echo "################### done module: $i ###################"
		else
			echo "################### error in module: $i ###################"
		fi
		echo
done


# remove temprary directory
rm -rf $tempDir
