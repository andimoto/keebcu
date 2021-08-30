/* andimotoTKL.scad
Author: andimoto@posteo.de
----------------------------
for placing assambled parts and
single parts go to end of this file

this file contains the layout for my TKL keyboard 3d model which can be devided
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

/* edge radius of the case */
caseRadius=1;

//length, in units, of board
width=18.25;
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
cutAfterUnits = 8.5;
spacebarCut = 5.5;

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
skirtSelect = false;
skirtX = 0;
skirtY = 0;

/* edge radius of the case
 * Note: be careful here, this interacts with skirtX/Y
 */
caseRadius=0;


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

/* ansiUS_TKL */
layout = [
//start ROW 0 Function ROW
[[0,0],1,"Grey"], //Esc
[[2,0],1,"Grey"], //F1
[[3,0],1,"Grey"], //F2
[[4,0],1,"Grey"], //F3
[[5,0],1,"Grey"], //F4
[[6.5,0],1,"Grey"], //F5
[[7.5,0],1,"Grey"], //F6
[[8.5,0],1,"Grey"], //F7
[[9.5,0],1,"Grey"], //F8
[[11,0],1,"Grey"], //F9
[[12,0],1,"Grey"], //F10
[[13,0],1,"Grey"], //F11
[[14,0],1,"Grey"], //F12
[[15.25,0],1,"Grey"], //PrintScreen
[[16.25,0],1,"Grey"], //ScrollLock
[[17.25,0],1,"Grey"], //Pause
//start ROW 1
[[  0,1],1,"Grey"], //'
[[1,1],1,"Grey"], //1
[[2,1],1,"Grey"], //2
[[3,1],1,"Grey"], //3
[[4,1],1,"Grey"], //4
[[5,1],1,"Grey"], //5
[[6,1],1,"Grey"], //6
[[7,1],1,"Grey"], //7
[[8,1],1,"Grey"], //8
[[9,1],1,"Grey"], //9
[[10,1],1,"Grey"], //0
[[11,1],1,"Grey"], //-_
[[12,1],1,"Grey"], //=+
[[13,1],2,"Grey"], //backspace
[[15.25,1],1,"Grey"], //ins
[[16.25,1],1,"Grey"], //pos1
[[17.25,1],1,"Grey"], //PgUp
//start ROW 2
[[  0,2],1.5,"Grey"], //TAB
[[1.5,2],1,"Grey"], //Q
[[2.5,2],1,"Grey"], //W
[[3.5,2],1,"Grey"], //E
[[4.5,2],1,"Grey"], //R
[[5.5,2],1,"Grey"], //T
[[6.5,2],1,"Grey"], //Y
[[7.5,2],1,"Grey"], //U
[[8.5,2],1,"Grey"], //I
[[9.5,2],1,"Grey"], //O
[[10.5,2],1,"Grey"], //P
[[11.5,2],1,"Grey"], //[
[[12.5,2],1,"Grey"], //]
[[13.5,2],1.5,"Grey"], // \
[[15.25,2],1,"Grey"], // del
[[16.25,2],1,"Grey"], // end
[[17.25,2],1,"Grey"], // PgDn
//start ROW 3
[[   0,3],1.75,"Grey"], //CapsLock
[[1.75,3],1,"Grey"], //A
[[2.75,3],1,"Grey"], //S
[[3.75,3],1,"Grey"], //D
[[4.75,3],1,"Grey"], //F
[[5.75,3],1,"Grey"], //G
[[6.75,3],1,"Grey"], //H
[[7.75,3],1,"Grey"], //J
[[8.75,3],1,"Grey"], //K
[[9.75,3],1,"Grey"], //L
[[10.75,3],1,"Grey"], //;
[[11.75,3],1,"Grey"], //'
[[12.75,3],2.25,"Grey"], //ENTER
//start ROW 4
[[   0,4],2.25,"Grey"], //LShift
[[2.25,4],1,"Grey"], //Z
[[3.25,4],1,"Grey"], //X
[[4.25,4],1,"Grey"], //C
[[5.25,4],1,"Grey"], //V
[[6.25,4],1,"Grey"], //B
[[7.25,4],1,"Grey"], //N
[[8.25,4],1,"Grey"], //M
[[9.25,4],1,"Grey"], //,
[[10.25,4],1,"Grey"], //.
[[11.25,4],1,"Grey"], // /
[[12.25,4],2.75,"Grey"], //RShift
[[16.25,4],1,"Grey"], //UP
//start ROW 5
[[   0,5],1.25,"Grey"], //LCTRL
[[1.25,5],1.25,"Grey"], //TUX
[[2.5 ,5],1.25,"Grey"], //ALT
[[3.75,5],6.25,"Grey"], //SPACE
[[10  ,5],1.25,"Grey"], //COMP
[[11.25,5],1.25,"Grey"], //Fn
[[12.5,5],1.25,"Grey"], //Menu
[[13.75 ,5],1.25,"Grey"], //RCTRL
[[15.25,5],1,"Grey"], //LEFT
[[16.25,5],1,"Grey"], //DOWN
[[17.25,5],1,"Grey"], //RIGHT
];

/* move pcb and usb cutout in x direction
   for better placement */
pcbShift=-13;

/* cutout for micro usb plug (not the housing of the usb plug!)
 * change this if using mini usb
 */
usbCutX=8;
usbCutY=wallThickness;

/* Arduino Pro Micro USB Port height */
/* usbCutZ=3.4; */

/* Teensy2 USB Port height */
usbCutZ=4.5;

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
//pcbLength = 34;

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
angleBaseX=80;
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

/* ####### screw hole config ######## */
/* set the screw holes to a good position.
 * if your keyboard is bigger, you can add some
 * more screw holes into the keyboard case and lid.
 */
screwHoleArray = [
[24,lkey-0.5], //left lower row
[157,lkey-0.5],
[193,lkey-0.5],
[328,lkey-0.5], // right lower row

[24,lkey*3+wallThickness-3], //left mid row
[148.5,lkey*3+wallThickness-3],
[200,lkey*3+wallThickness-3],
[328,lkey*3+wallThickness-3], //right mid row

[24,lkey*5+wallThickness-3], //left upper row
[152,lkey*5+wallThickness-3],
[200,lkey*5+wallThickness-3],
[328,lkey*5+wallThickness-3], //right upper row
];

/* rotate screw hole spacers */
screwSpacerRotation=0;

/* set colors for simulation */
colorCase="White";
colorLid="White";
colorRiserR="White";
colorRiserL="White";

/* ###################### BUILD_LINE ########################*/
/* ##########################################################*/
/* All calls after this line have to be ignored by the build script.
 * Do not place any calls above build line (or comment it)
 */

/* uncomment following line to get the keyboard simulation
 * with keycaps. set DoKeycapSimulation to true or false to add
 * or remove keycap simulation
 */
/* KeyboardSim(layout,true); */

/* ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ */
/* ##### uncomment the keyboard part you want to print ##### */
/* vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv */

/* ### complete keyboard model ### */
color("Gold") mainCase(layout);
/* color("Gold") lid(); */

/* ### devided keyboard and lid model ### */
/* mainCaseLeft(layout); */
/* translate([0,0,0]) mainCaseRight(layout); */

/* lidL(); */
/* lidR(); */

/* keyboardRiser(); */
