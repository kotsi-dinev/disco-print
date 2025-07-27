include </home/snooch/repos/BOSL2/std.scad>
include </home/snooch/repos/BOSL2/ball_bearings.scad>
// ====== PVC PIPE ======
pvcID = 26.137;
pvcOD = 33.401;


// ====== Sleeve =====
sleeveTopThick = 12;

sleeveOuterThick = 15;
sleeveOuterHeight = 30;

sleeveInnerThick = 3;
sleeveInnerHeight = 10;


big = 100;

module pvc()
{
    tube(h=30,od=pvcOD, id= pvcID, anchor=BOTTOM);
}


module outer_sleeve()
{
    sleeveOuterOD = pvcOD + sleeveOuterThick;
    tube(h=sleeveOuterHeight, id = pvcOD+2, od = sleeveOuterOD)
    children();
}

module inner_sleeve()
{
    sleeveInnerID = pvcID - 2 - sleeveInnerThick;
    tube(h=sleeveInnerHeight, id = sleeveInnerID, od = pvcID-2)
    children();
}


module sleeve_face()
{
    bb_info = ball_bearing_info("608");
    bbID = bb_info[0] + 0.1;
    bbOD = bb_info[1] + 0.3;
    bbH = bb_info[2] + 0.2;
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

sleeve_face()
{
    #align(BOTTOM) outer_sleeve();
    align(BOTTOM) inner_sleeve();
}
//color("red") outer_sleeve();
//color("blue") inner_sleeve();
//pvc();

//bearing();

