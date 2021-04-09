/* keebCase.scad
Author: andimoto@posteo.de
----------------------------
for placing assambled parts and
single parts go to end of this file
 */

$fn=70;

keebLen = 290;
keebThickness = 65;
keebHeight = 100;
wallThickness = 3;
sideThickness = 10;
edgeRadius = 2;
yMoveMagnet = 5; /* move magnet cutout in y direction */

magnetRadius = 5/2;
magnetRadiusTolerance=0.025;
magnetThickness = 1;

lockEdgeRadius = 2;
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
      cylinder(r=lockEdgeRadius,h=0.0000001, center=true);
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

/* DEBUG */
  /* translate([edgeRadius,edgeRadius,0])
translate([-edgeRadius+lockThickness,
  keebThickness/2+wallThickness,
  (keebLen/2+wallThickness)-lockRadius+0.5])
rotate([90,0,0]) rotate([0,-90,0]) lock(negativ=true); */


module halfCase(locks=true, magnets=true)
{
  /* move piece by edgeRadius to align it at zero */
  translate([edgeRadius,edgeRadius,0])
  difference() {
    /* complete case */
    minkowski()
    {
      cube([(keebHeight+sideThickness*2)-edgeRadius*2,
          (keebThickness+wallThickness*2)-edgeRadius*2,
          (keebLen/2)+wallThickness]);
      cylinder(r=edgeRadius, h=0.0000001, center=false);
    }

    /* case cutout */
    translate([sideThickness,wallThickness,wallThickness])
    minkowski()
    {
      cube([keebHeight-edgeRadius*2,
          keebThickness-edgeRadius*2,
          keebLen/2]);
      cylinder(r=edgeRadius, h=0.0000001, center=false);
    }

    if(magnets == true)
    {
      /* magnets */
      translate([-edgeRadius+sideThickness/2,
        -edgeRadius+wallThickness+magnetRadius+yMoveMagnet,
        keebLen/2+wallThickness-magnetThickness])
      cylinder(r=magnetRadius, h=magnetThickness, center=false);
      translate([-edgeRadius+sideThickness/2,
        -edgeRadius+keebThickness-yMoveMagnet,
        keebLen/2+wallThickness-magnetThickness])
      cylinder(r=magnetRadius, h=magnetThickness, center=false);

      translate([-edgeRadius+keebHeight+sideThickness+sideThickness/2,
        -edgeRadius+wallThickness+magnetRadius+yMoveMagnet,
        keebLen/2+wallThickness-magnetThickness])
      cylinder(r=magnetRadius, h=magnetThickness, center=false);
      translate([-edgeRadius+keebHeight+sideThickness+sideThickness/2,
        -edgeRadius+keebThickness-yMoveMagnet,
        keebLen/2+wallThickness-magnetThickness])
      cylinder(r=magnetRadius, h=magnetThickness, center=false);
    }

    if(locks == true)
    {
      color("yellow")
      translate([-edgeRadius+lockThickness,
        (keebThickness/2)-edgeRadius+wallThickness,
        (keebLen/2+wallThickness)-lockRadius])
      rotate([90,0,0]) rotate([0,-90,0]) scale([1.02,1.02,1]) lock(negativ=true);

      color("yellow")
      translate([(keebHeight-edgeRadius*2+sideThickness*2+edgeRadius)-lockThickness,
        (keebThickness/2)-edgeRadius+wallThickness,
        (keebLen/2+wallThickness)-lockRadius])
      rotate([90,0,0]) rotate([0,90,0]) scale([1.02,1.02,1]) lock(negativ=true);
    }
  }
}

/* ################ BUILD_LINE ################# */
/* ############################################# */
/* ########## Place keyboard case ############## */
/* ############################################# */

color("yellow") translate([0,0,0]) halfCase(locks=true,magnets=true);
/* color("yellow") translate([0,0,keebLen+wallThickness*2+0.2]) mirror([0,0,1]) halfCase(locks=true,magnets=true); */


/* case locks */
/* color("green") translate([lockThickness-0.1,(keebThickness/2+wallThickness*2)-1,(keebLen/2)-lockRadius+3.5])
rotate([90,0,0]) rotate([0,-90,0]) lock(negativ=false); */

/* color("black") translate([(keebHeight+sideThickness*2)-lockThickness/3,(keebThickness/2+wallThickness*2)-1,(keebLen/2)-lockRadius+3.5])
rotate([90,0,0]) rotate([0,90,0]) lock(negativ=false); */



/*########### DEBUG ###########*/

/* test print */
/* difference()
{
  translate([0,0,0]) halfCase(locks=true,magnets=true);
  translate([0,-40,0]) cube([keebHeight+sideThickness*2+4,keebThickness+wallThickness*2+4,(keebLen/2)+wallThickness]);
} */
