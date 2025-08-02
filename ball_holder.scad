//VERSION 1.2

include <BOSL2/std.scad>
include <BOSL2/ball_bearings.scad>

/* ====== PVC PIPE ====== */

pvcID = 26.137;
pvcOD = 33.401;

pvcID_tol = 0.4;
pvcOD_tol = 0.4;

/* ====== Sleeve ====== */
sleeveTopThick = 11;

sleeveOuterThick = 8;
sleeveOuterHeight = 10;

sleeveInnerThick = 3;
sleeveInnerHeight = 8;

/* ====== Ball Bearings ====== */
bbOD_tol = 0.4;
bbID_tol = 0.3;
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
    bbID = bb_info[0] + bbID_tol;
    bbOD = bb_info[1] + bbOD_tol;
    bbH = bb_info[2] + bbH_tol;
    echo(bbH);
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


