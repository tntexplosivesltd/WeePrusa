/////////////////////////////////////////////////////////////////
//// WeePrusa y-motor-bracket
// GNU GPL v3
//
// Maxumx (maxumx2002@yahoo.com)
// Thomas Phillips (tntexplosivesltd@gmail.com)
//
// https://github.com/tntexplosivesltd/WeePrusa
//
// y-motor bracket. Also holds the smoothand threaded rods
// Material: ABS, PLA(recomended)
////////////////////////////////////////////////////////////////

include <configuration.scad>
include <nema8.scad>
include <utils.scad>
$fn = 32;

base_thickness = 4;
base_width = 50;
base_length = 80;

block_width = 20;
block_length = 20;
block_height = 20;

nut_clearance = 8;
smooth_offset = 12;

screw_size = 3;
screw_depth = 5;

difference()
{
	union()
	{
		cube([base_length, base_width, base_thickness]);

		// Motor and mount
		translate([40-1.5-1.5-3.5, 5, base_thickness+2])
		{
			rotate([0, 0, 90]) nema8(1.6);
			translate([4, 0, 0])cube([5, 5, 4]);
		}

		translate([base_length/2 - rail_width, base_width - block_length/2, base_thickness+block_height/2])
			cube([block_width, block_length, block_height], center = true);
		translate([base_length/2 + rail_width, base_width - block_length/2, base_thickness+block_height/2])
			cube([block_width, block_length, block_height], center = true);
		//nut_washer(base_length/2 - rail_width, base_width - block_length, base_thickness+nut_clearance, 90, 0, 0);
	}
	translate([base_length/2 - rail_width, base_width+1, base_thickness+nut_clearance]) rotate([90, 0, 0]) cylinder(h=block_length+2, r=threaded_diameter/2);
	translate([base_length/2 + rail_width, base_width+1, base_thickness+nut_clearance]) rotate([90, 0, 0]) cylinder(h=block_length+2, r=threaded_diameter/2);
	translate([base_length/2 - rail_width, base_width+1, base_thickness+nut_clearance + smooth_offset]) rotate([90, 0, 0])
		cylinder(h=block_length-5, r=smooth_diameter/2);
	translate([base_length/2 + rail_width, base_width+1, base_thickness+nut_clearance + smooth_offset]) rotate([90, 0, 0])
		cylinder(h=block_length-5, r=smooth_diameter/2);
	screw_holes();
}

module screw_holes()
{
	for(i = [ [base_length/2 + rail_width + smooth_diameter, base_width-8, base_thickness+nut_clearance + smooth_offset - screw_depth],
			 [base_length/2 + rail_width - smooth_diameter, base_width-8, base_thickness+nut_clearance + smooth_offset - screw_depth],
			 [base_length/2 - rail_width + smooth_diameter, base_width-8, base_thickness+nut_clearance + smooth_offset - screw_depth],
			 [base_length/2 - rail_width - smooth_diameter, base_width-8, base_thickness+nut_clearance + smooth_offset - screw_depth] ])
	{
		translate(i)
		{
			cylinder(h=screw_depth+1, r=screw_size/2);
			cube([5.5, 17, 3], center = true);
		}
	}
}