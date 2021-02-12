/* 75erKeyboard.scad
Author: andimoto@posteo.de
----------------------------
for placing assambled parts and
single parts go to end of this file

this file includes KeyV2 files. see https://github.com/rsheldiii/KeyV2
if you don't want this file to be included, just don't clone this library or
remove the call for placing all keycaps on the keyboard.
*/

include <../KeyV2/includes.scad>
/* todo:
- USB Connector Check: to be tested
- Stabilizers : changed - to be tested
- Controller Plate Size: in Progress
- calcRight function uses different formula: need to be fixed
- implement cherry style stabs

 */


$fn=30;
//Thickness of entire plate
plateThickness=3;
/* thickness of the walls */
wallThickness=3;
/* height of the case */
caseHeight=13;

lidThickness=3;

caseRadius=1;

//Unit square length, from Cherry MX data sheet
lkey=19.05;
//Hole size, from Cherry MX data sheet
holesize=14;
//length, in units, of board
width=16;
//Height, in units, of board
height=6;
//Radius of mounting holes
mountingholeradius=2;
//height of switch clasp cutouts
cutoutheight = 3;
//width of switch clasp cutouts
cutoutwidth = 1;

//calculated vars

holediff=lkey-holesize;
w=width*lkey;
h=height*lkey;

cutLength = 0;

/* for costar style stab cutouts */
stabX=3.3;//6.75;
stabCutoutWidth=0.825;

/* these are the values of the costar style stabilizers */
shortStabX=24;
longStabX=101;

/* debug extra for avoid rendering always */
extra=1;
tempHeigth=caseHeight-plateThickness+extra;

ansiUS_7581keyboard = [
//start ROW 0 Function ROW
[[0,0],1,"red"], //Esc
[[1.5,0],1,"MintCream"], //F1
[[2.5,0],1,"MintCream"], //F2
[[3.5,0],1,"MintCream"], //F3
[[4.5,0],1,"MintCream"], //F4
[[6,0],1,"Gray"], //F5
[[7,0],1,"Gray"], //F6
[[8,0],1,"Gray"], //F7
[[9,0],1,"Gray"], //F8
[[10.5,0],1,"MintCream"], //F9
[[11.5,0],1,"MintCream"], //F10
[[12.5,0],1,"MintCream"], //F11
[[13.5,0],1,"MintCream"], //F12
[[15,0],1,"Gray"], // Del/Ins
//start ROW 1
[[  0,1],1,"MintCream"], //'
[[1,1],1,"MintCream"], //1
[[2,1],1,"MintCream"], //2
[[3,1],1,"MintCream"], //3
[[4,1],1,"MintCream"], //4
[[5,1],1,"MintCream"], //5
[[6,1],1,"MintCream"], //6
[[7,1],1,"MintCream"], //7
[[8,1],1,"MintCream"], //8
[[9,1],1,"MintCream"], //9
[[10,1],1,"MintCream"], //0
[[11,1],1,"MintCream"], //-_
[[12,1],1,"MintCream"], //=+
[[13,1],2,"Gray"], //backspace
[[15,1],1,"Gray"], //home
//start ROW 2
[[  0,2],1.5,"Gray"], //TAB
[[1.5,2],1,"MintCream"], //Q
[[2.5,2],1,"MintCream"], //W
[[3.5,2],1,"MintCream"], //E
[[4.5,2],1,"MintCream"], //R
[[5.5,2],1,"MintCream"], //T
[[6.5,2],1,"MintCream"], //Y
[[7.5,2],1,"MintCream"], //U
[[8.5,2],1,"MintCream"], //I
[[9.5,2],1,"MintCream"], //O
[[10.5,2],1,"MintCream"], //P
[[11.5,2],1,"MintCream"], //[
[[12.5,2],1,"MintCream"], //]
[[13.5,2],1.5,"MintCream"], // \
[[15,2],1,"Gray"], // PgUp
//start ROW 3
[[   0,3],1.75,"Gray"], //CapsLock
[[1.75,3],1,"MintCream"], //A
[[2.75,3],1,"MintCream"], //S
[[3.75,3],1,"MintCream"], //D
[[4.75,3],1,"MintCream"], //F
[[5.75,3],1,"MintCream"], //G
[[6.75,3],1,"MintCream"], //H
[[7.75,3],1,"MintCream"], //J
[[8.75,3],1,"MintCream"], //K
[[9.75,3],1,"MintCream"], //L
[[10.75,3],1,"MintCream"], //;
[[11.75,3],1,"MintCream"], //'
[[12.75,3],2.25,"Aqua"], //ENTER
[[15,3],1,"Gray"], //PgDn
//start ROW 4
[[   0,4],2.25,"Gray"], //LShift
[[2.25,4],1,"MintCream"], //Z
[[3.25,4],1,"MintCream"], //X
[[4.25,4],1,"MintCream"], //C
[[5.25,4],1,"MintCream"], //V
[[6.25,4],1,"MintCream"], //B
[[7.25,4],1,"MintCream"], //N
[[8.25,4],1,"MintCream"], //M
[[9.25,4],1,"MintCream"], //,
[[10.25,4],1,"MintCream"], //.
[[11.25,4],1,"MintCream"], // /
[[12.25,4],1.75,"Gray"], //RShift
[[14,4],1,"Gray"], //UP
[[15,4],1,"Gray"], //end
//start ROW 5
[[   0,5],1.25,"Gray"], //LCTRL
[[1.25,5],1.25,"Gray"], //TUX
[[2.5 ,5],1.25,"Gray"], //ALT
[[3.75,5],6.25,"MintCream"], //SPACE
[[10  ,5],1.25,"Gray"], //COMP
[[11.25,5],1.25,"Gray"], //Fn
/* [[12 ,5],1], //RCTRL */
[[13,5],1,"Gray"], //LEFT
[[14,5],1,"Gray"], //DOWN
[[15,5],1,"Gray"], //RIGHT
];


ansiUS_7583keyboard = [
//start ROW 0 Function ROW
[[0,0],1,"red"], //Esc
[[1,0],1,"MintCream"], //F1
[[2,0],1,"MintCream"], //F2
[[3,0],1,"MintCream"], //F3
[[4,0],1,"MintCream"], //F4
[[5,0],1,"Gray"], //F5
[[6,0],1,"Gray"], //F6
[[7,0],1,"Gray"], //F7
[[8,0],1,"Gray"], //F8
[[9,0],1,"MintCream"], //F9
[[10,0],1,"MintCream"], //F10
[[11,0],1,"MintCream"], //F11
[[12,0],1,"MintCream"], //F12
[[13,0],1,"Gray"], //PrintScreen
[[14,0],1,"Gray"], //PrintScreen
[[15,0],1,"Gray"], // Del/Ins
//start ROW 1
[[  0,1],1,"MintCream"], //'
[[1,1],1,"MintCream"], //1
[[2,1],1,"MintCream"], //2
[[3,1],1,"MintCream"], //3
[[4,1],1,"MintCream"], //4
[[5,1],1,"MintCream"], //5
[[6,1],1,"MintCream"], //6
[[7,1],1,"MintCream"], //7
[[8,1],1,"MintCream"], //8
[[9,1],1,"MintCream"], //9
[[10,1],1,"MintCream"], //0
[[11,1],1,"MintCream"], //-_
[[12,1],1,"MintCream"], //=+
[[13,1],2,"Gray"], //backspace
[[15,1],1,"Gray"], //home
//start ROW 2
[[  0,2],1.5,"Gray"], //TAB
[[1.5,2],1,"MintCream"], //Q
[[2.5,2],1,"MintCream"], //W
[[3.5,2],1,"MintCream"], //E
[[4.5,2],1,"MintCream"], //R
[[5.5,2],1,"MintCream"], //T
[[6.5,2],1,"MintCream"], //Y
[[7.5,2],1,"MintCream"], //U
[[8.5,2],1,"MintCream"], //I
[[9.5,2],1,"MintCream"], //O
[[10.5,2],1,"MintCream"], //P
[[11.5,2],1,"MintCream"], //[
[[12.5,2],1,"MintCream"], //]
[[13.5,2],1.5,"MintCream"], // \
[[15,2],1,"Gray"], // PgUp
//start ROW 3
[[   0,3],1.75,"Gray"], //CapsLock
[[1.75,3],1,"MintCream"], //A
[[2.75,3],1,"MintCream"], //S
[[3.75,3],1,"MintCream"], //D
[[4.75,3],1,"MintCream"], //F
[[5.75,3],1,"MintCream"], //G
[[6.75,3],1,"MintCream"], //H
[[7.75,3],1,"MintCream"], //J
[[8.75,3],1,"MintCream"], //K
[[9.75,3],1,"MintCream"], //L
[[10.75,3],1,"MintCream"], //;
[[11.75,3],1,"MintCream"], //'
[[12.75,3],2.25,"Aqua"], //ENTER
[[15,3],1,"Gray"], //PgDn
//start ROW 4
[[   0,4],2.25,"Gray"], //LShift
[[2.25,4],1,"MintCream"], //Z
[[3.25,4],1,"MintCream"], //X
[[4.25,4],1,"MintCream"], //C
[[5.25,4],1,"MintCream"], //V
[[6.25,4],1,"MintCream"], //B
[[7.25,4],1,"MintCream"], //N
[[8.25,4],1,"MintCream"], //M
[[9.25,4],1,"MintCream"], //,
[[10.25,4],1,"MintCream"], //.
[[11.25,4],1,"MintCream"], // /
[[12.25,4],1.75,"Gray"], //RShift
[[14,4],1,"Gray"], //UP
[[15,4],1,"Gray"], //end
//start ROW 5
[[   0,5],1.25,"Gray"], //LCTRL
[[1.25,5],1.25,"Gray"], //TUX
[[2.5 ,5],1.25,"Gray"], //ALT
[[3.75,5],6.25,"MintCream"], //SPACE
[[10  ,5],1.25,"Gray"], //COMP
[[11.25,5],1.25,"Gray"], //Fn
/* [[12 ,5],1], //RCTRL */
[[13,5],1,"Gray"], //LEFT
[[14,5],1,"Gray"], //DOWN
[[15,5],1,"Gray"], //RIGHT
];

isoDE_7583keyboard = [
//start ROW 0 Function ROW
[[0,0],1,"red"], //Esc
[[1,0],1,"MintCream"], //F1
[[2,0],1,"MintCream"], //F2
[[3,0],1,"MintCream"], //F3
[[4,0],1,"MintCream"], //F4
[[5,0],1,"Gray"], //F5
[[6,0],1,"Gray"], //F6
[[7,0],1,"Gray"], //F7
[[8,0],1,"Gray"], //F8
[[9,0],1,"MintCream"], //F9
[[10,0],1,"MintCream"], //F10
[[11,0],1,"MintCream"], //F11
[[12,0],1,"MintCream"], //F12
[[13,0],1,"Gray"], //PrintScreen
[[14,0],1,"Gray"], //PrintScreen
[[15,0],1,"Gray"], // Del/Ins
//start ROW 1
[[  0,1],1,"MintCream"], //'
[[1,1],1,"MintCream"], //1
[[2,1],1,"MintCream"], //2
[[3,1],1,"MintCream"], //3
[[4,1],1,"MintCream"], //4
[[5,1],1,"MintCream"], //5
[[6,1],1,"MintCream"], //6
[[7,1],1,"MintCream"], //7
[[8,1],1,"MintCream"], //8
[[9,1],1,"MintCream"], //9
[[10,1],1,"MintCream"], //0
[[11,1],1,"MintCream"], //-_
[[12,1],1,"MintCream"], //=+
[[13,1],2,"Gray"], //backspace
[[15,1],1,"Gray"], //home
//start ROW 2
[[  0,2],1.5,"Gray"], //TAB
[[1.5,2],1,"MintCream"], //Q
[[2.5,2],1,"MintCream"], //W
[[3.5,2],1,"MintCream"], //E
[[4.5,2],1,"MintCream"], //R
[[5.5,2],1,"MintCream"], //T
[[6.5,2],1,"MintCream"], //Y
[[7.5,2],1,"MintCream"], //U
[[8.5,2],1,"MintCream"], //I
[[9.5,2],1,"MintCream"], //O
[[10.5,2],1,"MintCream"], //P
[[11.5,2],1,"MintCream"], //[
[[12.5,2],1,"MintCream"], //]
[[13.5,2.5],1.5,"MintCream"], // ENTER
[[15,2],1,"Gray"], // PgUp
//start ROW 3
[[   0,3],1.75,"Gray"], //CapsLock
[[1.75,3],1,"MintCream"], //A
[[2.75,3],1,"MintCream"], //S
[[3.75,3],1,"MintCream"], //D
[[4.75,3],1,"MintCream"], //F
[[5.75,3],1,"MintCream"], //G
[[6.75,3],1,"MintCream"], //H
[[7.75,3],1,"MintCream"], //J
[[8.75,3],1,"MintCream"], //K
[[9.75,3],1,"MintCream"], //L
[[10.75,3],1,"MintCream"], //;
[[11.75,3],1,"MintCream"], //'
[[12.75,3],1,"MintCream"], //#
[[15,3],1,"Gray"], //PgDn
//start ROW 4
[[   0,4],1.25,"Gray"], //LShift
[[1.25,4],1,"MintCream"], //Z
[[2.25,4],1,"MintCream"], //Z
[[3.25,4],1,"MintCream"], //X
[[4.25,4],1,"MintCream"], //C
[[5.25,4],1,"MintCream"], //V
[[6.25,4],1,"MintCream"], //B
[[7.25,4],1,"MintCream"], //N
[[8.25,4],1,"MintCream"], //M
[[9.25,4],1,"MintCream"], //,
[[10.25,4],1,"MintCream"], //.
[[11.25,4],1,"MintCream"], // /
[[12.25,4],1.75,"Gray"], //RShift
[[14,4],1,"Gray"], //UP
[[15,4],1,"Gray"], //end
//start ROW 5
[[   0,5],1.25,"Gray"], //LCTRL
[[1.25,5],1.25,"Gray"], //TUX
[[2.5 ,5],1.25,"Gray"], //ALT
[[3.75,5],6.25,"MintCream"], //SPACE
[[10  ,5],1.25,"Gray"], //COMP
[[11.25,5],1.25,"Gray"], //Fn
/* [[12 ,5],1], //RCTRL */
[[13,5],1,"Gray"], //LEFT
[[14,5],1,"Gray"], //DOWN
[[15,5],1,"Gray"], //RIGHT
];



module plate(w,h){
	difference() {
		minkowski() {
			cube([w,h,caseHeight]);
			cylinder(r=caseRadius, h=0.0000000001, center=true);
	  }
		translate([wallThickness,wallThickness,-extra])
		minkowski() {
			cube([w-(wallThickness*2),h-(wallThickness*2),tempHeigth]);
			cylinder(r=caseRadius, h=0.0000000001, center=true);
		}
		/* translate([-2,-2,-2]) cube([10,130,20]); */
	}
}



switchHoleTolerance = -0.2;
module switchhole(){
	union(){
		translate([0,0,-extra/2])
		cube([holesize+switchHoleTolerance,holesize+switchHoleTolerance,plateThickness+extra]);

		/* translate([-cutoutwidth,1,-extra/2])
		cube([holesize+2*cutoutwidth,cutoutheight,plateThickness+extra]);

		translate([-cutoutwidth,holesize-cutoutwidth-cutoutheight,-extra/2])
		cube([holesize+2*cutoutwidth,cutoutheight,plateThickness+extra]); */
	}
}

module costarStabilizer(){
	union(){
		translate([-stabX/2,0,-0.8])
		cube([stabX,holesize+1,plateThickness/*+extra*/]);
		translate([-stabX/2,0.25,plateThickness-0.8])
		cube([stabX,holesize+0.5,1+extra]);
	}
}
/* costarStabilizer(); */

costarStabYdelta = -0.5;
module holematrix(holes,startx,starty,zCase){
	for (key = holes){
		/* echo (key[0][0],key[0][1],key[1]); */
		translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
		translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
		switchhole();

		/* remove comment to show root of holesize */
		/* translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
		translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
		#cylinder(r=0.1,h=10); */

		if (key[1]>1.75){
			temp=lkey*key[1];
			/* echo("Stab! ", temp); */

			if(key[1]>6)
			{
				/* stabilizers for spacebar */
				translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
				translate([(lkey*key[1]-holesize)/2+(holesize/2)-longStabX/2,(lkey - holesize)/2+costarStabYdelta, 0])
				costarStabilizer();

				translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
				translate([(lkey*key[1]+holesize)/2-(holesize/2)+longStabX/2,(lkey - holesize)/2+costarStabYdelta, 0])
				costarStabilizer();
			}
			else
			{
				/* other stabilizers than spacebar */
				translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
				translate([(lkey*key[1]-holesize)/2+(holesize/2)-shortStabX/2,(lkey - holesize)/2+costarStabYdelta, 0])
				costarStabilizer();

				translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
				translate([(lkey*key[1]+holesize)/2-(holesize/2)+shortStabX/2,(lkey - holesize)/2+costarStabYdelta, 0])
				costarStabilizer();
			}
		}
		if(key[0][1]==2.5)
		{
			/* other stabilizers than spacebar */
			translate([19.7,-5,0])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
			translate([(lkey*key[1]-holesize)/2+(holesize/2)-shortStabX/2,(lkey - holesize)/2+costarStabYdelta, 0])
			rotate([0,0,90]) costarStabilizer();

			translate([-4.7,20,0])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
			translate([(lkey*key[1]+holesize)/2-(holesize/2)+shortStabX/2,(lkey - holesize)/2+costarStabYdelta, 0])
			rotate([0,0,90]) costarStabilizer();
		}
	}
}




module caseStabilizer(w,h,holes,startx,starty,zCase)
{
	for (key = holes){
		if(key[0][1]!=2.5){
			translate([0,lkey*key[0][1]-caseRadius,caseHeight-plateThickness-5])
			cube([w,1,5]);
		}
	}

	for (key = holes){
		if(key[0][1]!=2.5){
			translate([startx+lkey*key[0][0]+lkey*key[1]-1,starty-lkey*key[0][1],caseHeight-plateThickness-2])
			cube([1,lkey,2]);
		}
		/*put some stabilizer profiles to spacebar*/
		if(key[1]>6)
		{
			translate([startx+lkey*key[0][0]+lkey*key[1]/3,starty-lkey*key[0][1],caseHeight-plateThickness-2])
			cube([1,lkey,2]);
			translate([startx+lkey*key[0][0]+lkey*key[1]/1.5,starty-lkey*key[0][1],caseHeight-plateThickness-2])
			cube([1,lkey,2]);
		}
	}
}


switchSimArray = [
[0,0],
[holesize,0],
[holesize-holesize/4,holesize/2],
[holesize-3*holesize/4,holesize/2]];
module switchSim()
{
	translate([-7,-7,0]) union()
	{
		translate([0,10.5,0]) rotate([90,0,0]) linear_extrude(7) polygon(switchSimArray);
		translate([3.5,0,0]) rotate([90,0,90]) linear_extrude(7) polygon(switchSimArray);

		translate([0,3.5,0]) rotate([270,0,0]) linear_extrude(7) polygon(switchSimArray);
		translate([3.5,14,0]) rotate([90,180,90]) linear_extrude(7) polygon(switchSimArray);
	}
}
/* switchSim(); */


module keySim(holes,startx,starty,zCase)
{
	for (key = holes){
		translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
		translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, -14])
		color("black") switchSim();

		if (key[1]==6.25){
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			6_25u() dsa_row(key[0][1]) key();
		}

		else if (key[1]==2.75){
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			2_75u() dsa_row(key[0][1]) key();
		}

		else if (key[1]==2.25){
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			2_25u() dsa_row(key[0][1]) key();
		}
		else if (key[1]==2){
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			2u() dsa_row(key[0][1]) key();
		}
		else if (key[1]==1.75){
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			u(u=1.75) dsa_row(key[0][1]) key();
		}
		else if (key[1]==1.5){
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			1_5u() dsa_row(key[0][1]) key();
		}
		else if (key[1]==1.25){
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			1_25u() dsa_row(key[0][1]) key();
		}
		else
		{
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			1u() dsa_row(key[0][1]) key();
		}
	}
}

module calcRight(holes,startx,starty,zCase){
	for (key = holes){
		/* echo (key[0][0],key[0][1],key[1]); */
		translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
		translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
		switchhole();
		/* cube([holesize+switchHoleTolerance,holesize+switchHoleTolerance,5]); */

		cutLength = cutLength + lkey*key[0][0];
		/* echo(cutLength); */
		if(cutLength <= 7.25*lkey)
		{
			temp=key[1];
			/* echo(temp); */

			if(key[0][1]==0)
			{
				translate([cutLength-1,starty-lkey*key[0][1],0])
					cube([1+startx+lkey*temp,lkey+5,caseHeight+extra*2]);
			}

			if(key[0][1]==0 && key[0][0]==0)
			{
				translate([cutLength,starty-lkey*key[0][1],0])
					cube([startx+lkey*temp+lkey*0.5,lkey+5,caseHeight+extra*2]);
			}

			if(key[0][1]==0 && key[0][0]==4.5)
			{
				translate([cutLength,starty-lkey*key[0][1],0])
					cube([startx+lkey*temp+lkey*0.5,lkey+5,caseHeight+extra*2]);
			}
			if(key[0][1]==1)
			{
				translate([cutLength-1,starty-lkey*key[0][1],0])
					cube([1+startx+lkey*temp,lkey,caseHeight+extra*2]);
			}
			if(key[0][1]==2)
			{
				translate([cutLength-1,starty-lkey*key[0][1],0])
					cube([1+startx+lkey*temp,lkey,caseHeight+extra*2]);
			}
			if(key[0][1]==3)
			{
				translate([cutLength-1,starty-lkey*key[0][1],0])
					cube([1+startx+lkey*temp,lkey,caseHeight+extra*2]);
			}
			if(key[0][1]==4)
			{
				translate([cutLength-1,starty-lkey*key[0][1],0])
				cube([1+startx+lkey*temp,lkey,caseHeight+extra*2]);
			}
			if(key[0][1]==5)
			{
				if(temp>6){
					 temp = 4.5;
					 translate([cutLength-1,starty-extra-lkey*key[0][1]-0.1,0])
		 		   cube([1+startx+lkey*temp,lkey+extra+0.1,caseHeight+extra*2]);
				}else{
					translate([cutLength-1,starty-extra-lkey*key[0][1]-0.1,0])
					cube([1+startx+lkey*temp,lkey+extra+0.1,caseHeight+extra*2]);
				}
			} /*if(key[0][1])*/
		} /*if(cutLength)*/
	} /*for*/
}

module screwHole(r1=2.5,r2=1.5,
	h1=caseHeight-plateThickness-1,h2=caseHeight-1)
{
	difference() {
	cylinder(r=r1, h=h1);
	cylinder(r=r2, h=h2);
	}
}

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

module caseScrewHolesLoop(r10=2.5,r20=1.5)
{
	for(hole = screwHoleArray)
	{
		translate([hole[0],hole[1],1])
		screwHole(r1=r10,r2=r20);
	}
}

module lidScrewHolesLoop(c1=1.5)
{
	for(hole = screwHoleArray)
	{
		translate([hole[0],hole[1],0])
		cylinder(r=c1,h=lidThickness+1);
	}
}

usbCutX=8;
usbCutY=wallThickness;
usbCutZ=3.4;
module usbCutout()
{
	translate([0,-0.1,0]) cube([usbCutX,usbCutY,usbCutZ]);
	translate([-1.5,1,-2]) cube([usbCutX+3,usbCutY,usbCutZ+4]);
}

cPlateHeight=0.6; //mm
module controllerPlate()
{
	difference() {
		union()
		{
			cube([lkey,2*lkey,cPlateHeight]);
			translate([(lkey-3),0,cPlateHeight]) cube([3,2*lkey,3]);
			translate([0,0,cPlateHeight]) cube([3,2*lkey,3]);
		}
		translate([0,1-0.1,cPlateHeight]) cube([lkey,1.2,3]);
		translate([0,lkey+1-0.1,cPlateHeight]) cube([lkey,1.2,3]);
		translate([0,lkey+6.5-0.1,cPlateHeight]) cube([lkey,10,3]);
		translate([0,7-0.1,cPlateHeight]) cube([lkey,10,3]);
	}
}

pcbHeight = 2;
pcbWidth = 18;
pcbLength = 34;

module pcbCutout()
{
	difference() {
		union()
		{
			/* add 2mm clearance to pcb size */
			cube([pcbWidth+2,pcbLength,pcbHeight]);
		}
	}
}

points = [
[0,0],
[0,2],
[6,2],
[6,1],
[5,0]
];
module pcbHolder()
{
	translate([3,pcbLength,0]) rotate([90,0,0]) linear_extrude(pcbLength) polygon(points);
	mirror([1,0,0]) translate([-33,pcbLength,0]) rotate([90,0,0]) linear_extrude(pcbLength) polygon(points);
	translate([8,-5,0]) rotate([90,0,90]) linear_extrude(20) polygon(points);
	/* translate([3,-1,0]) cube([16,2,2]);
	mirror([1,0,0]) translate([-33,-1,0]) cube([16,2,2]); */
}

/* pcbHolder(); */
/* translate([9,0,0]) pcbCutout(); */

module lid()
{
	difference()
	{
		union()
		{
			minkowski() {
				cube([w,h,lidThickness]);
				cylinder(r=1, h=0.0000000001, center=true);
			}

			translate([wallThickness+extra/4,wallThickness+extra/4,1]) minkowski() {
				cube([w-(wallThickness*2)-extra/2,h-(wallThickness*2)-extra/2,lidThickness]);
				cylinder(r=1, h=0.0000000001, center=true);
			}


		}

		/* subtract screw holes */
		lidScrewHolesLoop(c1=1.8);
		translate([0,0,-1]) lidScrewHolesLoop(c1=2.8);


		/* subtract cutouts for risers */
		translate([40+angleBaseX/2,0,0]) riserConnector(conHeight=lidThickness+1);
		translate([w-40-angleBaseX/2,0,0]) riserConnector(conHeight=lidThickness+1);

		/* subtract usb cutout and pcb cutout */
		translate([(w-lkey*3)-1,h-wallThickness+5-2*lkey,3]) pcbCutout();
		translate([(w+5-lkey*3),h-2,4]) usbCutout();
	}


	/* add pcb holder */
	translate([(w-lkey*3)-pcbWidth/2,h-wallThickness+5-2*lkey-extra/8,4])
	pcbHolder();
}



module 75plate(keyboardLayout){
	difference(){
		plate(w,h);
		holematrix(keyboardLayout,0,h-lkey,tempHeigth);
		/* translate([-8,-5,0]) cube([10,130,20]); */
		/* mountingholes(); */
		translate([(w+5-lkey*3),h-2,1]) usbCutout();
	}
	caseStabilizer(w,h,keyboardLayout,0,h-lkey,tempHeigth);
	/* caseScrewHoles(); */
	caseScrewHolesLoop(r10=2.5,r20=1.45);
	/* #translate([0,0,-lidThickness-extra]) lid(); */
}


module 75plate01(keyboardLayout)
{
	difference() {
		75plate(keyboardLayout);
		calcRight(keyboardLayout,0,h-lkey,tempHeigth);
	}
}

module 75plate02(keyboardLayout)
{
	difference() {
		75plate(keyboardLayout);
		75plate01(keyboardLayout);
		translate([200,0,0])
		cube([(w+2*caseRadius)/2+extra,h+2*caseRadius+extra,caseHeight]);
	}
}

module lidR()
{
	difference() {
		lid();
		translate([-caseRadius-extra,-caseRadius-extra,-extra])
		cube([(w+2*caseRadius)/2+extra,h+2*caseRadius+extra,caseHeight]);
	}
}

module lidL()
{
	difference() {
		lid();
		translate([(w+2*caseRadius)/2-extra,-caseRadius-extra,-extra])
		cube([(w+2*caseRadius)/2+extra,h+2*caseRadius+extra,caseHeight]);
	}
}


angleBaseY=110;
angleBaseX=60;
angleBaseRad=1;
riserPoints = [
[0,0],
[angleBaseY,0],
[0,18]
];
module riser()
{
	union()
	{
		minkowski() {
			difference() {
				rotate([90,180,90]) linear_extrude(height=angleBaseX) polygon(riserPoints);
				translate([-1,-angleBaseY,-10]) cube([angleBaseX+angleBaseRad*2,20,10]);
			}
			cylinder(r=angleBaseRad, h=0.0000000001, center=true);
		}
	}
}

module riserConnector(rCon=5,conHeight=3)
{
	translate([0,angleBaseY/3,0]) cylinder(r=rCon, h=conHeight);
	translate([0,angleBaseY-angleBaseY/4,0]) cylinder(r=rCon, h=conHeight);
}

module keyboardRiser()
{
	translate([40,105,-lidThickness]) riser();
	translate([40+angleBaseX/2,0,-lidThickness]) riserConnector(rCon=4.98, conHeight=lidThickness);
}

/* keyboardRiser(); */

/* translate([w-40-angleBaseX,105,-lidThickness]) riser();
translate([w-40-angleBaseX/2,0,-lidThickness]) riserConnector(rCon=4.98, conHeight=lidThickness); */


/* translate([0,0,-3]) color("White") lid(); */
/* rotate([180,0,0]) translate([0,10,-15]) color("grey") lidR(); */
/* rotate([180,0,0]) translate([-1,10,-15]) color("grey") lidL(); */
/* translate([0,0,-3]) color("White") lidR(); */
/* translate([0,0,-3]) color("White") lidL(); */
/* color("Gainsboro") 75plate(ansiUS_7581keyboard); */
/* color("#e4d1c4") 75plate(ansiUS_7583keyboard); */
/* translate([0,0,0]) color("orange") 75plate01(ansiUS_7581keyboard); */
/* translate([0,0,0]) color("orange") 75plate01(ansiUS_7583keyboard); */
/* translate([0,0,0]) color("orange") 75plate02(ansiUS_7581keyboard); */
translate([0,0,0]) color("orange") 75plate02(ansiUS_7583keyboard);

/* color("Gainsboro") 75plate(isoDE_7583keyboard); */




/* simulate keycaps */
/* translate([(lkey/2)-2.5,(lkey/2)-3,caseHeight+4])
keySim(ansiUS_7581keyboard,0,h-lkey,tempHeigth); */

/* translate([(lkey/2)-2.5,(lkey/2)-3,caseHeight+4])
keySim(ansiUS_7583keyboard,0,h-lkey,tempHeigth); */

/* translate([(w-lkey*3),h-wallThickness+1-2*lkey,4.4]) controllerPlate(); */

module 75erKeyboard()
{
	rotate([10,0,0])
	union()
	{
		color("Gainsboro") 75plate(ansiUS_7583keyboard);
		translate([0,0,-3]) color("White") lid();
		color("Gainsboro") translate([40,105,-lidThickness]) riser();
		translate([40+angleBaseX/2,0,-lidThickness]) riserConnector();

		color("Gainsboro") translate([w-40-angleBaseX,105,-lidThickness]) riser();
		translate([w-40-angleBaseX/2,0,-lidThickness]) riserConnector();

		translate([(lkey/2)-2.5,(lkey/2)-3,caseHeight+3])
		keySim(ansiUS_7583keyboard,0,h-lkey,tempHeigth);
	}
}
/* 75erKeyboard(); */

module testPlate() {
	difference() {
		75plate(ansiUS_7583keyboard);
		translate([100, -60-caseRadius, 0]) cube([w,h+2*caseRadius,caseHeight]);
		translate([-68, -caseRadius, 0]) cube([w,h+2*caseRadius,caseHeight]);
		/* translate([caseRadius, 20, 0]) cube([w,h+2*caseRadius,caseHeight]); */
	}
	// body...
}

module testPlate01() {
	difference() {
		translate([0,0,0]) 75plate01(ansiUS_7583keyboard);
		/* #translate([100, -60-caseRadius, 0]) cube([w,h+2*caseRadius,caseHeight]); */
		translate([-68, -caseRadius, 0]) cube([w,h+2*caseRadius,caseHeight]);
	}
}

module testPlate02() {
	difference(ansiUS_7583keyboard) {
		translate([0,0,0]) 75plate02(ansiUS_7583keyboard);
		/* #translate([100, -60-caseRadius, 0]) cube([w,h+2*caseRadius,caseHeight]); */
		translate([-200, -caseRadius, 0]) cube([w,h+2*caseRadius,caseHeight]);
	}
}

module testPlate03() {
	difference() {
		translate([0,0,0]) 75plate(isoDE_7583keyboard);
		translate([100, -97-caseRadius, 0]) cube([w,h+2*caseRadius,caseHeight]);
		translate([100, 97-caseRadius, 0]) cube([w,h+2*caseRadius,caseHeight]);
		translate([-68, -caseRadius, 0]) cube([w,h+2*caseRadius,caseHeight]);
	}
}

module testPlateSpacebar() {
	difference() {
		75plate(ansiUS_7583keyboard);
		translate([-260, -caseRadius, 0]) cube([w,h+2*caseRadius,caseHeight]);
		translate([215, -caseRadius, 0]) cube([w,h+2*caseRadius,caseHeight]);
		translate([caseRadius, 20, 0]) cube([w,h+2*caseRadius,caseHeight]);
	}
	// body...
}

module testLid() {
	difference() {
		lidR();
		translate([-65, -caseRadius, 0]) cube([w,h+2*caseRadius,caseHeight]);
		translate([295, -caseRadius, 0]) cube([w,h+2*caseRadius,caseHeight]);
		translate([caseRadius, -43, 0]) cube([w,h+2*caseRadius,caseHeight]);
	}
	// body...
}

module testLidRMid() {
	difference() {
		lidR();
		translate([200, -caseRadius, 0]) cube([w,h+2*caseRadius,caseHeight]);
	}
}

module testLidLMid() {
	difference() {
		lidL();
		translate([-200, -caseRadius, 0]) cube([w,h+2*caseRadius,caseHeight]);
	}
}

module switchholeInv(){
	union(){
		translate([0,0,-extra/2])
		cube([holesize+switchHoleTolerance*2,holesize+switchHoleTolerance*2,plateThickness+extra]);
	}
}

module switchConnector(holes,startx,starty,zCase)
{
	difference()
	{
		union()
		{
			cube([w,h,1]);

			for (key = holes){
				/* echo (key[0][0],key[0][1],key[1]); */
				translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 1])
				translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
				switchholeInv();
			}
		}
		translate([-185,0,-2]) cube([w,h,10]);
		translate([185,0,-2]) cube([w,h,10]);
		translate([115,-95,-2]) cube([w,h,10]);
		translate([115,95,-2]) cube([w,h,10]);
	}
}
/* switchConnector(ansiUS_7583keyboard,0,h-lkey,tempHeigth); */

/* testLid(); */
/* testLidRMid(); */
/* testLidLMid(); */
/* testPlateSpacebar(); */
/* translate([0,0,3]) testPlate(); */
/* translate([0,0,3]) testPlate01(); */
/* translate([0,0,3]) testPlate02(); */
/* translate([0,0,3]) testPlate03(); */

/* u(u=1.75) sa_row(4) legend("Shift") key() ; */
