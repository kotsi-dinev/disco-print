include </home/snooch/repos/BOSL2/std.scad>
include </home/snooch/repos/BOSL2/ball_bearings.scad>
// ====== PVC PIPE ======
pvcID = 26.137;
pvcOD = 33.401;


// ====== Sleeve =====
sleeveTopThick = 9;

sleeveOuterThick = 10;
sleeveOuterHeight = 35;

sleeveInnerThick = 3;
sleeveInnerHeight = 12;

// ==== Tolerances ====
ballbearingID_tolerance = 0.5;
ballbearingOD_tolerance = 0.2;
ballbearingH_tolerance = 0.3;

sleeveOuterID_tolerance = 1;
sleeveInnerOD_tolerance = 1;
sleeveInnerID_tolerance = 2;
big = 100;

module pvc()
{
    tube(h=30,od=pvcOD, id= pvcID, anchor=BOTTOM);
}


module outer_sleeve()
{
    sleeveOuterOD = pvcOD + sleeveOuterThick;
    tube(h=sleeveOuterHeight, id = pvcOD+sleeveOuterID_tolerance, od = sleeveOuterOD)
    children();
}

module inner_sleeve()
{
    sleeveInnerID = pvcID - sleeveInnerThick - sleeveInnerID_tolerance;
    tube(h=sleeveInnerHeight, id = sleeveInnerID, od = pvcID-sleeveInnerOD_tolerance)
    children();
}


module sleeve_face()
{
    bb_info = ball_bearing_info("608");
    bbID = bb_info[0] + ballbearingID_tolerance;
    bbOD = bb_info[1] + ballbearingOD_tolerance;
    bbH = bb_info[2] + ballbearingH_tolerance;
    diff()
    {
        tag("body") cylinder(h = sleeveTopThick, d=pvcOD + sleeveOuterThick, anchor=TOP)
        {
            tag("keep") children();
        }
        tag("remove") color("PURPLE") cylinder(h = big, d = bbID, anchor=TOP);
        tag("remove") color("BLUE") cylinder(h = bbH, d = bbOD, anchor=TOP);
    }
}


module main()
{
    
    sleeve_face()
    {
        #align(BOTTOM) outer_sleeve();
        align(BOTTOM) inner_sleeve();
        //align(BOTTOM) pvc();
    }
}



main();