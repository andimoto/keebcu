/* numpad.scad
Author: andimoto@posteo.de
----------------------------
for placing assambled parts and
single parts go to end of this file

this file contains the layout for my numpad keyboard 3d model which can be printed

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
width=4;
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
fRowSeparator=false;

/* skirt selctor and skirt settings
 * select 'skirtSelect' as true to activate a additional skirt
 * around the keyboard case. The variables 'skirtX' & 'skirtY'
 * are configurable as you want the skirt. These values ADD the
 * configured amount to the side of the case.
 * Note: be careful here, this interacts with caseRadius
 *
 * If this is activated you can call 'capFrame()'
 * (or capFrameR/capFrameL) to create a nice frame
 * around the keycaps to cover the switches. This may give
 * a cleaner look if this is prefered.
 */
skirtSelect = false;
skirtX = 3;
skirtY = 3;

/* edge radius of the case
 * Note: be careful here, this interacts with skirtX/Y
 * THIS IS ONLY VALID WHEN 'skirtSelect' IS TRUE
 */
caseRadius=5;


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

/* numpad layout */
layout = [
[[ 0,1],1,"Blue"], //numlock
[[ 1,1],1,"Blue"], // /
[[ 2,1],1,"Blue"], // *
[[ 3,1],1,"Blue"], // -
//start ROW 1
[[ 0,2],1,"DeepSkyBlue"], //7
[[ 1,2],1,"DeepSkyBlue"], //8
[[ 2,2],1,"DeepSkyBlue"], //9
[[ 3,2.5],1,"Blue"], // +
//start ROW 2
[[ 0,3],1,"DeepSkyBlue"], //4
[[ 1,3],1,"DeepSkyBlue"], //5
[[ 2,3],1,"DeepSkyBlue"], //6
/* [[ 3,2],1,"MintCream"], //E */
//start ROW 3
[[ 0,4],1,"DeepSkyBlue"], //1
[[ 1,4],1,"DeepSkyBlue"], //2
[[ 2,4],1,"DeepSkyBlue"], //3
[[ 3,4.5],1,"Red"], // numpad enter
//start ROW 4
[[ 0,5],2,"DeepSkyBlue"], //0
[[ 2,5],1,"DeepSkyBlue"], //,

];

/* enable placment of stabilizers on switchholes with x.5 unit in y direction
 * for example: true for numpad enter or numpad +
 * if you just want a single unit (1unit keycap) you can set this to false */
enableStabsOnHalfs = true;

/* move pcb and usb cutout in x direction
   for better placement */
pcbShift=8.5;

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
 //pcbLength = 31.4;

 /* arduino pro micro cutout */
 pcbHeight = 2;
 pcbWidth = 18;
 pcbLength = 34;;

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
angleBaseX=12;
/* riser edge radius */
angleBaseRad=1;
/* polygon; this is the shape of the riser */
riserPoints = [
[0,0],
[angleBaseY,0],
[angleBaseY,4],
[0,18]
];

/* optional: move keyboard risers as needed */
xRiserR=-22;
xRiserL=22;
yRiserAll=0;

riserConnectorRadius = 4;
riserConnectorX = 0;
riserConnectorY1 = 40;




/* ####### include keyboard lib ############ */
include <constants.scad>
include <keyboardParts.scad>


/* this module gets called in 'holematrix' and adds a specific
 * object to the 'holematrix'. it enables placing switchholes
  * or other cutout objects to the model */
module extraCutoutHook()
{
}

/* this module gets called in 'keycapMatrix()' and adds a specific
 * object to the keycapMatrix. keycapMatrix is needed as a cutout element
 * from the frame. this hook gives possibility to add more elements such
 * as the enter keycap.
 */
module extraKeycapCutoutHook()
{
}

/* this module gets called in 'keySim()' and adds a specific
 * object to the 'key simulation'. it enables placing keys
  * or other objects to the model simulation */
module extraKeySimHook()
{
}


/* ####### screw hole config ######## */
/* set the screw holes to a good position.
 * if your keyboard is bigger, you can add some
 * more screw holes into the keyboard case and lid.
 */
screwHoleArray = [
[20.5,lkey], //left lower row
[55,lkey],


[19,lkey*5], //left upper row
[57,lkey*5],
];

/* rotate screw hole spacers */
screwSpacerRotation=0;

/* move horizontal case stabilizers inside the case.
 * to move horizontal by lkey/2 for half switch cutout.
 * this enables to set x.5 values in layout array.
 * else use 0!!
 */
caseStabMov=0;

/* screw holes when enabling outer case frame */
frameScrewHoleArray = [
[-skirtX/2-innerCaseRadius/2,-skirtY/2-innerCaseRadius/2], //lower row
[caseWidth/4,-skirtY/2-innerCaseRadius/2],
[caseWidth/2-lkey,-skirtY/2-innerCaseRadius/2],
[caseWidth/2+lkey,-skirtY/2-innerCaseRadius/2], //lower row
[caseWidth-caseWidth/4,-skirtY/2-innerCaseRadius/2],
[caseWidth+skirtX/2+innerCaseRadius/2,-skirtY/2-innerCaseRadius/2],

[-skirtX/2-innerCaseRadius/2,lkey*1.5], //lower row
[caseWidth+skirtX/2+innerCaseRadius/2,lkey*1.5],

[-skirtX/2-innerCaseRadius/2,caseDepth-lkey*0.75], //lower row
[caseWidth/2-lkey,caseDepth-lkey*0.75],
[caseWidth/4,caseDepth-lkey*0.75],
[caseWidth/2+lkey,caseDepth-lkey*0.75], //lower row
[caseWidth-caseWidth/4,caseDepth-lkey*0.75],
[caseWidth+skirtX/2+innerCaseRadius/2,caseDepth-lkey*0.75],

[-skirtX/2-innerCaseRadius/2,caseDepth+lkey*0.5+skirtY/2+innerCaseRadius/2], //lower row
[caseWidth/4,caseDepth+lkey*0.5+skirtY/2+innerCaseRadius/2],
[caseWidth/2-lkey,caseDepth+lkey*0.5+skirtY/2+innerCaseRadius/2],
[caseWidth/2+lkey,caseDepth+lkey*0.5+skirtY/2+innerCaseRadius/2], //lower row
[caseWidth-caseWidth/4,caseDepth+lkey*0.5+skirtY/2+innerCaseRadius/2],
[caseWidth+skirtX/2+innerCaseRadius/2,caseDepth+lkey*0.5+skirtY/2+innerCaseRadius/2]
];




/* set colors for simulation, set 0 for default OpenSCAD Gui Colors */
colorCaseTop="White";
colorCaseMid="DarkGray";
colorLid="Black";
colorRiserR="Black";
colorRiserL="Black";

frameColor="Black";

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
keycapProfile = "SA"; // SA, DSA, DCS, G20, Hi-Pro, OEM
setKeycapFragments = 50;

/* ###################### BUILD_LINE ########################*/
/* ##########################################################*/
/* All calls after this line have to be ignored by the build script.
 * Do not place any calls above build line (or comment it)
 */

/* uncomment following line to get the keyboard simulation
 * with keycaps. set DoKeycapSimulation to true or false to add
 * or remove keycap simulation
 */
/* KeyboardSim(layout,doFrameSim=false,DoKeycapSimulation=false,xRotate=9.5); */

/* ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ */
/* ##### uncomment the keyboard part you want to print ##### */
/* vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv */

/* ### complete keyboard model ### */
/* mainCase(layout); */
/* lid(); */

/* keycap frame functions. activate if skirt is enabled
   and you want a frame that hides the switches, which is
   a more classic look to none printed keyboards */
/* translate([0,0,13])
capFrame(layout); */

/* translate([0,0,13])
capFrameR(layout); */

/* translate([0,0,13])
capFrameL(layout); */

/* ### devided keyboard and lid model ### */
mainCaseLeft(layout);
/* mainCaseRight(layout); */

/* lidL(); */
/* lidR(); */


/* keyboardRiser(); */
