# keebcu - a customizer for 3d printable keyboard cases

## Keyboard Customizer

### TL;DR usage
```
- clone this repo: git clone https://github.com/andimoto/keebcu.git
- get OpenSCAD (I used 2021.01 and 2019.05 as appImages on Linux).
- open the template_to_copy.scad file in OpenSCAD (or copy and rename it for your own custom layout)
- uncomment 'mainCase(<layout>)' line at the end of the file to check what your are doing
- start customizing your layout (place switch holes and set colors of your keycaps if you want)
- set screw holes where needed or add even more of them (think about the risers on the bottom)
- set usb and pcb values
- set fRowSeparator to move F-Row up if needed
- depending on your printbed size, set where to cut the keyboard case
- (optional) print critical parts of the case like space bar, parts with other stabilizers or usb and pcb area to test everything fits
- generate all necessary model files you want to print by uncomment the proper module call or run the build.sh script
- save and print!
```

#### Notes
This is based on *Parametric Cherry MX Mounting Plate for Mechanical Keyboards* by rsheldiii
http://www.thingiverse.com/thing:573578

## Description
This is a OpenSCAD Script for customizing a keyboard with a specific layout. It is designed to also show a simulation on how the keyboard could look like by adding keycaps from KeyV2 project by rsheldiii. **So download OpenSCAD and start building your keyboard ;)!**

I designed the keyboard to be printable on smaller 3d printer build plates like Prusa Mini. Therefore, it is possible to configure where the keyboard should be cut by the script with 'cutAfterUnits' variable. With this, it is possible to print a keyboard on smaller printers. The "smallTKL" design is the biggest layout I can print for now. If you have standard size printers like Prusa MK3 or Ender 3, etc, you may print normal TKL or even 100% layouts, eventually :).
The cut will always be around the switch holes. This gives good stability when glueing the parts together. Before glueing, the parts may need some sanding work, etc. Just check that both sides fit to each other without bigger space in between.
(In theory, it should be possible to cut the keyboard into 3 or more parts. Therefore, new modules should be created and the pieces can be calculated by using difference function.)

I glued the parts together with Revell CONTACTA glue because of its fine needle which is very practical. Any plastic glue will work. I broke one of my prototype boards for testing and they are pretty stable if glued properly :). I had to use some force for it. Just be sure the case parts are glued well together!

#### Notes
This Keyboard Customizer for OpenSCAD is in "usable" state now, and you can customize your keyboard :). But there are still some imperfections and "bugs". I'm testing several layouts, like normal sized boards to macro pads, etc., from time to time.

Please double check measurements and fittings of your keyboard layout. You first may print some critical parts for testing the model.
The available keyboard models (in stl directory) should work and have been printed by me on a Prusa Mini. I can not give any guarantee on the correct functionality of this script.

### Current designs available
```
- andimoto7583 (printed, documented wiring)
- andimoto6061 (not printed)
- andimoto_smallTKL (printed)
- andimoto_smallTKL_iso (printed)
- andimotoTKL (not printed)
- andimotoTKLiso (not printed)
```

__Note:__
```
7583 is -> 75% layout with 83 switches.
6061 is -> 60% layout with 61 switches
smallTKL is TKL keyboard with one missing column
TKL - ten keyless
etc.
```

## Create your own keyboard layout
You can copy the file "template_to_copy.scad", rename it and start configuring your own layout. By uncomment the module calls at the end of the layout file, it is possible to create each part like "right & left case", "right & left lid", and also risers. It is also possible to create the whole keyboard itself in one piece if you can print bigger parts.

If you want to simulate the keyboard with keycaps and its colors, you can clone rsheldiii's KeyV2 Repository
( https://github.com/rsheldiii/KeyV2 ) in parallel to this repository (thisRepo/..).
The SCAD script will include "../KeyV2/includes.scad". So just put it into the right directory.
Keycap styles can be replaced in the module "KeyboardSim('layout','simulation true/false')" itself. See KeyV2 Wiki for available keycap profiles and documentation.

So you can change the colors and have a look at how your keyboard may look like!
You can add more keys into the array, but maybe the case will not fit automatically. Adjust 'height' and 'width' of the case, then.
I will try to implement some more automatic functionalities as possible.

The keyboard layout is defined in an array. In the template file it is called "template_ansiUS_7583" for example.
It describes (in Units):
```
    [ [xPos (Column) , yPos (Row)] , key size (in Unit), color ]
```

A unit is the size of the cutout for a cherry mx style switch. So, for example, a normal key is 1u,
backspace is 2u or spacebar is for example 6.25u. The size of the cutout for the switch is defined as 'lkey'.

You need to configure 'hight' and 'width' of the case. These variables are necessary for calculating case sizes. Maybe this will be automated, as the information should be calculatable from the layout array.

After your layout is set you can adjust and modify the array 'screwHoleArray' to set the scew holes to the right place you want them to. The lid will also use this array, and thus, the screw holes will fit automaticaly to the case. The standard screw size is 3mm. The length depends on the case height, but I used 3x8mm screws for my keyboards.

It is also possible to modify the pcb dimensions with the 'pcb'-values. Available sizes for Arduino Pro Micro and Teensy2 are included. Just change the comments to select the right one. I recommend to measure your pcb anyway and check dimensions. You can also move the whole pcb and cutout for usb connection in X direction by setting 'pcbShift' with a positive or negative value.

Generating risers for the keyboard can be selected with true/false and adjusted in width and length/depth. The colors of the risers and of cource the case and lid can be set after the screw hole array, at the end of the layout file.

With the variable 'fRowSeparator' you can select if the F-Row or the most upper Row (key[0][1]==0) will be moved upwards by a half key unit. See example 'andimotoTKL_iso'. When selecting 'true' some modules will call 'getExtraFRow()' function to get the value to move F-Row upwards.

If the keyboard should get a skirt you can set 'skirtSelect' to true. This enables calculation of an additional skirt around the keyboard. The parameters 'skirtX', 'skirtY' and 'caseRadius' define the skirts dimensions and the radius of the edges.


## Build STL Files
I added the script 'build.sh' for building all necessary parts of a keyboard at once. It reads 'conf/module-calls.conf' and places each call at the end of the keyboard file to render it and safe it in the stl directory. The output is saved in stl directory under the keyboard name.

```
NOTE: openscad command should be in $PATH or the environment variable OPENSCADPATH should be set to the OpenSCAD binary.
For example:
                export OPENSCADPATH=/home/<user>/<pathToBinary>/OpenSCAD-2021.01-x86_64.AppImage
```

```
build.sh parameter:

./build.sh <keyboard name> <config file>
    - keyboard name: name of the keyboard file without .scad extension
    - (optional) config file: mymodules.conf (any file name is possible, just add the proper syntax)

for example:
    ./build.sh andimotoTKL

    or

    /build.sh andimoto6061 myModuleCalls.conf
```

```
NOTE: do not remove this line from the keyboard file and do not place this line in between the configuration variables

              /* ###################### BUILD_LINE ########################*/
```

### build.sh description
The build.sh script checks if OpenSCAD binary is available. If not, user has to set OPENSCADPATH to point to the binary.
Then it checks parameters. The 1st parameter is necessary and tells the name of the keyboard to build. The script then appends .scad extension automaticaly and uses the name for the output directory. No keyboard file name will stop the script and return an error. Then it checks optional parameter of config file. Default config file will be used if no 2nd parameter is given.

Each keyboard file has a separator at the end "BUILD_LINE". The script greps for the line number of the separator and prints out the keyboard file until this line number. This output will be saved in an temporary directory which will be removed after build. Also and output directory will be generated to save stl files in it.
Then it places each module call from the config file at the end and calls OpenSCAD with the generated file to render the stl part. After this it places the next module call and generates the next stl, an so on.

You can add your own config file with the module calls you want and call the build.sh script with the config file as 2nd parameter. If no 2nd parameter is given, the script uses default config file 'conf/module-calls.conf'. The script greps for 'module' and separates the line at ':'. The last part will be used and appended to the created scad file.

```
config file syntax:
  module1: mainCase(layout);
  module2: lidR();
  module3: myOwnModuleCall(withParam);
```


__This was only tested on Linux Mint 19.3 (Ubuntu 18.04) and Linux Mint 20 (Ubuntu 20.04).__


## Parts needed
- Printed Keyboard Parts
  - Case
  - Lids
  - Risers
- __Cherry MX Style switches__
- __Costar Stabilizers__
- __Fancy Keycaps__
- __Teensy2 or Arduino Pro Micro__
- Screws 3x8mm
- Thin wires
- 1N4148 diodes

__Note:__ Parts can be bougth from ebay, amazon, etc. There is great choise, but also many things are not available or in stock...


## Assembly
- use sandpaper and a scalpel to clear the surface where parts get glued together. Double check if parts does not block each other.
- glue the two case parts together carefully. Place them on a flat surface and put some books on each side, then put some glue into the rills.
- wait until it is dry and put some more glue on it if needed.
- after some drying time you can put in the switches (it is possible that this will bend the keyboard)
  - maybe you need to add more glue when keyboard is bended
  - switches which will have stabilizers should be set with the champfer downwards. Champfer is where LED placement is on the switch. Then the stabilizers have space inside the keycaps.
- solder switches and diodes together (see directory wiring_sheets)
  - you can checkout qmk guide for handwiring -> https://beta.docs.qmk.fm/using-qmk/guides/keyboard-building/hand_wire
- solder the controller onto the keyboard matrix and place the pcb inside the pcb holder of the lid.
- build, flash and test your firmware (you can use this for testing https://keyboardchecker.com/)
- screw all parts together and place the risers if you need them (I recommend gluing the risers on the lids and then assembly them to the case)
- if you use Costar Stabilizers, place the stabilizers downwards.
- have fun with your keyboard ;)


## Printing advises
- Use brim for keyboard case. As there are many holes, the plate adhesion can be weak and the corners can rise up a little bit.
- Be careful with color changes. If color change is only at height of case stabilizer (not keycap stabilizers!!) or screw holes, there can be problems when screwing on the lid. I broke the top part of the scrw cylinder where the color change had no good adhesion the other layers. I recommend to do the color change at the last layer of the keyboard cases plate. (See https://github.com/andimoto/keebcu/tree/master/pics/img/screwHolesColorChange.jpg)
  - Note: even this issue may be fixed with the oval spacers for the screws, double check the stability of the screw holes by printing a small prototyp with color change where you want it.
- Notice that when placing in the switches, the keyboard case will bend (mid up, sides down) there is the variable 'switchHoleTolerance' which you can modifiy if needed.
- normally the lid parts do not need any brim.
- check if your printer prints right-angled. I had issues with my Prusa Mini printing exact squared parts. More info [here](https://forum.prusaprinters.org/forum/how-do-i-print-this-printing-help/how-to-fix-bending-of-a-box/).

## todo
- create selectable space (in y direction) between function row and next rows (DONE: fRowSeparator)
- provide pcb cutout for teensy 2.0 (DONE)
- add delta variable for usb cutout and pcbholder to move it. (DONE)
- avoid case stabilizer for iso enter and numpad enter (optional)
- add cherry style stabilizer!
- add a selectable skirt to the case
- add parametric keebCase (in progress, should be already usable)
- screw holes get crossed by case stabilizer (DONE / screw hole standoffs have an oval shape now)
- documentation for keebCase.scad
- add build script (DONE)
- other build system (make or docker, etc.)
- test other keyboard layouts like random stuff or ten keys

## Wrist rest and Keyboard Case
For each keyboard a wrist rest can be created with the model file wrist.scad. The stl-directory contains a wrist rest for each keyboard which can be printed as you want.
For transportation I designed a case which can be customized in size to fit your keyboard. The case has placeholders for little magnets and gets locked by some kind of bones :).

__Attention: The Keyboard case is still in development state. I just printed some smaller prototypes. But it fits well so far. Need to check magnets.__


## Firmware
For firmware please see https://github.com/andimoto/qmk_firmware/tree/andimoto-keyboards/keyboards/andimoto

The qmk_firmware fork contains everything to build the firmware for the provided boards *andimoto7583* and *andimoto_smallTKL*.

**Attention: The Pro Micro is "normally" suited for layouts with up to 65 switches. I was lazy and did not want to modify the pcb cutout to fit in the teensy 2.0 at that time. So I removed both TX/RX Leds from the pro micro and had 2 extra pins available (pcb may be damaged!!). This enables layouts with up to 84 switches :). Also qmk_layout needs to be squeezed together.**

*I will also add a schematic for soldering the keyboard matrix and the Pro Micro of the available boards.*

Available wiring diagrams for:
- andimoto7583 with Arduino Pro Micro

The Arduino Pro Micro clones are very cheap so I used them. More money for fancy keycaps ;).

## Model Gallery
*andimoto7583*
![](pics/75er001.png)

*andimoto smallTKL iso*
![](pics/75er004_1.png)

*andimoto smallTKL*
![](pics/andimoto_smallTKL.png)

*andimoto smallTKL_iso*
![](pics/andimoto_smallTKL_isoBlue.png)

*andimoto6061*
![](pics/75er004_2.png)

*andimotoTKL*
![](pics/andimotoTKL.png)

*andimotoTKLiso*
![](pics/andimotoTKLiso.png)

![](pics/75er013.png)

![](pics/75er002.png)

![](pics/75er003.png)

![](pics/75er004.png)

![](pics/75er005.png)

![](pics/75er006.png)

![](pics/75er007.png)

*andimoto smallTKL_iso case*
![](pics/andimoto_smallTKL_iso.png)

![](pics/75er009.png)

![](pics/75er010.png)

![](pics/75er011.png)

![](pics/75er012.png)

![](pics/keebCase.png)

![](pics/keebCaseLocks.png)

### Reality

![](pics/pics/keebcu_017.JPG)

![](pics/pics/keebcu_013.JPG)

![](pics/pics/keebcu_014.JPG)

![](pics/pics/keebcu_015.JPG)

![](pics/pics/keebcu_004.JPG)

![](pics/pics/keebcu_005.JPG)

![](pics/pics/keebcu_009.JPG)

![](pics/img/IMG_20210318_140604.jpg)

![](pics/img/IMG_20210318_140627.jpg)

![](pics/img/IMG_20210406_151424.jpg)

![](pics/img/IMG_20210406_151405.jpg)

![](pics/img/IMG_20210406_151326.jpg)

![](pics/img/IMG_20201215_085124.jpg)

![](pics/img/IMG_20201224_110407.jpg)

![](pics/img/IMG_20210111_151044.jpg)

![](pics/img/IMG_20201215_085352.jpg)

![](pics/img/IMG_20210111_150655.jpg)

![](pics/pics/keebcu_016.JPG)



# LICENSE

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons Lizenzvertrag" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />Dieses Werk ist lizenziert unter einer <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Namensnennung - Weitergabe unter gleichen Bedingungen 4.0 International Lizenz</a>.

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.
