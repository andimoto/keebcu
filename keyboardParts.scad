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

function getExtraFRow(extraFRow=false) = (extraFRow==true) ? lkey*0.5 : 0 ;
function getSkirtY() = (skirtSelect==true) ? skirtY : 0 ;
function getSkirtX() = (skirtSelect==true) ? skirtX : 0 ;
function getHalf(yPosKey) = (yPosKey % 1);

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

	/* create extra objects to be cutout like isoEnter, etc. */
	extraCutoutHook();

	for (key = holes){
		/* echo (key[0][0],key[0][1],key[1]); */
		/* place switch holes */
		if(key[1] >= 1){
			half = getHalf(key[0][1]);// % 1;
			if(half == 0.5){
				/* all switchholes which have vertical sized keycaps like numpad-enter or numpad+ */
				translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
				translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
				switchhole();

				if(enableStabsOnHalfs == true)
				{
					/* directly add costarStabilizers to this switchhole */
					translate([19.3,-5,0])
					translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
					translate([(lkey*key[1]-holesize)/2+(holesize/2)-shortStabX/2,(lkey - holesize)/2+costarStabYdelta+0.5, 0])
					rotate([0,0,90]) costarStabilizer();

					translate([-4.7,20,0])
					translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
					translate([(lkey*key[1]+holesize)/2-(holesize/2)+shortStabX/2,(lkey - holesize)/2+costarStabYdelta-0.5, 0])
					rotate([0,0,90]) costarStabilizer();
				}
			}
			else
			{
				if((key[0][1]==0) && (fRowSeparator==true))
				{
					translate([startx+lkey*key[0][0], starty-lkey*(key[0][1])+getExtraFRow(fRowSeparator), zCase-extra])
					translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
					switchhole();
				}
				else
				{
					translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
					translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
					switchhole();
				}
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
		half = getHalf(key[0][1]);
		/* echo(half); */
		if(key[0][1]!=2.5 && half != 0.5){
			translate([0,lkey*key[0][1]-1+caseStabMov,innerCaseSpace])
			cube([w,1,caseHeight-plateThickness-innerCaseSpace]);
		}
	}

	for (key = holes){
		if((key[0][1]==0) && (fRowSeparator==true))
		{
			/* don't place case stabilizer on iso enter button */
			translate([startx+lkey*key[0][0]+lkey*key[1]-innerCaseRadius,starty-lkey*key[0][1],caseHeight-plateThickness-2])
			cube([1,lkey+getExtraFRow(fRowSeparator),2]);
		}

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
		color(switchColorTop) translate([0,10.5,0])
			rotate([90,0,0]) linear_extrude(7) polygon(switchSimArray);
		color(switchColorTop) translate([3.5,0,0])
			rotate([90,0,90]) linear_extrude(7) polygon(switchSimArray);

		color(switchColorBottom) translate([0,3.5,0])
			rotate([270,0,0]) linear_extrude(7)  polygon(switchSimArray);
		color(switchColorBottom) translate([3.5,14,0])
			rotate([90,180,90]) linear_extrude(7) polygon(switchSimArray);
	}
}


module keySim(holes)
{
	startx = 0;
	starty = caseDepth - lkey;
	zCase = tempHeigth;

	/* simulate extra objects which have different placement */
	extraKeySimHook();

	for (key = holes){
		/* switch simulation for F-Row
		   this actually sets a pragmatic mockup for a real switch into the hole!
			 so a switch will be simulated */
		if(key[0][1]==0 && fRowSeparator==true)
		{
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1]+getExtraFRow(fRowSeparator), zCase-extra])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, -14])
			switchSim();
		}
		else
		{
			translate([startx+lkey*key[0][0], starty-lkey*key[0][1], zCase-extra])
			translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, -14])
			switchSim();
		}


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
		else /* 1u keys */
		{
			/* keysim with F-Row separator only for 1u keys */
			if(key[0][1]==0 && fRowSeparator==true)
			{
				color(key[2])
				translate([startx+lkey*key[0][0], starty-lkey*key[0][1]+getExtraFRow(fRowSeparator), 0])
				translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
				1u() sa_row(key[0][1]) key();
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
				cube([cutLength+1+lkey,yCut+getExtraFRow(fRowSeparator)+getSkirtY(),caseHeight+extra*2]);
			}
			/* last row */
			else if( key[0][1]==height-1)
			{
				yCut = lkey+wallThickness/2;
				translate([-1,starty-lkey*key[0][1]-wallThickness/2-getSkirtY(),0])
				cube([cutLength+1+lkey,yCut+getSkirtY(),caseHeight+extra*2]);
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
				translate([cutLength-1,starty-lkey*key[0][1]-wallThickness/2-getSkirtY(),0])
		 	  cube([1+startx+lkey*temp,lkey+wallThickness/2+getSkirtY(),caseHeight+extra*2]);
			}

			if(skirtSelect==true)
			{
				translate([-skirtX-1,-skirtY-1,0])
				cube([skirtX,caseDepth+2*skirtY+getExtraFRow(fRowSeparator)+2,caseHeight+extra*2]); /*dont know why +2 at y? */
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
	h1=caseHeight-plateThickness-1,h2=caseHeight-1,rotation=screwSpacerRotation)
{
	/* screw head */
	rotate([0,0,rotation]) scale([1.5,1,1]) cylinder(r=r1, h=h1);
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
	translate([-3,1,-2]) cube([usbCutX+6,usbCutY+getSkirtY(),usbCutZ+5]);

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
	/* cylinder(r=0.1,h=5); */
}

/* polygon of holding clamps for controller pcb.
 * change this as needed. but this should be ok...
 */
pcbClamps = [
[0,0],
[0,1.5],
[6,1.5],
[6.5,1.5],
[5,0]
];

module pcbClamp()
{
	translate([-5.5,0,0]) cube([5,pcbLength,pcbHeight]);
	translate([-5.5,pcbLength,pcbHeight-1]) rotate([90,0,0]) linear_extrude(pcbLength) polygon(pcbClamps);

	translate([pcbWidth+0.5,0,0]) cube([5,pcbLength,pcbHeight]);
	translate([pcbWidth+5.5,pcbLength,pcbHeight-1]) mirror([1,0,0])  rotate([90,0,0]) linear_extrude(pcbLength) polygon(pcbClamps);

	translate([0,-5,0])cube([pcbWidth,5,pcbHeight]);
	translate([0,-5,pcbHeight-1]) rotate([90,0,90]) linear_extrude(pcbWidth) polygon(pcbClamps);

	/* this marks the root point of the part.
	 * uncomment this for debugging */
	/* cylinder(r=0.1,h=5); */
}


module riser(polyRiser)
{
	/* translate([0,angleBaseY,0]) */
	/* mirror([0,1,0]) */
	union()
	{
		minkowski() {
			difference() {
				translate([0, angleBaseY, 0])
				rotate([90,180,90])
				linear_extrude(height=angleBaseX)
				polygon(polyRiser);

				/* cut of the notch */
				translate([-angleBaseRad,-angleBaseY-100,-10]) cube([angleBaseX+angleBaseRad*2,100,10]);
			}
			cylinder(r=angleBaseRad, h=0.0000000001, center=true);
		}
	}
}

module riserConnector(rCon=5,conHeight=3)
{
	union()
	{
		/* Debug Root */
		/* cylinder(r=0.1, h=10); */
		translate([0,0,0])	cylinder(r=rCon, h=conHeight);
		translate([0,rCon*2+riserConnectorY1,0]) cylinder(r=rCon, h=conHeight); //the 20mm is from the notch cut off of the riser
	}
}

module keyboardRiser()
{
	translate([0,0,0])
	/* mirror([0,1,0]) */
	union()
	{
		/* cylinder(r=0.1, h=100); */  //debug needle
		riser(riserPoints);
		translate([angleBaseX/2,(angleBaseY-riserConnectorY1)/2-riserConnectorRadius,0]) riserConnector(rCon=riserConnectorRadius-0.02, conHeight=lidThickness);
	}
}


module case(){
	difference() {
		union()
		{
			minkowski() {
				cube([caseWidth,caseDepth+getExtraFRow(fRowSeparator),caseHeight]);
				cylinder(r=innerCaseRadius, h=0.0000000001, center=true);
	  	}
			if(skirtSelect == true)
			{
				//add some skirt to the case if selected
				translate([-1-skirtX+caseRadius,-1-skirtY+caseRadius,0])
				minkowski() {
					cube([caseWidth+(1+skirtX-caseRadius)*2,caseDepth+getExtraFRow(fRowSeparator)+(1+skirtY-caseRadius)*2,caseHeight]);
					cylinder(r=caseRadius, h=0.0000000001, center=true);
			  }
			}
		}
		translate([wallThickness,wallThickness,-extra])
		minkowski() {
			cube([caseWidth-(wallThickness*2),caseDepth-(wallThickness*2)+getExtraFRow(fRowSeparator),tempHeigth]);
			cylinder(r=innerCaseRadius, h=0.0000000001, center=true);
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
				translate([caseWidth-pcbWidth/2-usbCutX/2-lkey*2+0.5+pcbShift,
					caseDepth-2+getExtraFRow(fRowSeparator),1])
					usbCutout();
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


module lid()
{
	difference()
	{
		union()
		{
			minkowski() {
				cube([caseWidth,caseDepth+getExtraFRow(fRowSeparator),lidThickness]);
				cylinder(r=innerCaseRadius, h=0.0000000001, center=true);
			}

			if(skirtSelect == true)
			{
				translate([(-1-skirtX+caseRadius),(-1-skirtY+caseRadius),0])
				minkowski() {
					cube([caseWidth+(1+skirtX-caseRadius)*2,
						caseDepth+getExtraFRow(fRowSeparator)+(1+skirtY-caseRadius)*2,
						lidThickness]);
					cylinder(r=caseRadius, h=0.0000000001, center=true);
				}
			}

			translate([wallThickness+extra/4,wallThickness+extra/4,innerExtraLid])
			minkowski() {
				cube([caseWidth-(wallThickness*2)-extra/2,
					caseDepth-(wallThickness*2)-extra/2+getExtraFRow(fRowSeparator),
					lidThickness]);
				cylinder(r=innerCaseRadius, h=0.0000000001, center=true);
			}
		}

		/* subtract screw holes */
		lidScrewHolesLoop(c1=1.8);
		translate([0,0,-1]) lidScrewHolesLoop(c1=2.8);

		if(addRisers == true)
		{
			/* subtract cutouts for risers */
			yShiftConnector = -riserConnectorRadius+((caseDepth+getExtraFRow(fRowSeparator)-riserConnectorY1)/2);

			translate([40+angleBaseX/2+xRiserL,yShiftConnector+yRiserAll,0])
				riserConnector(riserConnectorRadius,conHeight=lidThickness+1);
			translate([caseWidth-40-angleBaseX/2+xRiserR,yShiftConnector+yRiserAll,0])
				riserConnector(riserConnectorRadius,conHeight=lidThickness+1);
		}

		/* subtract usb cutout and pcb cutout */
	
		translate([caseWidth-pcbWidth-lkey*2+pcbShift,
				caseDepth-pcbLength-innerCaseRadius*2-0.25+getExtraFRow(fRowSeparator),
				lidThickness])
				pcbCutout();
		translate([caseWidth-pcbWidth/2-usbCutX/2-lkey*2+0.5+pcbShift,
				caseDepth-2+getExtraFRow(fRowSeparator),
				lidThickness])
				usbCutout();
	}

	/* pcb holder */
	translate([caseWidth-pcbWidth-lkey*2+0.5+pcbShift,
		caseDepth-pcbLength-innerCaseRadius*2-0.3+getExtraFRow(fRowSeparator),
		lidThickness+1])
	pcbClamp();
}

module lidR()
{
	difference() {
		lid();
		union()
		{
			if(skirtSelect == true)
			{
				translate([0-skirtX-caseRadius/2,-skirtY-caseRadius-extra,-extra])
				cube([(caseWidth+(skirtX*2))/2,caseDepth+getExtraFRow(fRowSeparator)+(skirtY+caseRadius)*2,caseHeight]);
			}else{
				translate([-innerCaseRadius-extra,-innerCaseRadius-extra,-extra])
				cube([(caseWidth+2*innerCaseRadius)/2+extra,caseDepth+2*innerCaseRadius+extra+getExtraFRow(fRowSeparator),caseHeight]);
			}
		}
	}
}

module lidL()
{
	difference() {
		lid();
		union()
		{
			if(skirtSelect == true)
			{
		 		translate([0-skirtX-caseRadius/2+(caseWidth+skirtX*2)/2,-skirtY-caseRadius-extra,-extra])
				cube([(caseWidth+skirtX*2)/2+caseRadius,caseDepth+getExtraFRow(fRowSeparator)+(skirtY+caseRadius)*2,caseHeight]);
			}else{
				translate([(caseWidth+2*innerCaseRadius)/2-extra,-innerCaseRadius-extra,-extra])
				cube([(caseWidth+2*innerCaseRadius)/2+extra,caseDepth+2*innerCaseRadius+extra+getExtraFRow(fRowSeparator),caseHeight]);
			}
		}
	}
}


/* ################################################## */
/* ########## complete keyboard simulation ########## */
/* ################################################## */
module KeyboardSim(keyboardLayout,DoKeycapSimulation, xRotate)
{
	rotate([xRotate,0,0])
	union()
	{
		color(colorCase) mainCase(keyboardLayout);
		translate([0,0,-3]) color(colorLid) lid();

		if(addRisers == true)
		{
			yShiftConnector = ((caseDepth+getExtraFRow(fRowSeparator)-angleBaseY)/2);
			color(colorRiserL)
			translate([40+xRiserL,yShiftConnector+yRiserAll,-lidThickness])
				keyboardRiser();
			color(colorRiserR)
			translate([caseWidth-angleBaseX-40+xRiserR,yShiftConnector+yRiserAll,-lidThickness])
				keyboardRiser();
		}

		if(DoKeycapSimulation == true)
		{
			translate([(lkey/2)-2.5,(lkey/2)-3,caseHeight+3])
			keySim(keyboardLayout);
		}
	}
}
