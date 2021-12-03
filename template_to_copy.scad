/* template_to_copy.scad
Author: andimoto@posteo.de
----------------------------
for placing assambled parts and
single parts go to end of this file

this file is a template which may be copied to create a new keyboard layout
and to configure and place essential parts like usb cut out, screw holes or stabilizers

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
width=16;
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
skirtX = 5;
skirtY = 5;

/* edge radius of the case
 * Note: be careful here, this interacts with skirtX/Y
 */
caseRadius=10;


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

/* template_ansiUS_7583 */
layout = [
//start ROW 0 Function ROW
[[ 0,0],1,"red"], //Esc
[[ 1,0],1,"MintCream"], //F1
[[ 2,0],1,"MintCream"], //F2
[[ 3,0],1,"MintCream"], //F3
[[ 4,0],1,"MintCream"], //F4
[[ 5,0],1,"Gray"], //F5
[[ 6,0],1,"Gray"], //F6
[[ 7,0],1,"Gray"], //F7
[[ 8,0],1,"Gray"], //F8
[[ 9,0],1,"MintCream"], //F9
[[10,0],1,"MintCream"], //F10
[[11,0],1,"MintCream"], //F11
[[12,0],1,"MintCream"], //F12
[[13,0],1,"Gray"], //PrintScreen
[[14,0],1,"Gray"], //PrintScreen
[[15,0],1,"Gray"], // Del/Ins
//start ROW 1
[[ 0,1],1,"Gray"], //'
[[ 1,1],1,"MintCream"], //1
[[ 2,1],1,"MintCream"], //2
[[ 3,1],1,"MintCream"], //3
[[ 4,1],1,"MintCream"], //4
[[ 5,1],1,"MintCream"], //5
[[ 6,1],1,"MintCream"], //6
[[ 7,1],1,"MintCream"], //7
[[ 8,1],1,"MintCream"], //8
[[ 9,1],1,"MintCream"], //9
[[10,1],1,"MintCream"], //0
[[11,1],1,"MintCream"], //-_
[[12,1],1,"MintCream"], //=+
[[13,1],2,"Gray"], //backspace
[[15,1],1,"Gray"], //home
//start ROW 2
[[   0,2],1.5,"Gray"], //TAB
[[ 1.5,2],1,"MintCream"], //Q
[[ 2.5,2],1,"MintCream"], //W
[[ 3.5,2],1,"MintCream"], //E
[[ 4.5,2],1,"MintCream"], //R
[[ 5.5,2],1,"MintCream"], //T
[[ 6.5,2],1,"MintCream"], //Y
[[ 7.5,2],1,"MintCream"], //U
[[ 8.5,2],1,"MintCream"], //I
[[ 9.5,2],1,"MintCream"], //O
[[10.5,2],1,"MintCream"], //P
[[11.5,2],1,"MintCream"], //[
[[12.5,2],1,"MintCream"], //]
[[13.5,2],1.5,"Gray"], // \
[[  15,2],1,"Gray"], // PgUp
//start ROW 3
[[    0,3],1.75,"Gray"], //CapsLock
[[ 1.75,3],1,"MintCream"], //A
[[ 2.75,3],1,"MintCream"], //S
[[ 3.75,3],1,"MintCream"], //D
[[ 4.75,3],1,"MintCream"], //F
[[ 5.75,3],1,"MintCream"], //G
[[ 6.75,3],1,"MintCream"], //H
[[ 7.75,3],1,"MintCream"], //J
[[ 8.75,3],1,"MintCream"], //K
[[ 9.75,3],1,"MintCream"], //L
[[10.75,3],1,"MintCream"], //;
[[11.75,3],1,"MintCream"], //'
[[12.75,3],2.25,"Aqua"], //ENTER
[[   15,3],1,"Gray"], //PgDn
//start ROW 4
[[    0,4],2.25,"Gray"], //LShift
[[ 2.25,4],1,"MintCream"], //Z
[[ 3.25,4],1,"MintCream"], //X
[[ 4.25,4],1,"MintCream"], //C
[[ 5.25,4],1,"MintCream"], //V
[[ 6.25,4],1,"MintCream"], //B
[[ 7.25,4],1,"MintCream"], //N
[[ 8.25,4],1,"MintCream"], //M
[[ 9.25,4],1,"MintCream"], //,
[[10.25,4],1,"MintCream"], //.
[[11.25,4],1,"MintCream"], // /
[[12.25,4],1.75,"Gray"], //RShift
[[   14,4],1,"Gray"], //UP
[[   15,4],1,"Gray"], //end
//start ROW 5
[[    0,5],1.25,"Gray"], //LCTRL
[[ 1.25,5],1.25,"Gray"], //TUX
[[ 2.5 ,5],1.25,"Gray"], //ALT
[[ 3.75,5],6.25,"MintCream"], //SPACE
[[ 10  ,5],1.25,"Gray"], //COMP
[[11.25,5],1.25,"Gray"], //Fn
[[  13,5],1,"Gray"], //LEFT
[[  14,5],1,"Gray"], //DOWN
[[  15,5],1,"Gray"], //RIGHT
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
 pcbHeight = 1.8;
 pcbWidth = 18.5;
 pcbLength = 31.4;

 /* arduino pro micro cutout */
 //pcbHeight = 2;
 //pcbWidth = 18;
 //pcbLength = 34;;

/* set 'addRisers' to true or false
 * to calculate a lid with holes for risers
 * and add risers to simulation
 */
addRisers = true;

/* keyboardRiser config
 * angleBaseX -> width of the riser
 * angleBaseY -> depth of the riser
 */
angleBaseY=110;
angleBaseX=60;
/* riser edge radius */
angleBaseRad=1;
/* polygon; this is the shape of the riser */
riserPoints = [
[0,0],
[angleBaseY,0],
[0,18]
];

/* optional: move keyboard risers as needed */
xRiserR=0;
xRiserL=0;

/* ####### include keyboard lib ############ */
include <constants.scad>
include <keyboardParts.scad>

/* this module gets called in 'holematrix' and adds a specific
 * object to the 'holematrix'. it enables placing switchholes
  * or other cutout objects to the model */
module extraCutoutHook()
{
  /* nothing here for this curent layout */
}


/* ####### screw hole config ######## */
/* set the screw holes to a good position.
 * if your keyboard is bigger, you can add some
 * more screw holes into the keyboard case and lid.
 */
screwHoleArray = [
[24,lkey-3], //left lower row
[114,lkey-3],
[170,lkey-3],
[285.5,lkey-3], // right lower row

[24,lkey*3+wallThickness-2], //left mid row
[124,lkey*3+wallThickness-2],
[162,lkey*3+wallThickness-2],
[285,lkey*3+wallThickness-2], //right mid row

[19,lkey*5+wallThickness-2], //left upper row
[133,lkey*5+wallThickness-2],
[171,lkey*5+wallThickness-2],
[285.5,lkey*5+wallThickness-2], //right upper row
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
colorCase="White";
colorLid="Green";
colorRiserR="Gold";
colorRiserL="Blue";

/* ###################### BUILD_LINE ########################*/
/* ##########################################################*/
/* All calls after this line have to be ignored by the build script.
 * Do not place any calls above build line (or comment it)
 */

/* uncomment following line to get the keyboard simulation
 * with keycaps. set DoKeycapSimulation to true or false to add
 * or remove keycap simulation
 */
/* KeyboardSim(layout,false); */

/* ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ */
/* ##### uncomment the keyboard part you want to print ##### */
/* vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv */

/* ### complete keyboard model ### */
translate([0,0,5]) mainCase(layout);
/* lid(); */

/* ### devided keyboard and lid model ### */
/* mainCaseLeft(layout); */
/* translate([0, 150,0]) mainCaseRight(layout); */

/* lidL(); */
/* lidR(); */

/* keyboardRiser(); */
