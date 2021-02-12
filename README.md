# keebcu - a customizer for 3d printable keyboard case


**WORK IN PROGRESS!**
This Keyboard Customizer for OpenSCAD is usable and you can customize your keyboard. But there are still some imperfections and "bugs". Please double check measurements and fittings of your keyboard layout.
You fist may print some critical parts for testing everything.
The available keyboard models (in stl directory) should work and have been printed by me on a Prusa Mini.

This is a remix of Parametric Cherry MX Mounting Plate for Mechanical Keyboards by rsheldiii
http://www.thingiverse.com/thing:573578

## Description
This is a OpenSCAD Script for custumizing a keyboard with a spezific layout. It is designed to also do a simulation on how the keyboard could look like.

I designed the keyboard to be printable on smaller 3d printer build plates like Prusa Mini. Therefore, it is possible to configure where the keyboard should be cutted by the script. With this, it is possible to print a keyboard on smaller printers. The "smallTKL" design was the bigges layout I can print. If you have standard size printers like Prusa MK3 or Ender 3, etc, you may print normal TKL or even 100% layouts, eventually.
The cut will always be around the switch holes. This gives good stability when glueing the parts together.

You can copy the file "template_to_copy.scad" and start configuring your own layout. By uncomment the module calls at the end of the layout file, it is possible to create each part like "rigth & left case", "rigth & left lid", and also risers. It is also possible to create the hole keyboard if you can print this big parts.

If you want to simulate the keyboard with keycaps, you can clone rsheldiii's KeyV2 Repository
( https://github.com/rsheldiii/KeyV2 ) in parallel to this repository (<thisRepo>/..).
The SCAD script will include "../KeyV2/includes.scad". So just put it into the right directory.
Keycap styles can be replaced in the module "KeyboardSim(<layout>,<simulation true/false>)". See KeyV2 Wiki for available keycap profiles.


The keyboard layout is defined in an array. Here it is called "ansiUS_75keyboard" for example.
It describes (in Units):
    [ [ [xPos (Column) , yPos (Row)] , key size (in Unit)], color ]

A unit is the size of the cutout for a cherry mx style switch. So a normal key would be 1u,
Backspace would be 2u or spacebar is for example 6.25u. The size of the cutout for the switch is defined
as "lkey".
So if you want you can change the colors and have a look at how your keyboard may look!
You can add further keys into the array, but maybe the case will not fit automatically.
I will try to implement as many automatic functionalities as possible. (Or as long as I have fun with it :D).


![](pics/75er001.png)

![](pics/75er002.png)

![](pics/75er003.png)

![](pics/75er004.png)

![](pics/75er005.png)

![](pics/75er006.png)

![](pics/75er007.png)

![](pics/75er008.png)

![](pics/75er009.png)

![](pics/75er010.png)

![](pics/75er011.png)

![](pics/75er012.png)

![](pics/75er013.png)



### todo
- create selectable space (in y direction) between function row and next rows
- provide pcb cutout for teensy 2.0
- add delta variable for usb cutout and pcbholder to move it.
- function for iso layouts
- avoid case stabilizer for iso enter and numpad enter
- add cherry style stabilizer
- add scirting to case if needed


# LICENSE

<dl>
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons Lizenzvertrag" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />Dieses Werk ist lizenziert unter einer <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Namensnennung 4.0 International Lizenz</a>.
</dl>

<dl>
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
</dl>
