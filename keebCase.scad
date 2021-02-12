/* keebCase.scad
Author: andimoto@posteo.de
----------------------------
for placing assambled parts and
single parts go to end of this file
 */

$fn=50;

keebLen = 310;
keebThickness = 35;
keebHeight = 120;
wallThickness = 2;
sideThickness = 10;
edgeRadius = 2;


module halfCase()
{
  difference() {
    minkowski()
    {
      cube([keebHeight+sideThickness*2,
          keebThickness+wallThickness*2,
          keebLen/2]);
      cylinder(r=edgeRadius, center=true);
    }
    translate([sideThickness,wallThickness,wallThickness])
    minkowski()
    {
      cube([keebHeight,
          keebThickness,
          keebLen/2-wallThickness]);
      cylinder(r=edgeRadius, center=true);
    }

    translate([sideThickness/2-edgeRadius, keebThickness/4-edgeRadius,keebLen/2])
    cylinder(r=5/2, h=1, center=true);
    translate([sideThickness/2-edgeRadius,(keebThickness+edgeRadius*2)-keebThickness/4,keebLen/2])
    cylinder(r=5/2, h=1, center=true);

    translate([keebHeight+sideThickness*2-sideThickness/2+edgeRadius, keebThickness/4-edgeRadius,keebLen/2])
    cylinder(r=5/2, h=1, center=true);
    translate([keebHeight+sideThickness*2-sideThickness/2+edgeRadius,(keebThickness+edgeRadius*2)-keebThickness/4,keebLen/2])
    cylinder(r=5/2, h=1, center=true);
  }
}

translate([2,2,0]) halfCase();
