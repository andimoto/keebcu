/* keebCase.scad
Author: andimoto@posteo.de
----------------------------
for placing assambled parts and
single parts go to end of this file
 */

$fn=50;

keebLen = 330;
keebThickness = 60;
keebHeight = 117;
wallThickness = 2;
sideThickness = 10;
edgeRadius = 2;

magnetRadius = 5/2;
magnetThickness = 1;

module halfCase(slidePin = false)
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
    cylinder(r=magnetRadius, h=magnetThickness, center=true);
    translate([sideThickness/2-edgeRadius,(keebThickness+edgeRadius*2)-keebThickness/4,keebLen/2])
    cylinder(r=magnetRadius, h=magnetThickness, center=true);

    translate([keebHeight+sideThickness*2-sideThickness/2+edgeRadius, keebThickness/4-edgeRadius,keebLen/2])
    cylinder(r=magnetRadius, h=magnetThickness, center=true);
    translate([keebHeight+sideThickness*2-sideThickness/2+edgeRadius,(keebThickness+edgeRadius*2)-keebThickness/4,keebLen/2])
    cylinder(r=magnetRadius, h=magnetThickness, center=true);

    if(slidePin == false)
    {
      translate([sideThickness/2-edgeRadius,(keebThickness+edgeRadius*2)/2,keebLen/2-4])
      cylinder(r1=magnetRadius,r2=magnetRadius*1.5, h=5, center=false);

      translate([keebHeight+sideThickness*2-sideThickness/2+edgeRadius,(keebThickness+edgeRadius*2)/2,keebLen/2-4])
      cylinder(r1=magnetRadius,r2=magnetRadius*1.5, h=5, center=false);
    }

  }

  if(slidePin == true)
  {
    translate([sideThickness/2-edgeRadius,(keebThickness+edgeRadius*2)/2,keebLen/2])
    cylinder(r1=magnetRadius*1.5,r2=magnetRadius, h=5, center=false);

    translate([keebHeight+sideThickness*2-sideThickness/2+edgeRadius,(keebThickness+edgeRadius*2)/2,keebLen/2])
    cylinder(r1=(magnetRadius*1.5)-0.02,r2=magnetRadius-0.02, h=5, center=false);
  }
}

/* translate([2,2,0]) halfCase(true); */


module sphereCut()
{
  translate([0,0,10])
  difference()
  {
    sphere(r=11);
    translate([0,13,0]) cube([22, 22, 22],center = true);
    translate([0,0,5]) cube([22, 22, 22],center = true);
  }
}

/* sphereCut(); */

module lock(radius=10, height=4)
{
  difference() {
    /* lock part */
    minkowski()
    {
      difference() {
        hull()
        {
          cylinder(r=radius,h=height);
          translate([0,radius*2,0]) cylinder(r=radius,h=height);
        }
        translate([radius*2-radius/2,radius,0]) cylinder(r=radius,h=height);
        translate([-radius*2+radius/2,radius,0]) cylinder(r=radius,h=height);
      }
      cylinder(r=edgeRadius,h=0.01, center=true);
    }

    /* cutout */
    translate([0,0,2]) sphereCut();
    translate([0,radius*2,2]) rotate([0,0,180]) sphereCut();

    translate([0,-radius/1.5,0]) cylinder(r=2.5, h=2, center=true);
    translate([0,radius*2+radius/1.5,0]) cylinder(r=2.5, h=2, center=true);
    /* debug cut */
    /* cube([radius*2,50,5]); */
  }
}


lock();
