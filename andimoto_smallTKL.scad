/* andimoto_smallTKL.scad
Author: andimoto@posteo.de
----------------------------
for placing assambled parts and
single parts go to end of this file

this file contains the layout for my smallTKL keyboard 3d model which can be devided
to print on smaller printers

this file includes KeyV2 files. see https://github.com/rsheldiii/KeyV2
if you don't want this file to be included, just don't clone this library or
set the 'DoKeycapSimulation' parameter to false call for placing all keycaps on the keyboard.
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

ansiUS_smallTKL = [
//start ROW 0 Function ROW
[[0,0],1,"Gold"], //Esc
[[2,0],1,"Gold"], //F1
[[3,0],1,"Gold"], //F2
[[4,0],1,"Gold"], //F3
[[5,0],1,"Gold"], //F4
[[6.5,0],1,"Gold"], //F5
[[7.5,0],1,"Gold"], //F6
[[8.5,0],1,"Gold"], //F7
[[9.5,0],1,"Gold"], //F8
[[11,0],1,"Gold"], //F9
[[12,0],1,"Gold"], //F10
[[13,0],1,"Gold"], //F11
[[14,0],1,"Gold"], //F12
[[15.25,0],1,"Gold"], //PrintScreen
[[16.25,0],1,"Gold"], //PrintScreen
/* [[17,0],1,"Gray"], // Del/Ins */
//start ROW 1
[[  0,1],1,"Gold"], //'
[[1,1],1,"Gold"], //1
[[2,1],1,"Gold"], //2
[[3,1],1,"Gold"], //3
[[4,1],1,"Gold"], //4
[[5,1],1,"Gold"], //5
[[6,1],1,"Gold"], //6
[[7,1],1,"Gold"], //7
[[8,1],1,"Gold"], //8
[[9,1],1,"Gold"], //9
[[10,1],1,"Gold"], //0
[[11,1],1,"Gold"], //-_
[[12,1],1,"Gold"], //=+
[[13,1],2,"Gold"], //backspace
[[15.25,1],1,"Gold"], //ins
[[16.25,1],1,"Gold"], //pos1
//start ROW 2
[[  0,2],1.5,"Gold"], //TAB
[[1.5,2],1,"Gold"], //Q
[[2.5,2],1,"Gold"], //W
[[3.5,2],1,"Gold"], //E
[[4.5,2],1,"Gold"], //R
[[5.5,2],1,"Gold"], //T
[[6.5,2],1,"Gold"], //Y
[[7.5,2],1,"Gold"], //U
[[8.5,2],1,"Gold"], //I
[[9.5,2],1,"Gold"], //O
[[10.5,2],1,"Gold"], //P
[[11.5,2],1,"Gold"], //[
[[12.5,2],1,"Gold"], //]
[[13.5,2],1.5,"Gold"], // \
[[15.25,2],1,"Gold"], // del
[[16.25,2],1,"Gold"], // end
//start ROW 3
[[   0,3],1.75,"Gold"], //CapsLock
[[1.75,3],1,"Gold"], //A
[[2.75,3],1,"Gold"], //S
[[3.75,3],1,"Gold"], //D
[[4.75,3],1,"Gold"], //F
[[5.75,3],1,"Gold"], //G
[[6.75,3],1,"Gold"], //H
[[7.75,3],1,"Gold"], //J
[[8.75,3],1,"Gold"], //K
[[9.75,3],1,"Gold"], //L
[[10.75,3],1,"Gold"], //;
[[11.75,3],1,"Gold"], //'
[[12.75,3],2.25,"Gold"], //ENTER
//start ROW 4
[[   0,4],2.25,"Gold"], //LShift
[[2.25,4],1,"Gold"], //Z
[[3.25,4],1,"Gold"], //X
[[4.25,4],1,"Gold"], //C
[[5.25,4],1,"Gold"], //V
[[6.25,4],1,"Gold"], //B
[[7.25,4],1,"Gold"], //N
[[8.25,4],1,"Gold"], //M
[[9.25,4],1,"Gold"], //,
[[10.25,4],1,"Gold"], //.
[[11.25,4],1,"Gold"], // /
[[12.25,4],2.75,"Gold"], //RShift
[[15.25,4],1,"Gold"], //UP
//start ROW 5
[[   0,5],1.25,"Gold"], //LCTRL
[[1.25,5],1.25,"Gold"], //TUX
[[2.5 ,5],1.25,"Gold"], //ALT
[[3.75,5],6.25,"Gold"], //SPACE
[[10  ,5],1.25,"Gold"], //COMP
[[11.25,5],1.25,"Gold"], //Fn
[[12.5 ,5],1.25,"Gold"], //RCTRL
[[14.25,5],1,"Gold"], //LEFT
[[15.25,5],1,"Gold"], //DOWN
[[16.25,5],1,"Gold"], //RIGHT
];

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
 //pcbLength = 31.4;

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
[145,lkey-0.5],
[190,lkey-0.5],
[309.5,lkey-0.5], // right lower row

[24,lkey*3+wallThickness-3], //left mid row
[142.5,lkey*3+wallThickness-3],
[181,lkey*3+wallThickness-3],
[309.5,lkey*3+wallThickness-3], //right mid row

[24,lkey*5+wallThickness-3], //left upper row
[143,lkey*5+wallThickness-3],
[181,lkey*5+wallThickness-3],
[309.5,lkey*5+wallThickness-3], //right upper row
];

/* set colors for simulation */
colorCase="Gold";
colorLid="Gold";
colorRiserR="Gold";
colorRiserL="Gold";

/* uncomment following line to get the keyboard simulation
 * with keycaps. set DoKeycapSimulation to true or false to add
 * or remove keycap simulation
 */
/* KeyboardSim(ansiUS_smallTKL,false); */

/* ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ */
/* ##### uncomment the keyboard part you want to print ##### */
/* vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv */

/* ### complete keyboard model ### */
color("Gold") mainCase(ansiUS_smallTKL);
/* color("Gold") lid(); */

/* ### devided keyboard and lid model ### */
/* mainCaseLeft(ansiUS_smallTKL); */
/* mainCaseRight(ansiUS_smallTKL); */

/* lidL(); */
/* lidR(); */

/* keyboardRiser(); */
