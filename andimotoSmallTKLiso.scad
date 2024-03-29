/* andimoto_smallTKL_iso.scad
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

/* smallTKL_isoDE */
layout = [
//start ROW 0 Function ROW
[[0,0],1,"Red"], //Esc
[[2,0],1,"LightSkyBlue"], //F1
[[3,0],1,"LightSkyBlue"], //F2
[[4,0],1,"LightSkyBlue"], //F3
[[5,0],1,"LightSkyBlue"], //F4
[[6.5,0],1,"MidnightBlue"], //F5
[[7.5,0],1,"MidnightBlue"], //F6
[[8.5,0],1,"MidnightBlue"], //F7
[[9.5,0],1,"MidnightBlue"], //F8
[[11,0],1,"LightSkyBlue"], //F9
[[12,0],1,"LightSkyBlue"], //F10
[[13,0],1,"LightSkyBlue"], //F11
[[14,0],1,"LightSkyBlue"], //F12
[[15.25,0],1,"MidnightBlue"], //PrintScreen
[[16.25,0],1,"MidnightBlue"], //Pause

//start ROW 1
[[0,1],1,"LightSkyBlue"], //'
[[1,1],1,"LightSkyBlue"], //1
[[2,1],1,"LightSkyBlue"], //2
[[3,1],1,"LightSkyBlue"], //3
[[4,1],1,"LightSkyBlue"], //4
[[5,1],1,"LightSkyBlue"], //5
[[6,1],1,"LightSkyBlue"], //6
[[7,1],1,"LightSkyBlue"], //7
[[8,1],1,"LightSkyBlue"], //8
[[9,1],1,"LightSkyBlue"], //9
[[10,1],1,"LightSkyBlue"], //0
[[11,1],1,"LightSkyBlue"], //-_
[[12,1],1,"LightSkyBlue"], //=+
[[13,1],2,"MidnightBlue"], //backspace
[[15.25,1],1,"MidnightBlue"], //ins
[[16.25,1],1,"MidnightBlue"], //pos1
//start ROW 2
[[  0,2],1.5,"MidnightBlue"], //TAB
[[1.5,2],1,"LightSkyBlue"], //Q
[[2.5,2],1,"LightSkyBlue"], //W
[[3.5,2],1,"LightSkyBlue"], //E
[[4.5,2],1,"LightSkyBlue"], //R
[[5.5,2],1,"LightSkyBlue"], //T
[[6.5,2],1,"LightSkyBlue"], //Y
[[7.5,2],1,"LightSkyBlue"], //U
[[8.5,2],1,"LightSkyBlue"], //I
[[9.5,2],1,"LightSkyBlue"], //O
[[10.5,2],1,"LightSkyBlue"], //P
[[11.5,2],1,"LightSkyBlue"], //[
[[12.5,2],1,"LightSkyBlue"], //]
[[13.5,2.5],1.5,"Red"], // ENTER
[[15.25,2],1,"MidnightBlue"], // del
[[16.25,2],1,"MidnightBlue"], // end
//start ROW 3
[[   0,3],1.75,"MidnightBlue"], //CapsLock
[[1.75,3],1,"LightSkyBlue"], //A
[[2.75,3],1,"LightSkyBlue"], //S
[[3.75,3],1,"LightSkyBlue"], //D
[[4.75,3],1,"LightSkyBlue"], //F
[[5.75,3],1,"LightSkyBlue"], //G
[[6.75,3],1,"LightSkyBlue"], //H
[[7.75,3],1,"LightSkyBlue"], //J
[[8.75,3],1,"LightSkyBlue"], //K
[[9.75,3],1,"LightSkyBlue"], //L
[[10.75,3],1,"LightSkyBlue"], //;
[[11.75,3],1,"LightSkyBlue"], //'
[[12.75,3],1,"LightSkyBlue"], //#
//start ROW 4
[[   0,4],1.25,"MidnightBlue"], //LShift
[[1.25,4],1,"LightSkyBlue"], //Z
[[2.25,4],1,"LightSkyBlue"], //Z
[[3.25,4],1,"LightSkyBlue"], //X
[[4.25,4],1,"LightSkyBlue"], //C
[[5.25,4],1,"LightSkyBlue"], //V
[[6.25,4],1,"LightSkyBlue"], //B
[[7.25,4],1,"LightSkyBlue"], //N
[[8.25,4],1,"LightSkyBlue"], //M
[[9.25,4],1,"LightSkyBlue"], //,
[[10.25,4],1,"LightSkyBlue"], //.
[[11.25,4],1,"LightSkyBlue"], // /
[[12.25,4],2.75,"MidnightBlue"], //RShift
[[15.25,4],1,"MidnightBlue"], //UP
//start ROW 5
[[   0,5],1.25,"MidnightBlue"], //LCTRL
[[1.25,5],1.25,"MidnightBlue"], //TUX
[[2.5 ,5],1.25,"MidnightBlue"], //ALT
[[3.75,5],6.25,"LightSkyBlue"], //SPACE
[[10  ,5],1.25,"MidnightBlue"], //COMP
[[11.25,5],1.25,"MidnightBlue"], //Fn
[[12.5 ,5],1.25,"MidnightBlue"], //RCTRL
[[14.25,5],1,"MidnightBlue"], //LEFT
[[15.25,5],1,"MidnightBlue"], //DOWN
[[16.25,5],1,"MidnightBlue"], //RIGHT
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

/* rotate screw hole spacers */
screwSpacerRotation=0;

/* move horizontal case stabilizers inside the case.
 * to move horizontal by lkey/2 for half switch cutout.
 * this enables to set x.5 values in layout array.
 * else use 0!!
 */
caseStabMov=0;

/* set colors for simulation */
colorCase="DarkBlue";
colorLid="DarkBlue";
colorRiserR="DarkBlue";
colorRiserL="DarkBlue";

/* ###################### BUILD_LINE ########################*/
/* ##########################################################*/
/* All calls after this line have to be ignored by the build script.
 * Do not place any calls above build line (or comment it)
 */

/* uncomment following line to get the keyboard simulation
 * with keycaps.
 */
KeyboardSim(layout,false);

/* ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ */
/* ##### uncomment the keyboard part you want to print ##### */
/* vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv */

/* ### complete keyboard model ### */
/* mainCase(layout); */
/* translate([0,0,0]) lid(); */

/* ### devided keyboard and lid model ### */
/* mainCaseLeft(layout); */
/* translate([0,0,0]) mainCaseRight(layout); */

/* lidR(); */
/* lidL(); */

/* keyboardRiser(); */

/* test */
/* difference() {
  mainCaseRight(layout);
  lid();
  translate([-30,-20,0]) cube([300,200,30]);
  translate([305,-20,0]) cube([200,200,30]);
  translate([250,-125,0]) cube([200,200,30]);
} */
