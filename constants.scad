/* constants.scad
Author: andimoto@posteo.de
----------------------------
for placing assambled parts and
single parts go to end of this file

this file is a template which may be copied to create a new keyboard layout
and to configure and place essential parts like usb cut out, screw holes or stabilizers

this file includes KeyV2 files. see https://github.com/rsheldiii/KeyV2
if you don't want this file to be included, just don't clone this library or
remove the call for placing all keycaps on the keyboard.
*/


/* ###### don't touch this! ###### */
//Unit square length, from Cherry MX data sheet
//this is the size of 1unit including keycap size and
//the space to the next keycap
lkey=19.05;
//Hole size, from Cherry MX data sheet
holesize=14;

//calculated vars
holediff=lkey-holesize;
caseWidth=width*lkey;
caseDepth=height*lkey;

/* for costar style stab cutouts */
stabX=3.3;//6.75;
stabCutoutWidth=0.825;

/* these are the values of the costar style stabilizers */
shortStabX=24;
longStabX=101;

innerExtraLid = 1;

//constant for inner case
innerCaseRadius=1;

//default height of the frame when in use
frameHeight = 6;

//height of the head of a cylinder head screw m2
screwHeadHeight = 3;

extraSpace=0.8;
