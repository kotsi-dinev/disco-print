/*
----- MEASURED DIMENSIONS -----
Bolt Diameter:  5/16th inch = 7.93mm
Bolt Length:    35mm -> 25mm
    - subtract 10mm for washer and nut?

Shaft Diameter: 3.9mm
Shaft Length:   9.75mm
Difference between Full Shaft and Cutout: 0.6mm

PVC Pipe Average ID: 26.1366mm (1.029 inches)


==============================================================================
        NOTES v1.0
==============================================================================
[DONE]  Screw Head Could be a little bigger
[DONE]  Nuts definitely need to be bigger
[DONE]  Longer bolt-side of coupler (6.9 mm)


- Waaay more wall thickness. Give them boys like 5-10 layers deep? Make it deep
==============================================================================

--- M4 Bolt Dimensions ---
--------------------------------------------------------- 
|   Thread Size |   Major Diameter  | 	Minor Diameter  |
--------------------------------------------------------- 
|   M4 	        |   4.0 mm          |   3.242 mm        | 
--------------------------------------------------------- 
BOLT HEAD DIAMETER: 6.78 - 7.22mm

--- M4 Nut Dimensions ---
Flat to Flat (Wrench) width: 7mm (Call it 7.1mm)
Nut Height: 3mm
*/

//========== Motor Side Coupling ============
// Length of motor shaft
shaftLen = 9.75;
// Diameter of the motor shaft
motorShaftDiameter = 3.9;
//Depth of notch on flat side shaft
rodNotch = 0.6;

//========== Bolt Side Coupling ============
// Diameter of the rod
threadedRodDiameter = 7.9;
// Length of the rod
rodLen = 25;

//========== Coupler Body ============
// Height of the coupler, half for the motor shaft and half for the rod
couplerHeight = rodLen + shaftLen;
// External diameter of the coupler
couplerExternalDiameter = 26;
// Gap between the two halves
halvesDistance = 0.5;

//========== Screw ============
// Diameter of the screw head
screwHeadDiameter = 7;
// Diameter of the screw thread
screwDiameter = 3.4; 
// Length of the screw
screwThreadLength = 10;

//========== Hex Nut ============
// Width across flats of the nut (wrench size)
nutWidth = 7.1;
// Thickness of the nut
nutThickness = 2.8;

/* [Hidden] */
// end of Customizer variables
shaftScrewsDistance = motorShaftDiameter+screwDiameter+1.5;
rodScrewsDistance = threadedRodDiameter+screwDiameter+1.5;

$fa = 0.02;
$fs = 0.25;
little = 0.01; // just a little number
big = 100; // just a big number

module shaft()
{
    height = shaftLen + 2*little;
    translate([0,0,-little])
    difference()
    {
        cylinder(d=motorShaftDiameter, h=height);
        translate([0,(motorShaftDiameter-rodNotch), (height + 2)/2])
            cube([motorShaftDiameter, motorShaftDiameter,height - 2], center = true);
    }
}

module coupler()
{
    difference()
    {
        // main body
        cylinder(d=couplerExternalDiameter, h=shaftLen + rodLen);
        // shaft
        rotate([0,0,90])
        shaft();
        // rod
        translate([0,0,shaftLen])
            cylinder(d=threadedRodDiameter, h=rodLen+little);
        // screws
        translate([0,shaftScrewsDistance/2,shaftLen/2])
            rotate([90,0,90])
                screw();
        translate([0,-shaftScrewsDistance/2,shaftLen/2])
            rotate([90,0,270])
                screw();
        translate([0,rodScrewsDistance/2,shaftLen+rodLen/2])
            rotate([90,0,90])
                screw();
        translate([0,-rodScrewsDistance/2,shaftLen+rodLen/2])
            rotate([90,0,270])
                screw();
        // cut between the two halves
        cube([halvesDistance,big,big], center=true);
    }
    
}

module screw()
{
    // thread
    cylinder(d=screwDiameter, h=big, center=true);
    // head
    translate([0,0,(screwThreadLength-nutThickness)/2])
        cylinder(d=screwHeadDiameter, h=big);
    // nut
    translate([0,0,-(screwThreadLength-nutThickness)/2])
        rotate([180,0,30])
            cylinder(d=nutWidth*2*tan(30), h=big, $fn=6);
}

translate([1.5,0,0])
intersection()
{
    translate([0,-big/2,0])
        cube([big,big,big]);
    coupler();
}

translate([-1.5,0,0])
intersection()
{
    translate([-big,-big/2,0])
        cube([big,big,big]);
    coupler();
}