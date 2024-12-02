/*
 * OpenSCAD Code for Mounts and Components
 * Author: polijn
 * Description:
 * This script defines modules for creating various mounts and components,
 * including a LEGO mount, laser holes, camera mount, and emission filter mount.
 * Parameters are provided to adjust dimensions and features as needed.
 */
use <LEGO.scad>;
// ====================================================
// Module: LEGO Mount
// ====================================================
module lego_mount(lego_layer=1,neck_z=3){
    neck_y = 31;
    neck_x = 20;
    translate([0,70,-1.5])rotate([0,0,90]) block(width=3,length=6,height=lego_layer/3,type="block",reinforcement="yes",include_wall_splines="no");
    translate([0,32,neck_z/2-1.5]){cube([neck_x,neck_y,neck_z], center=true);};
}
// ====================================================
// Module: Laser Mount
// submodules: laser_holes
// ====================================================
// laser holes
module laser_holes(laser_dia = 12,laser_dist = 50){
    // this example uses 4 laser with an angle of 15 degree 
    // this is a poormans "simulation" of how to overlap 4 lasers
//    laser_dist = 50; // the distance of the laser mount and where the laser ovrlap
//    laser_dia = 12; 
    rotate([-15,0,0]){cylinder(h=laser_dist,d=laser_dia, $fn=100);}
    rotate([-15,0,180]){cylinder(h=laser_dist,d=laser_dia, $fn=100);}
    rotate([15,0,90]){cylinder(h=laser_dist,d=laser_dia, $fn=100);}
    rotate([-15,0,90]){cylinder(h=laser_dist,d=laser_dia, $fn=100);}
}
// laser_mount
module laser_mount(){
    difference(){
        translate([0,0,1]) cube([35,35,5],center=true);
        translate([0,0,-40]) rotate([0,0,045]) laser_holes();
    }
}
// ====================================================
// Module: Camera Mount
// submodules: cube_base, screw_holes
// ====================================================
// cube_base
module cube_base(){
    dim = 33;
    x_hole = 12 + 1;
    y_hole = 19 - 4 ;
    y_offset = 2 + 4;
    x_offset = 7 -1;
    difference(){
        translate([0,-3+7,0])cube([dim,dim,3],center=true);
        translate([x_offset - 12.5, y_offset - 12, -2]){cube([x_hole,y_hole,6]);}
    }

}
// screw_holes
module screw_holes(){
    x_cam = 25;
    y_cam = 24;
    hole_dia = 1.5;
    hole_dist = 12.5;
    // hole one
    translate([2,2,0]){cylinder(h = 5, d = hole_dia, $fn=100);}
    // hole two
    translate([x_cam - 2,2,0]){cylinder(h = 5, d = hole_dia, $fn=100);}
    // hole three
    translate([2, 2 + hole_dist,0]){cylinder(h = 5, d = hole_dia, $fn=100);}
    // hole four
    translate([x_cam - 2, 2 + hole_dist,0]){cylinder(h = 5, d = hole_dia, $fn=100);}
}
// cam_mount
module cam_mount(){
    base_thickness = 2;
    base_overlap = 2;
    pos_offset = base_overlap / 2;
    hole_dist = 14.5;
    difference() {
        translate([0,-4,0]) cube_base();
        translate([-12.5,-1 - hole_dist,-2]) screw_holes();
    }
}
// ====================================================
// Module: Filter Lens Mount
// submodule: filter_lens
// ====================================================
module filter_lens(){
    difference(){
        cylinder(h=3.5,d=25.1,$fn=100);
        translate([0,0,0])cylinder(h=3.5-1.5,d=22,$fn=100);
    }
    translate([0,0,-2])cylinder(h=7,d=21,$fn=100);
}
// filter_lens_mount
module filter_lens_mount(){
    difference(){
    cube([33,33,3],center=true);
    filter_lens();    
    }
}
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
// ====================================================
// Some examples of modules
// combined with the lego mount
// ====================================================
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
// ====================================================
// this is is a mount for 4 laser with 
// an outer diameter of 12mm 
// the angle of the laser are aranged 
// at 15 degrees and the laser distance
// is set to 50mm. In this example the 
// laser light cones will approxamatly 
// overlay at 50mm from the laser mount.
// ====================================================
if(1){
    translate([0,0,80])lego_mount(lego_layer=2,neck_z=5);
    translate([0,0,80])laser_mount();
}
// ====================================================
// this is is a mount for a 25mm tholabs filter lens 
// ====================================================
if(1){
    translate([0,0,20])filter_lens_mount();
    translate([0,0,20])lego_mount();
}
// ====================================================
// this is is a mount for for the Raspberry Pi 
// Camera V3 module.
// to the best of my knowledge 
// this is comatable with all piCam modules
// ====================================================
if(1){
    translate([0,0,0])cam_mount();
    translate([0,0,0])lego_mount();
}


if (1){
     // emission filter 
    color([0.168,0.694,0.941],0.8) translate([0,0,20]) cylinder(h=2,d=25);
    /// pi cam v3 wide 
    m_offset = 15;
    color([0.3176,0.419,0.07],1)translate([0,0,-12.5 + m_offset]) cylinder(h=4, d=6,$fn=50); // 6 is not
    color([0.3176,0.419,0.07],1)translate([0,0,-14.5 + m_offset]) cube([10,10,4],center=true);
    color([0.3176,0.419,0.07],1)translate([0,-4,-18 + m_offset]) cube([25,24,3],center=true);
    // laser 
    color([0,1,0],1) translate([0,0,32])rotate([0,0,45]) laser_holes(laser_dia = 9, laser_dist = 55);
    difference(){
        color([1,0.843,0],1) translate([0,0,32])rotate([0,0,45]) laser_holes(laser_dia = 13, laser_dist = 75);
        color([0,1,0],1) translate([0,0,31.9])rotate([0,0,45]) laser_holes(laser_dia = 13.1, laser_dist = 46);
    }
}
 
 
 
 
 
 
 
