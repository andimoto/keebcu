/* keebCase.scad
Author: andimoto@posteo.de
----------------------------
for placing assambled parts and
single parts go to end of this file
 */

$fn=70;

keebLen = 330;
keebThickness = 60;
keebHeight = 117;
wallThickness = 3;
sideThickness = 10;
edgeRadius = 2;

magnetRadius = 5/2;
magnetRadiusTolerance=0.025;
magnetThickness = 1;

lockRadius = 10;
lockThickness = 6;

module sphereCut()
{
  translate([0,0,10])
  difference()
  {
    sphere(r=11);
    translate([0,13,0]) cube([22, 22, 22],center = true);
    translate([0,0,5.1]) cube([22, 22, 22],center = true);
  }
}

module lock(radius=lockRadius, height=lockThickness, negativ=false)
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
      cylinder(r=edgeRadius,h=0.0000001, center=true);
    }


    if(negativ == false)
    {
      /* cutout for fingers */
      translate([0,0, 2.4]) sphereCut();
      translate([0,radius*2, 2.4]) rotate([0,0,180]) sphereCut();

      /* magnet holes */
      translate([0,-radius/1.5,0]) cylinder(r=magnetRadius+magnetRadiusTolerance, h=magnetThickness+0.7, center=false);
      translate([0,radius*2+radius/1.5,0]) cylinder(r=magnetRadius+magnetRadiusTolerance, h=magnetThickness+0.7, center=false);
    }

    /* debug cut */
    /* cube([radius*2,50,5]); */
  }
  if(negativ == true)
  {
    /* magnet holes */
    translate([0,-radius/1.5,-magnetThickness-0.7]) cylinder(r=magnetRadius+magnetRadiusTolerance, h=magnetThickness+0.7, center=false);
    translate([0,radius*2+radius/1.5,-magnetThickness-0.7]) cylinder(r=magnetRadius+magnetRadiusTolerance, h=magnetThickness+0.7, center=false);
  }
}

lock(negativ=false);


module halfCase(locks=true, magnets=true)
{
  difference() {
    minkowski()
    {
      cube([keebHeight+sideThickness*2,
          keebThickness+wallThickness*2,
          keebLen/2+wallThickness]);
      cylinder(r=edgeRadius, center=true);
    }

    translate([sideThickness,wallThickness,wallThickness])
    minkowski()
    {
      cube([keebHeight,
          keebThickness,
          keebLen/2]);
      cylinder(r=edgeRadius, center=true);
    }


    if(magnets == true)
    {
      /* magnets */
      translate([sideThickness/2-edgeRadius, keebThickness/6,keebLen/2+wallThickness])
      cylinder(r=magnetRadius, h=magnetThickness, center=true);
      translate([sideThickness/2-edgeRadius,(keebThickness+2*wallThickness)-keebThickness/6,keebLen/2+wallThickness])
      cylinder(r=magnetRadius, h=magnetThickness, center=true);

      translate([keebHeight+sideThickness*2-sideThickness/2+edgeRadius, keebThickness/6,keebLen/2+wallThickness])
      cylinder(r=magnetRadius, h=magnetThickness, center=true);
      translate([keebHeight+sideThickness*2-sideThickness/2+edgeRadius,(keebThickness+2*wallThickness)-keebThickness/6,keebLen/2+wallThickness])
      cylinder(r=magnetRadius, h=magnetThickness, center=true);
    }

    if(locks == true)
    {
      color("yellow") translate([lockThickness-wallThickness+1,keebThickness/2+wallThickness,(keebLen/2+wallThickness)-lockRadius+0.5])
      rotate([90,0,0]) rotate([0,-90,0]) scale([1.02,1.02,1]) lock(negativ=true);

      color("yellow") translate([keebHeight+sideThickness+lockThickness,keebThickness/2+wallThickness,(keebLen/2+wallThickness)-lockRadius+0.5])
      rotate([90,0,0]) rotate([0,90,0]) scale([1.02,1.02,1]) lock(negativ=true);
    }
  }
}

/* ################ BUILD_LINE ################# */
/* ############################################# */
/* ########## Place keyboard case ############## */
/* ############################################# */

/* color("yellow") translate([2,2,0]) halfCase(locks=true,magnets=true); */
/* color("yellow") translate([2,2,keebLen+wallThickness*2+1+0.0]) mirror([0,0,1]) halfCase(locks=true,magnets=true); */


/* case locks */
/* color("green") translate([lockThickness-0.1,(keebThickness/2+wallThickness*2)-1,(keebLen/2)-lockRadius+3.5])
rotate([90,0,0]) rotate([0,-90,0]) lock(negativ=false); */

/* color("black") translate([(keebHeight+sideThickness*2)-lockThickness/3,(keebThickness/2+wallThickness*2)-1,(keebLen/2)-lockRadius+3.5])
rotate([90,0,0]) rotate([0,90,0]) lock(negativ=false); */



/*########### DEBUG ###########*/

/* test print */
/* difference()
{
  translate([2,2,1]) halfCase(locks=true,magnets=true);
  cube([keebHeight+10,keebThickness+10,keebLen/2+wallThickness*2]);
} */
