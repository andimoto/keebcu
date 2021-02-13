/* test_isoDE_7583.scad
Author: andimoto@posteo.de
----------------------------
for placing assambled parts and
single parts go to end of this file

this file is a template which may be copied to create a new keyboard layout
and to configure and place essential parts like usb cut out, screw holes or stabilizers

this file includes KeyV2 files. see https://github.com/rsheldiii/KeyV2
if you don't want this file to be included, just don't clone this library or
set the 'DoKeycapSimulation' parameter to false call for placing all keycaps on the keyboard.

todo:
- template cutout for teensy2

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
width=17.25;
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

isoDE_7583keyboard = [
//start ROW 0 Function ROW
[[0,0],1,"Grey"], //Esc
[[2,0],1,"Gray"], //F1
[[3,0],1,"Gray"], //F2
[[4,0],1,"Gray"], //F3
[[5,0],1,"Gray"], //F4
[[6.5,0],1,"Gray"], //F5
[[7.5,0],1,"Gray"], //F6
[[8.5,0],1,"Gray"], //F7
[[9.5,0],1,"Gray"], //F8
[[11,0],1,"Gray"], //F9
[[12,0],1,"Gray"], //F10
[[13,0],1,"Gray"], //F11
[[14,0],1,"Gray"], //F12
[[15.25,0],1,"Gray"], //PrintScreen
[[16.25,0],1,"Gray"], //Pause

//start ROW 1
[[0,1],1,"Gray"], //'
[[1,1],1,"Gray"], //1
[[2,1],1,"Gray"], //2
[[3,1],1,"Gray"], //3
[[4,1],1,"Gray"], //4
[[5,1],1,"Gray"], //5
[[6,1],1,"Gray"], //6
[[7,1],1,"Gray"], //7
[[8,1],1,"Gray"], //8
[[9,1],1,"Gray"], //9
[[10,1],1,"Gray"], //0
[[11,1],1,"Gray"], //-_
[[12,1],1,"Gray"], //=+
[[13,1],2,"Gray"], //backspace
[[15.25,1],1,"Gray"], //ins
[[16.25,1],1,"Gray"], //pos1
//start ROW 2
[[  0,2],1.5,"Gray"], //TAB
[[1.5,2],1,"Gray"], //Q
[[2.5,2],1,"Gray"], //W
[[3.5,2],1,"Gray"], //E
[[4.5,2],1,"Gray"], //R
[[5.5,2],1,"Gray"], //T
[[6.5,2],1,"Gray"], //Y
[[7.5,2],1,"Gray"], //U
[[8.5,2],1,"Gray"], //I
[[9.5,2],1,"Gray"], //O
[[10.5,2],1,"Gray"], //P
[[11.5,2],1,"Gray"], //[
[[12.5,2],1,"Gray"], //]
[[13.5,2.5],1.5,"Gray"], // ENTER
[[15.25,2],1,"Gray"], // del
[[16.25,2],1,"Gray"], // end
//start ROW 3
[[   0,3],1.75,"Gray"], //CapsLock
[[1.75,3],1,"Gray"], //A
[[2.75,3],1,"Gray"], //S
[[3.75,3],1,"Gray"], //D
[[4.75,3],1,"Gray"], //F
[[5.75,3],1,"Gray"], //G
[[6.75,3],1,"Gray"], //H
[[7.75,3],1,"Gray"], //J
[[8.75,3],1,"Gray"], //K
[[9.75,3],1,"Gray"], //L
[[10.75,3],1,"Gray"], //;
[[11.75,3],1,"Gray"], //'
[[12.75,3],1,"Gray"], //#
//start ROW 4
[[   0,4],1.25,"Gray"], //LShift
[[1.25,4],1,"Gray"], //Z
[[2.25,4],1,"Gray"], //Z
[[3.25,4],1,"Gray"], //X
[[4.25,4],1,"Gray"], //C
[[5.25,4],1,"Gray"], //V
[[6.25,4],1,"Gray"], //B
[[7.25,4],1,"Gray"], //N
[[8.25,4],1,"Gray"], //M
[[9.25,4],1,"Gray"], //,
[[10.25,4],1,"Gray"], //.
[[11.25,4],1,"Gray"], // /
[[12.25,4],2.75,"Gray"], //RShift
[[15.25,4],1,"Gray"], //UP
//start ROW 5
[[   0,5],1.25,"Gray"], //LCTRL
[[1.25,5],1.25,"Gray"], //TUX
[[2.5 ,5],1.25,"Gray"], //ALT
[[3.75,5],6.25,"Gray"], //SPACE
[[10  ,5],1.25,"Gray"], //COMP
[[11.25,5],1.25,"Gray"], //Fn
[[12.5 ,5],1.25,"Grey"], //RCTRL
[[14.25,5],1,"Gray"], //LEFT
[[15.25,5],1,"Gray"], //DOWN
[[16.25,5],1,"Gray"], //RIGHT
];

/* set this variable to the amount of the rows of your LAYOUT.
 * this will be used in "calcRight" module to add wallThickness
 * to the cut in y direction.
 */
MaxRows = 6;


/* cutout for micro usb plug (not the housing of the usb plug!)
 * change this if using mini usb
 */
usbCutX=8;
usbCutY=wallThickness;
usbCutZ=3.4;

/* space in lid for placing the controller pcb.
 * this example is for arduino pro micro clones.
 * if you use teensy2.0 or something else configure
 * the size of the controller pcb you use. the function
 * 'pcbCutout()' will add 1mm to 'pcbWidth' for some clearance.
 * pcbLength should be as exactly as possible. this keeps the pcb
 * perfectly even if pcbWidth is to much
 */
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


/* set colors for simulation */
colorCase="White";
colorLid="Green";
colorRiserR="Gold";
colorRiserL="Blue";

/* uncomment following line to get the keyboard simulation
 * with keycaps.
 */
KeyboardSim(isoDE_7583keyboard,true);

/* ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ */
/* ##### uncomment the keyboard part you want to print ##### */
/* vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv */

/* ### complete keyboard model ### */
/* mainCase(isoDE_7583keyboard); */
/* lid(); */

/* ### devided keyboard and lid model ### */
/* mainCaseLeft(isoDE_7583keyboard); */
/* translate([0, 150,0]) mainCaseRight(isoDE_7583keyboard); */

/* lidL(); */
/* lidR(); */

/* keyboardRiser(); */
