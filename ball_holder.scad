//VERSION 1.01

include <BOSL2/std.scad>
include <BOSL2/ball_bearings.scad>

/* ====== PVC PIPE ====== */

pvcID = 26.137;
pvcOD = 33.401;

pvcID_tol = 0.2;
pvcOD_tol = 0.2;

/* ====== Sleeve ====== */
sleeveTopThick = 10;

sleeveOuterThick = 10;
sleeveOuterHeight = 30;

sleeveInnerThick = 3;
sleeveInnerHeight = 10;

/* ====== Ball Bearings ====== */
bbOD_tol = 0.1;
bbID_tol = 0.1;
bbH_tol = 0.4;

/* [Hidden] */
big = 100; //Just a big number

sleeveOuterID = pvcOD + pvcOD_tol;
sleeveOuterOD = sleeveOuterID + sleeveOuterThick;

sleeveInnerOD = pvcID - pvcID_tol;
sleeveInnerID = sleeveInnerOD - sleeveInnerThick;

module pvc()
{
    tube(h=30,od=pvcOD, id= pvcID, anchor=BOTTOM);
}


module outer_sleeve()
{
    tube(h=sleeveOuterHeight, id = sleeveOuterID, od = sleeveOuterOD)
    children();
}

module inner_sleeve()
{
    tube(h=sleeveInnerHeight, id = sleeveInnerID, od = sleeveInnerOD)
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
        tag("body") cylinder(h = sleeveTopThick, d=sleeveOuterOD, anchor=TOP)
        {
            tag("keep") children();
        }
        tag("remove") cylinder(h = big, d = bbID, anchor=TOP);
        tag("remove") cylinder(h = bbH, d = bbOD, anchor=TOP);
    }
}

sleeve_face()
{
    align(BOTTOM) color([1,0,0]) outer_sleeve();
    align(BOTTOM) color([0,1,0]) inner_sleeve();
    //align(BOTTOM) color([0,0,1,0.5]) pvc();
}


