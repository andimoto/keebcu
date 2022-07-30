/* andimoto7583.scad
Author: andimoto@posteo.de
----------------------------
for placing assambled parts and
single parts go to end of this file

this file contains the layout for my 7583 keyboard 3d model which can be devided
to print on smaller printers

this file includes KeyV2 files. see https://github.com/rsheldiii/KeyV2
if you don't want this file to be included, just don't clone this library or
set the 'DoKeycapSimulation' parameter of KeyboardSim() to false.
*/

/* ########## predefinitions ############ */
$fn=30;


/* Thickness of entire plate which holds the switches.
 * this is the top of the keyboard
 */
plateThickness=3;
/* thickness of the walls */
wallThickness=3;
/* height of the case */
caseHeight=13;

/* space between inner case stabilizers
   and the bottom/lip of the case */
innerCaseSpace = 5;

//length, in units, of board
width=16.25;
//Height, in units, of board
height=6;

/* thickness of the lid.
   the function 'lid()' will add an
	 extra mm to get a step for the lip
	 see 'innerExtraLid' variable in constants  */
lidThickness=3;


/* ########## variables for cutting keyboard into smaller pieces ########## */
/* these are unit values; one unit is one key or switchhole
 * this makes the keyboard printable on nearly every printer.
 */
cutAfterUnits = 7.25;
spacebarCut = 4.5;

/* fRowSeparator [true/false]
 * Select separation of F-Row (or Row 0; key[0][1]=0)
 * This will move the upper row by a half unit (lkey*0.5)
 */
fRowSeparator=true;

/* skirt selctor and skirt settings
 * select 'skirtSelect' as true to activate a additional skirt
 * around the keyboard case. The variables 'skirtX' & 'skirtY'
 * are configurable as you want the skirt. These values ADD the
 * configured amount to the side of the case.
 * Note: be careful here, this interacts with caseRadius
 */
skirtSelect = true;
skirtX = 7;
skirtY = 7;

/* edge radius of the case
 * Note: be careful here, this interacts with skirtX/Y
 * THIS IS ONLY VALID WHEN 'skirtSelect' IS TRUE
 */
caseRadius=3;


/* ################## calculated vars #################### */


/* debug extra for avoiding artefacts @ compilation */
extra=1;


/* add or reduce some tolerance for the switch holes.
 * depends on your printers resolution and if you want
 * narrow or loose fit of switches. do not configure to
 * narrow switch holes. when placing switches into the holes
 * they will pull the case apart and bend it. this will normally
 * be reduced by the lid, but do not overact this.
 */
switchHoleTolerance = -0.2;


/* ############################################## */
/* ########## LAYOUT AND KEYCAP COLORS ########## */
/* ############################################## */
/* Usage: [[column place, row place],keycap unit, color for keycap simulation] */
/* 				"column place" is the place of the switch hole in the column;
 					- example: Esc, F1, F2, F3, ...
					            0    1   2   3  ...
					"row place" is the place of the switch in the row;
					- example:  Esc, accent, TAB, CapsLock, ...
*/
isoEnter = [
[[13.5,2.5],1.5,"#5883AC"] // ENTER
];

/* iso_75Q1  */
layout = [
//start ROW 0 Function ROW
[[0,0],1,"Red"], //Esc
[[1.25,0],1,"GhostWhite"], //F1
[[2.25,0],1,"GhostWhite"], //F2
[[3.25,0],1,"GhostWhite"], //F3
[[4.25,0],1,"GhostWhite"], //F4
[[5.5,0],1,"#5883AC"], //F5
[[6.5,0],1,"#5883AC"], //F6
[[7.5,0],1,"#5883AC"], //F7
[[8.5,0],1,"#5883AC"], //F8
[[9.75,0],1,"GhostWhite"], //F9
[[10.75,0],1,"GhostWhite"], //F10
[[11.75,0],1,"GhostWhite"], //F11
[[12.75,0],1,"GhostWhite"], //F12
[[14,0],1,"#5883AC"], //ins
[[15.25,0],1,"#5883AC"], // Del
//start ROW 1
[[  0,1],1,"#5883AC"], //^
[[1,1],1,"GhostWhite"], //1
[[2,1],1,"GhostWhite"], //2
[[3,1],1,"GhostWhite"], //3
[[4,1],1,"GhostWhite"], //4
[[5,1],1,"GhostWhite"], //5
[[6,1],1,"GhostWhite"], //6
[[7,1],1,"GhostWhite"], //7
[[8,1],1,"GhostWhite"], //8
[[9,1],1,"GhostWhite"], //9
[[10,1],1,"GhostWhite"], //0
[[11,1],1,"GhostWhite"], //ß
[[12,1],1,"GhostWhite"], //`
[[13,1],2,"#5883AC"], //backspace
[[15.25,1],1,"#5883AC"], //PgUp
//start ROW 2
[[  0,2],1.5,"#5883AC"], //TAB
[[1.5,2],1,"GhostWhite"], //Q
[[2.5,2],1,"GhostWhite"], //W
[[3.5,2],1,"GhostWhite"], //E
[[4.5,2],1,"GhostWhite"], //R
[[5.5,2],1,"GhostWhite"], //T
[[6.5,2],1,"GhostWhite"], //Y
[[7.5,2],1,"GhostWhite"], //U
[[8.5,2],1,"GhostWhite"], //I
[[9.5,2],1,"GhostWhite"], //O
[[10.5,2],1,"GhostWhite"], //P
[[11.5,2],1,"GhostWhite"], //Ü
[[12.5,2],1,"GhostWhite"], //+
[[15.25,2],1,"#5883AC"], // PgDn
//start ROW 3
[[   0,3],1.75,"#5883AC"], //CapsLock
[[1.75,3],1,"GhostWhite"], //A
[[2.75,3],1,"GhostWhite"], //S
[[3.75,3],1,"GhostWhite"], //D
[[4.75,3],1,"GhostWhite"], //F
[[5.75,3],1,"GhostWhite"], //G
[[6.75,3],1,"GhostWhite"], //H
[[7.75,3],1,"GhostWhite"], //J
[[8.75,3],1,"GhostWhite"], //K
[[9.75,3],1,"GhostWhite"], //L
[[10.75,3],1,"GhostWhite"], //Ö
[[11.75,3],1,"GhostWhite"], //Ä
[[12.75,3],1,"GhostWhite"], //#
//ENTER
[[15.25,3],1,"#5883AC"], //Home
//start ROW 4
[[   0,4],2.25,"#5883AC"], //LShift
[[2.25,4],1,"GhostWhite"], //Z
[[3.25,4],1,"GhostWhite"], //X
[[4.25,4],1,"GhostWhite"], //C
[[5.25,4],1,"GhostWhite"], //V
[[6.25,4],1,"GhostWhite"], //B
[[7.25,4],1,"GhostWhite"], //N
[[8.25,4],1,"GhostWhite"], //M
[[9.25,4],1,"GhostWhite"], //,
[[10.25,4],1,"GhostWhite"], //.
[[11.25,4],1,"GhostWhite"], // -
[[12.25,4],1.75,"#5883AC"], //RShift
[[14.25,4.25],1,"#5883AC"], //UP
//[[15,4],1,"#5883AC"], //end
//start ROW 5
[[   0,5],1.25,"#5883AC"], //LCTRL
[[1.25,5],1.25,"#5883AC"], //TUX
[[2.5 ,5],1.25,"#5883AC"], //ALT
[[3.75,5],6.25,"GhostWhite"], //SPACE
[[10  ,5],1,"#5883AC"], //AltGr/Compose
[[11,5],1,"#5883AC"], //Fn
[[12,5],1,"#5883AC"], //Strg
[[13.25,5.25],1,"#5883AC"], //LEFT
[[14.25,5.25],1,"#5883AC"], //DOWN
[[15.25,5.25],1,"#5883AC"], //RIGHT
];

/* enable placment of stabilizers on switchholes with x.5 unit in y direction
 * for example: true for numpad enter or numpad +
 * if you just want a single unit (1unit keycap) you can set this to false */
enableStabsOnHalfs = true;

/* move pcb and usb cutout in x direction
   for better placement */
pcbShift=0;

/* cutout for micro usb plug (not the housing of the usb plug!)
 * change this if using mini usb
 */
usbCutX=8;
usbCutY=wallThickness;

/* Arduino Pro Micro USB Port height */
usbCutZ=3.4;

/* Teensy2 USB Port height */
/* usbCutZ=4.5; */

/* space in lid for placing the controller pcb.
 * this example is for arduino pro micro clones.
 * if you use teensy2.0 or something else configure
 * the size of the controller pcb you use. the function
 * 'pcbCutout()' will add 1mm to 'pcbWidth' for some clearance.
 * pcbLength should be as exactly as possible. this keeps the pcb
 * perfectly even if pcbWidth is to much
 */
/* teensy2 cutout */
//pcbHeight = 1.8;
//pcbWidth = 18.5;
// pcbLength = 31.4;

 /* arduino pro micro cutout */
pcbHeight = 2;
pcbWidth = 18;
pcbLength = 34;


/* set 'addRisers' to true or false
 * to calculate a lid with holes for risers
 * and add risers to simulation
 */
addRisers = true;

/* keyboardRiser config
 * angleBaseX -> width of the riser
 * angleBaseY -> depth of the riser
 */
angleBaseY=90;
angleBaseX=60;
/* riser edge radius */
angleBaseRad=1;
/* polygon; this is the shape of the riser */
riserPoints = [
[0,0],
[angleBaseY,0],
[angleBaseY,2],
[0,17]
];

/* optional: move keyboard risers as needed */
xRiserR=0;
xRiserL=0;
yRiserAll=0;

riserConnectorRadius = 5;
riserConnectorX = 0;
riserConnectorY1 = 60;




/* ####### include keyboard lib ############ */
include <constants.scad>
include <keyboardParts.scad>

/* this module gets called in 'holematrix' and adds a specific
 * object to the 'holematrix'. it enables placing switchholes
  * or other cutout objects to the model */
module extraCutoutHook()
{
  /* custom: place isoEnter switchhole here */
  for(key = isoEnter)
  {
    startx = 0;
    starty = caseDepth - lkey;
    zCase = tempHeigth;

    /* check for iso Enter key; should be the last row minus 3.5
       iso enter key belongs to the 2nd row at layout with F-Keys, or 1st
       row without F Keys */
    /* iso enter needs a move of about 2mm into right direction */
    translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
    translate([(lkey*key[1]-holesize)/2 + 2.8,(lkey - holesize)/2, 0])
    switchhole();

    /* iso enter and other stabilizers than spacebar */
    /* needed to add some extra mm to the costarStabilizer cutouts
       but different extra for each stabilizer */
    translate([19.7,-5,0])
    translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
    translate([(lkey*key[1]-holesize)/2+(holesize/2)-shortStabX/2 + 2.5,(lkey - holesize)/2+costarStabYdelta+0.5, 0])
    rotate([0,0,90]) costarStabilizer();

    translate([-4.7,20,0])
    translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
    translate([(lkey*key[1]+holesize)/2-(holesize/2)+shortStabX/2 + 2.8,(lkey - holesize)/2+costarStabYdelta-0.5, 0])
    rotate([0,0,90]) costarStabilizer();
  }
}

module extraKeycapCutoutHook()
{
  /* custom: place isoEnter switchhole here */
  for(key = isoEnter)
  {
    startx = 0;
    starty = caseDepth - lkey;
    zCase = tempHeigth;


    /* iso enter needs a separate cutout
     * cutout is made by placing 0.5 unit above and lower
     */
    translate([startx+lkey*key[0][0], starty-lkey*(key[0][1]-getHalf(key[0][1])), 0])
    keycapSpace(key[1]);
    translate([startx+lkey*key[0][0], starty-lkey*(key[0][1]+getHalf(key[0][1])), 0])
    keycapSpace(key[1]);

  }
}

/* this module gets called in 'keySim()' and adds a specific
 * object to the 'key simulation'. it enables placing keys
  * or other objects to the model simulation */
module extraKeySimHook()
{
  startx = 0;
	starty = caseDepth - lkey;
	zCase = tempHeigth;

  for(key = isoEnter)
  {
    color(key[2])
    translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
    translate([(lkey*key[1]-holesize)/2+2,(lkey - holesize)/2, 0])
    iso_enter() key(true, $fn=setKeycapFragments);
  }
}


/* ####### screw hole config ######## */
/* set the screw holes to a good position.
 * if your keyboard is bigger, you can add some
 * more screw holes into the keyboard case and lid.
 */
screwHoleArray = [
[24,lkey-0.4], //left lower row
[114,lkey-0.4],
[170,lkey-0.4],
[291.5,lkey-0.4], // right lower row

[24,lkey*3+wallThickness-3], //left mid row
[124,lkey*3+wallThickness-3],
[162,lkey*3+wallThickness-3],
[291,lkey*3+wallThickness-3], //right mid row

[19,lkey*5+wallThickness-3], //left upper row
[133,lkey*5+wallThickness-3],
[171,lkey*5+wallThickness-3],
[291,lkey*5+wallThickness-3], //right upper row
];

/* rotate screw hole spacers */
screwSpacerRotation=0;

/* move horizontal case stabilizers inside the case.
 * to move horizontal by lkey/2 for half switch cutout.
 * this enables to set x.5 values in layout array.
 * else use 0!!
 */
caseStabMov=0;

/* set colors for simulation */
colorCase="RoyalBlue";
colorLid="DarkSlateGray";
colorRiserR="DarkSlateGray";
colorRiserL="DarkSlateGray";

/* color simulation for switches
  select top and bottom color */
switchColorTop = "Ivory";
switchColorBottom = "Black";

/* simulate a keycap profile with number of fragments ($fn = setKeycapFragments)
   which will be set to key() call.
   KeyV2 currently (2022-06) does not support XDA.
   Use DSA as they look very similar
   NOTE: DSA is fixed to 3rd row as KeyV2 includes row number into calculation
   of DSA caps
   NOTE: currently not all profiles are working. OEM or DCS are always simulated! */
keycapProfile = "OEM"; // SA, DSA, DCS, G20, Hi-Pro, OEM
setKeycapFragments = 100;

/* ###################### BUILD_LINE ########################*/
/* ##########################################################*/
/* All calls after this line have to be ignored by the build script.
 * Do not place any calls above build line (or comment it)
 */

/* uncomment following line to get the keyboard simulation
 * with keycaps. set DoKeycapSimulation to true or false to add
 * or remove keycap simulation
 */
/* KeyboardSim(layout,true,9.5); */

/* ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ */
/* ##### uncomment the keyboard part you want to print ##### */
/* vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv */

/* ### complete keyboard model ### */
mainCase(layout);
/* lid(); */

/* ### devided keyboard and lid model ### */
/* mainCaseLeft(layout); */
/* mainCaseRight(layout); */

/* lidL(); */
/* lidR(); */

/* keyboardRiser(); */
