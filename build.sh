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
    exit 1
  else
    echo "OpenSCAD PATH is $OPENSCADPATH"
  fi
fi

#check 1st parameter and set config file
if [ -z $1 ]
then
	echo "No parameter given..."
	echo "Give Keyboard name as 1st parameter: ./build.sh andimotoXYZ <configfile>"
	echo "Do not give scad file extension. 2nd parameter is optional. You can give other conf file to call other modules."
	exit 1
else
	#set vars
	keebcu=$1
	scadFile=$keebcu.scad
fi

if [ -z $2 ]
then
	confFile=conf/module-calls.conf
else
	confFile=$2
fi

echo "scad File: $scadFile"
echo "config File: $confFile"

# get line until print out scad file into temporary scad file
LINE=`grep -n BUILD_LINE $scadFile | cut -d : -f 1`


# get all modules to build
modules=`cat $confFile | grep module | cut -d :  -f 2`
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
