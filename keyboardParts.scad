/* keyboardParts.scad
Author: andimoto@posteo.de
----------------------------
for placing assambled parts and
single parts go to end of this file

this file includes KeyV2 files. see https://github.com/rsheldiii/KeyV2
if you don't want this file to be included, just don't clone this library or
remove the call for placing all keycaps on the keyboard.
*/

include <../KeyV2/includes.scad>

/* variable for calculation */
cutLength = 0;

tempHeigth=caseHeight-plateThickness+extra;


module switchhole(){
	union(){
		translate([0,0,-extra/2])
		cube([holesize+switchHoleTolerance,holesize+switchHoleTolerance,plateThickness+extra]);
	}
}

module costarStabilizer(){
	union(){
		translate([-stabX/2,0,-0.8])
		cube([stabX,holesize+1,plateThickness/*+extra*/]);
		translate([-stabX/2,0.25,plateThickness-0.8])
		cube([stabX,holesize+0.5,1+extra]);
		/* debug point */
		/* #cylinder(r=0.1,h=10); */
	}
}
/* costarStabilizer(); */

costarStabYdelta = -0.5;
module holematrix(holes,startx,starty,zCase){
	for (key = holes){
		/* echo (key[0][0],key[0][1],key[1]); */

		/* place switch holes */
		if(key[1] >= 1){
			/* check for iso Enter key; should be the last row minus 3.5
			   iso enter key belongs to the 2nd row at layout with F-Keys, or 1st
				 row without F Keys */
			if(key[0][1] == height-3.5)
			{
				/* iso enter needs a move of about 2mm into right direction */
				translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
				translate([(lkey*key[1]-holesize)/2 + 3,(lkey - holesize)/2, 0])
				switchhole();

				/* iso enter and other stabilizers than spacebar */
				/* needed to add some extra mm to the costarStabilizer cutouts
				   but different extra for each stabilizer */
				translate([19.7,-5,0])
				translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
				translate([(lkey*key[1]-holesize)/2+(holesize/2)-shortStabX/2 + 2.6,(lkey - holesize)/2+costarStabYdelta, 0])
				rotate([0,0,90]) costarStabilizer();

				translate([-4.7,20,0])
				translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
				translate([(lkey*key[1]+holesize)/2-(holesize/2)+shortStabX/2 + 3,(lkey - holesize)/2+costarStabYdelta, 0])
				rotate([0,0,90]) costarStabilizer();

			}
			else
			{
				translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
				translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
				switchhole();
			}
		}
		/* place switch holes - end */

		/* debugging - remove comment to show root point of holesize */
		/* translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
		translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
		#cylinder(r=0.1,h=10); */

		/* place stabilizers */
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

	}
}




module caseStabilizer(w,h,holes,startx,starty,zCase)
{
	for (key = holes){
		/* don't place case stabilizer on iso enter button */
		if(key[0][1]!=2.5){
			translate([0,lkey*key[0][1]-caseRadius,innerCaseSpace])
			cube([w,1,caseHeight-plateThickness-innerCaseSpace]);
		}
	}

	for (key = holes){
		if(key[0][1]!=2.5){
			/* don't place case stabilizer on iso enter button */
			translate([startx+lkey*key[0][0]+lkey*key[1]-1,starty-lkey*key[0][1],caseHeight-plateThickness-2])
			cube([1,lkey,2]);
		}
		/*put some extra stabilizer profiles to spacebar*/
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


module keySim(holes)
{
	startx = 0;
	starty = caseDepth - lkey;
	zCase = tempHeigth;
	for (key = holes){
		translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
		translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, -14])
		color("black") switchSim();

		if (key[1]==6.25){
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			6_25u() sa_row(key[0][1]) key();
		}

		else if (key[1]==2.75){
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			2_75u() sa_row(key[0][1]) key();
		}
		else if(key[0][1]==2.5)
		{
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2+2,(lkey - holesize)/2, 0])
			sa_row(key[0][1]) iso_enter() key(true);
		}
		else if (key[1]==2.25){
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			2_25u() sa_row(key[0][1]) key();
		}
		else if (key[1]==2){
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			2u() sa_row(key[0][1]) key();
		}
		else if (key[1]==1.75){
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			u(u=1.75) sa_row(key[0][1]) key();
		}
		else if (key[1]==1.5){
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			1_5u() sa_row(key[0][1]) key();
		}
		else if (key[1]==1.25){
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			1_25u() sa_row(key[0][1]) key();
		}
		else
		{
			color(key[2])
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			1u() sa_row(key[0][1]) key();
		}
	}
}


module calcRight(holes,startx,starty,zCase){
	for (key = holes){
		/* if(key[1] >= 1){
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
			switchhole();
		} */

		cutLength = cutLength + lkey*key[0][0];
		if(cutLength <= cutAfterUnits*lkey)
		{
			temp=key[1];
			/* row 0 */
			if(key[0][1]==0)
			{
				yCut = lkey+wallThickness/2;
				translate([-1,starty-lkey*key[0][1],0])
				cube([cutLength+1+lkey,yCut,caseHeight+extra*2]);
			}
			/* last row */
			else if( key[0][1]==height-1)
			{
				yCut = lkey+wallThickness/2;
				translate([-1,starty-lkey*key[0][1]-wallThickness/2,0])
				cube([cutLength+1+lkey,yCut,caseHeight+extra*2]);
			}
			/* all middle rows between 0 last row */
			else
			{
				yCut = lkey;
				translate([-1,starty-lkey*key[0][1],0])
				cube([cutLength+1+lkey,yCut,caseHeight+extra*2]);
			}

			/* calculate spacebar cutout separatelly.
			 * this should be redesigned
			 */
			if(temp>6){
				temp = spacebarCut;
				translate([cutLength-1,starty-lkey*key[0][1]-wallThickness/2,0])
		 	  cube([1+startx+lkey*temp,lkey+wallThickness/2,caseHeight+extra*2]);
			}

		} /*if(cutLength)*/
	} /*for*/
}


module screwHole(r2=1.5,
	h1=caseHeight-plateThickness-1,h2=caseHeight-1)
{
	/* screw hole */
	cylinder(r=r2, h=h2);
}


module caseScrewHolesLoop(r20=1.5)
{
	for(hole = screwHoleArray)
	{
		translate([hole[0],hole[1],1])
		screwHole(r2=r20);
	}
}

module screwSpacer(r1=2.5,
	h1=caseHeight-plateThickness-1,h2=caseHeight-1)
{
	/* screw head */
	scale([1.5,1,1]) cylinder(r=r1, h=h1);
}

module caseScrewSpacerLoop(r10=2.5)
{
	for(hole = screwHoleArray)
	{
		translate([hole[0],hole[1],1])
		screwSpacer(r1=r10);
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


module usbCutout()
{
	translate([0,-0.1,0]) cube([usbCutX,usbCutY,usbCutZ]);
	translate([-1.5,1,-2]) cube([usbCutX+3,usbCutY,usbCutZ+4]);

	/* this marks the root point of the part.
	 * uncomment this for debugging */
	/* cylinder(r=0.1,h=5); */
}


module pcbCutout()
{
	/* add 1mm clearance to pcb size */
	cube([pcbWidth+1,pcbLength,pcbHeight]);

	/* this marks the root point of the part.
	 * uncomment this for debugging */
	cylinder(r=0.1,h=5);
}

/* polygon of holding clamps for controller pcb.
 * change this as needed. but this should be ok...
 */
pcbClamps = [
[0,0],
[0,2],
[6,2],
[6,1],
[5,0]
];

module pcbClamp()
{
	translate([-5.5,pcbLength,0]) rotate([90,0,0]) linear_extrude(pcbLength) polygon(pcbClamps);
	translate([pcbWidth+5.5,pcbLength,0]) mirror([1,0,0])  rotate([90,0,0]) linear_extrude(pcbLength) polygon(pcbClamps);
	translate([0,-5,0]) rotate([90,0,90]) linear_extrude(pcbWidth) polygon(pcbClamps);

	/* this marks the root point of the part.
	 * uncomment this for debugging */
	/* cylinder(r=0.1,h=5); */
}


module riser()
{
	/* translate([0,angleBaseY,0]) */
	mirror([0,1,0])
	union()
	{
		minkowski() {
			difference() {
				rotate([90,180,90]) linear_extrude(height=angleBaseX) polygon(riserPoints);

				/* cut of the notch */
				translate([-1,-angleBaseY,-10]) cube([angleBaseX+angleBaseRad*2,20,10]);
			}
			cylinder(r=angleBaseRad, h=0.0000000001, center=true);
		}
	}
}

module riserConnector(rCon=5,conHeight=3)
{
	union()
	{
		/* #cylinder(r=0.1, h=10); */
		translate([0,20,conHeight]) cylinder(r=rCon, h=conHeight);
		translate([0,angleBaseY-40,conHeight]) cylinder(r=rCon, h=conHeight); //the 20mm is from the notch cut off of the riser
	}
}

module keyboardRiser()
{
	translate([0,angleBaseY-20,0])
	mirror([0,1,0])
	union()
	{
		/* cylinder(r=0.1, h=100); */  //debug needle
		riser();
		translate([angleBaseX/2,0,-lidThickness]) riserConnector(rCon=4.98, conHeight=lidThickness);
	}
}


module lid()
{
	difference()
	{
		union()
		{
			minkowski() {
				cube([caseWidth,caseDepth,lidThickness]);
				cylinder(r=1, h=0.0000000001, center=true);
			}

			translate([wallThickness+extra/4,wallThickness+extra/4,innerExtraLid]) minkowski() {
				cube([caseWidth-(wallThickness*2)-extra/2,caseDepth-(wallThickness*2)-extra/2,lidThickness]);
				cylinder(r=1, h=0.0000000001, center=true);
			}
		}

		/* subtract screw holes */
		lidScrewHolesLoop(c1=1.8);
		translate([0,0,-1]) lidScrewHolesLoop(c1=2.8);

		if(addRisers == true)
		{
			/* subtract cutouts for risers */
			translate([40+angleBaseX/2+xRiserL,(caseDepth/2)-(angleBaseY-20)/2,-(lidThickness+1)])
				riserConnector(conHeight=lidThickness+1);
			translate([caseWidth-40-angleBaseX/2+xRiserR,(caseDepth/2)-(angleBaseY-20)/2,-(lidThickness+1)])
				riserConnector(conHeight=lidThickness+1);
		}

		/* subtract usb cutout and pcb cutout */
		/* translate([(caseWidth-lkey*3)-0.5,caseDepth-wallThickness+5-2*lkey,lidThickness]) pcbCutout();
		translate([(caseWidth+5-lkey*3),caseDepth-2,lidThickness]) usbCutout(); */
		translate([caseWidth-pcbWidth-lkey*2,caseDepth-pcbLength-caseRadius*2,lidThickness])
				pcbCutout();
		translate([caseWidth-pcbWidth/2-usbCutX/2-lkey*2+0.5,caseDepth-2,lidThickness])
				usbCutout();
	}

	/* pcb holder */
	translate([caseWidth-pcbWidth-lkey*2+0.5,
		caseDepth-pcbLength-caseRadius*2,
		lidThickness+1])
	pcbClamp();
}



module case(){
	difference() {
		minkowski() {
			cube([caseWidth,caseDepth,caseHeight]);
			cylinder(r=caseRadius, h=0.0000000001, center=true);
	  }
		translate([wallThickness,wallThickness,-extra])
		minkowski() {
			cube([caseWidth-(wallThickness*2),caseDepth-(wallThickness*2),tempHeigth]);
			cylinder(r=caseRadius, h=0.0000000001, center=true);
		}
	}
}


module mainCase(keyboardLayout){
	difference()
	{
		union()
		{
			difference(){
				case();
				holematrix(keyboardLayout,0,caseDepth-lkey,tempHeigth);
				translate([caseWidth-pcbWidth/2-usbCutX/2-lkey*2+0.5,caseDepth-2,1]) usbCutout();
			}
			caseStabilizer(caseWidth,caseDepth,keyboardLayout,0,caseDepth-lkey,tempHeigth);
			/* caseScrewHolesLoop(r10=2.5,r20=1.45); */
			caseScrewSpacerLoop(r10=2.5);
		}
		translate([0,0,-plateThickness]) caseScrewHolesLoop(r20=1.45);
	}
}


module mainCaseRight(keyboardLayout)
{
	difference() {
		mainCase(keyboardLayout);
		calcRight(keyboardLayout,0,caseDepth-lkey,tempHeigth);
	}
}

module mainCaseLeft(keyboardLayout)
{
	difference() {
		mainCase(keyboardLayout);
		mainCaseRight(keyboardLayout);
		/* avoid artefacts; after rendering there openSCAD
		   leaves some artefacts on the side */
		translate([lkey*cutAfterUnits+50,0,0])
		cube([(caseWidth+2*caseRadius)/2+extra,caseDepth+2*caseRadius+extra,caseHeight]);
	}
}

module lidR()
{
	difference() {
		lid();
		translate([-caseRadius-extra,-caseRadius-extra,-extra])
		cube([(caseWidth+2*caseRadius)/2+extra,caseDepth+2*caseRadius+extra,caseHeight]);
	}
}

module lidL()
{
	difference() {
		lid();
		translate([(caseWidth+2*caseRadius)/2-extra,-caseRadius-extra,-extra])
		cube([(caseWidth+2*caseRadius)/2+extra,caseDepth+2*caseRadius+extra,caseHeight]);
	}
}


/* ################################################## */
/* ########## complete keyboard simulation ########## */
/* ################################################## */
module KeyboardSim(keyboardLayout,DoKeycapSimulation)
{
	rotate([9,0,0])
	union()
	{
		color(colorCase) mainCase(keyboardLayout);
		translate([0,0,-3]) color(colorLid) lid();

		if(addRisers == true)
		{
			color(colorRiserL)
			translate([40+xRiserL,(caseDepth/2)-(angleBaseY-20)/2,-lidThickness])
				keyboardRiser();
			color(colorRiserR)
			translate([caseWidth-angleBaseX-40+xRiserR,(caseDepth/2)-(angleBaseY-20)/2,-lidThickness])
				keyboardRiser();
		}

		if(DoKeycapSimulation == true)
		{
			translate([(lkey/2)-2.5,(lkey/2)-3,caseHeight+3])
			keySim(keyboardLayout);
		}
	}
}
