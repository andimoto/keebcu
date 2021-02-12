/* wrist.scad
Author: andimoto@posteo.de
----------------------------
for placing assambled parts and
single parts go to end of this file

set the form of the wrist rest in "wristForm" array
 */

$fn=50;

wristLength = 306;
edgeRadius = 1;

connectorRadius=3;
connectorLen=40;

wristForm=[
  [0,0],
  [80,0],
  [80,5],
  [78.2,8.2],
  [75,10],
  [40,16],
  [0,16]
];



module connector(rad,conLength)
{
  cylinder(r=rad, h=conLength, center=true);
}

module wristProfile(form)
{
  polygon(form);
}

module wrist(length=360)
{
  translate([edgeRadius,edgeRadius,edgeRadius])
  rotate([90,0,90])
  minkowski()
  {
    union()
    {
      linear_extrude(length-edgeRadius*2)
      wristProfile(wristForm);
    }
    /* rotate([0,90,0]) cylinder(r=edgeRadius, h=1, center=true); */
    sphere(r=edgeRadius);
  }
}

module wristRestLeft(length)
{
  difference() {
    wrist(length);
    translate([0,-1,0]) rotate([90,0,90]) linear_extrude(length/2)
    scale([1.1,1.2,1]) wristProfile(wristForm);
    translate([length/2,10,6]) rotate([0,90,0]) connector(connectorRadius+0.2,connectorLen);
    translate([length/2,40,6]) rotate([0,90,0]) connector(connectorRadius+0.2,connectorLen);
    translate([length/2,70,6]) rotate([0,90,0]) connector(connectorRadius+0.2,connectorLen);
  }
}

module wristRestRight(length=360)
{
  difference() {
    wrist(length);
    translate([length/2,-1,0]) rotate([90,0,90]) linear_extrude(length/2)
    scale([1.1,1.2,1]) wristProfile(wristForm);
    translate([length/2,10,6]) rotate([0,90,0]) connector(connectorRadius+0.2,connectorLen);
    translate([length/2,40,6]) rotate([0,90,0]) connector(connectorRadius+0.2,connectorLen);
    translate([length/2,70,6]) rotate([0,90,0]) connector(connectorRadius+0.2,connectorLen);
  }
}


translate([0,150+connectorLen,connectorLen/2]) connector(connectorRadius-0.0,connectorLen-3);
translate([0,150+connectorLen+10,connectorLen/2]) connector(connectorRadius-0.0,connectorLen-3);
translate([0,150+connectorLen+20,connectorLen/2]) connector(connectorRadius-0.0,connectorLen-3);
/* wristProfile(wristForm); */
/* wrist(wristLength); */
/* translate([0,100,0]) wristRestRight(wristLength); */
/* translate([20,100,0]) wristRestLeft(wristLength); */
