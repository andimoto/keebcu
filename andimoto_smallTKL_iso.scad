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
cutAfterUnits = 8;
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

smallTKL_isoDE = [
//start ROW 0 Function ROW
[[0,0],1,"DarkSlateGray"], //Esc
[[2,0],1,"DarkSlateGray"], //F1
[[3,0],1,"DarkSlateGray"], //F2
[[4,0],1,"DarkSlateGray"], //F3
[[5,0],1,"DarkSlateGray"], //F4
[[6.5,0],1,"DarkSlateGray"], //F5
[[7.5,0],1,"DarkSlateGray"], //F6
[[8.5,0],1,"DarkSlateGray"], //F7
[[9.5,0],1,"DarkSlateGray"], //F8
[[11,0],1,"DarkSlateGray"], //F9
[[12,0],1,"DarkSlateGray"], //F10
[[13,0],1,"DarkSlateGray"], //F11
[[14,0],1,"DarkSlateGray"], //F12
[[15.25,0],1,"DarkSlateGray"], //PrintScreen
[[16.25,0],1,"DarkSlateGray"], //Pause

//start ROW 1
[[0,1],1,"DarkSlateGray"], //'
[[1,1],1,"DarkSlateGray"], //1
[[2,1],1,"DarkSlateGray"], //2
[[3,1],1,"DarkSlateGray"], //3
[[4,1],1,"DarkSlateGray"], //4
[[5,1],1,"DarkSlateGray"], //5
[[6,1],1,"DarkSlateGray"], //6
[[7,1],1,"DarkSlateGray"], //7
[[8,1],1,"DarkSlateGray"], //8
[[9,1],1,"DarkSlateGray"], //9
[[10,1],1,"DarkSlateGray"], //0
[[11,1],1,"DarkSlateGray"], //-_
[[12,1],1,"DarkSlateGray"], //=+
[[13,1],2,"DarkSlateGray"], //backspace
[[15.25,1],1,"DarkSlateGray"], //ins
[[16.25,1],1,"DarkSlateGray"], //pos1
//start ROW 2
[[  0,2],1.5,"DarkSlateGray"], //TAB
[[1.5,2],1,"DarkSlateGray"], //Q
[[2.5,2],1,"DarkSlateGray"], //W
[[3.5,2],1,"DarkSlateGray"], //E
[[4.5,2],1,"DarkSlateGray"], //R
[[5.5,2],1,"DarkSlateGray"], //T
[[6.5,2],1,"DarkSlateGray"], //Y
[[7.5,2],1,"DarkSlateGray"], //U
[[8.5,2],1,"DarkSlateGray"], //I
[[9.5,2],1,"DarkSlateGray"], //O
[[10.5,2],1,"DarkSlateGray"], //P
[[11.5,2],1,"DarkSlateGray"], //[
[[12.5,2],1,"DarkSlateGray"], //]
[[13.5,2.5],1.5,"DarkSlateGray"], // ENTER
[[15.25,2],1,"DarkSlateGray"], // del
[[16.25,2],1,"DarkSlateGray"], // end
//start ROW 3
[[   0,3],1.75,"DarkSlateGray"], //CapsLock
[[1.75,3],1,"DarkSlateGray"], //A
[[2.75,3],1,"DarkSlateGray"], //S
[[3.75,3],1,"DarkSlateGray"], //D
[[4.75,3],1,"DarkSlateGray"], //F
[[5.75,3],1,"DarkSlateGray"], //G
[[6.75,3],1,"DarkSlateGray"], //H
[[7.75,3],1,"DarkSlateGray"], //J
[[8.75,3],1,"DarkSlateGray"], //K
[[9.75,3],1,"DarkSlateGray"], //L
[[10.75,3],1,"DarkSlateGray"], //;
[[11.75,3],1,"DarkSlateGray"], //'
[[12.75,3],1,"DarkSlateGray"], //#
//start ROW 4
[[   0,4],1.25,"DarkSlateGray"], //LShift
[[1.25,4],1,"DarkSlateGray"], //Z
[[2.25,4],1,"DarkSlateGray"], //Z
[[3.25,4],1,"DarkSlateGray"], //X
[[4.25,4],1,"DarkSlateGray"], //C
[[5.25,4],1,"DarkSlateGray"], //V
[[6.25,4],1,"DarkSlateGray"], //B
[[7.25,4],1,"DarkSlateGray"], //N
[[8.25,4],1,"DarkSlateGray"], //M
[[9.25,4],1,"DarkSlateGray"], //,
[[10.25,4],1,"DarkSlateGray"], //.
[[11.25,4],1,"DarkSlateGray"], // /
[[12.25,4],2.75,"DarkSlateGray"], //RShift
[[15.25,4],1,"DarkSlateGray"], //UP
//start ROW 5
[[   0,5],1.25,"DarkSlateGray"], //LCTRL
[[1.25,5],1.25,"DarkSlateGray"], //TUX
[[2.5 ,5],1.25,"DarkSlateGray"], //ALT
[[3.75,5],6.25,"DarkSlateGray"], //SPACE
[[10  ,5],1.25,"DarkSlateGray"], //COMP
[[11.25,5],1.25,"DarkSlateGray"], //Fn
[[12.5 ,5],1.25,"DarkSlateGray"], //RCTRL
[[14.25,5],1,"DarkSlateGray"], //LEFT
[[15.25,5],1,"DarkSlateGray"], //DOWN
[[16.25,5],1,"DarkSlateGray"], //RIGHT
];

/* set this variable to the amount of the rows of your LAYOUT.
 * this will be used in "calcRight" module to add wallThickness
 * to the cut in y direction.
 */
MaxRows = 6;

/* move pcb and usb cutout in x direction
   for better placement */
pcbShift=6;

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
[23,lkey-0.4], //left lower row
[144,lkey-0.4],
[186,lkey-0.4],
[310,lkey-0.4], // right lower row

[25,lkey*3+wallThickness-3], //left mid row
[144,lkey*3+wallThickness-3],
[186,lkey*3+wallThickness-3],
[310,lkey*3+wallThickness-3], //right mid row

[20,lkey*5+wallThickness-3], //left upper row
[144,lkey*5+wallThickness-3],
[186,lkey*5+wallThickness-3],
[310,lkey*5+wallThickness-3], //right upper row
];


/* set colors for simulation */
colorCase="DarkBlue";
colorLid="DarkBlue";
colorRiserR="DarkBlue";
colorRiserL="DarkBlue";

/* uncomment following line to get the keyboard simulation
 * with keycaps.
 */
KeyboardSim(smallTKL_isoDE,false);

/* ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ */
/* ##### uncomment the keyboard part you want to print ##### */
/* vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv */

/* ### complete keyboard model ### */
/* mainCase(smallTKL_isoDE); */
/* translate([0,0,0]) lid(); */

/* ### devided keyboard and lid model ### */
/* mainCaseLeft(smallTKL_isoDE); */
/* translate([0,0,0]) mainCaseRight(smallTKL_isoDE); */

/* lidR(); */
/* lidL(); */

/* keyboardRiser(); */

/* test */
/* difference() {
  mainCaseRight(smallTKL_isoDE);
  lid();
  translate([-30,-20,0]) cube([300,200,30]);
  translate([305,-20,0]) cube([200,200,30]);
  translate([250,-125,0]) cube([200,200,30]);
} */
