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
// Material: ABS or PLA
////////////////////////////////////////////////////////////////

include <configuration.scad>
include <nema8.scad>
include <utils.scad>
$fn = 32;

base_thickness = 4;
base_width = 30+nema_width;
base_length = 100;

block_width = 20;
block_length = 20;
block_height = 20;

nut_clearance = 8;
smooth_offset = 12;

screw_size = 3;
screw_depth = 5;

mount_thickness = 4;
edge_thickness = 5;
round_radius = 2;


difference()
{
	union()
	{
		color("royalblue") cube([base_length, base_width, base_thickness]);

		// Motor and mount
		translate([base_length/2 - 6.5, 5, base_thickness+0.5])
		{
			union()
			{
				// Motor mount
				color("royalblue") difference()
				{
					union()
					{
						translate([0, -edge_thickness, -0.5])cube([mount_thickness, nema_width+2*edge_thickness, nema_width+edge_thickness]);
						translate([-(base_length/2 - 6.5), -edge_thickness, -0.5]) cube([base_length/2 - 6.5, edge_thickness - 0.5, nema_hub_radius-2.5]);
					}
					translate([-0.5, nema_width/2, nema_width/2]) rotate([0, 90, 0]) cylinder(h=mount_thickness+1, r=nema_hub_radius+0.5);
					translate([-0.5, -edge_thickness-0.1, nema_hub_radius-3]) cube([mount_thickness+1, nema_width+2*edge_thickness+0.2, nema_width+edge_thickness]);

					// Mounting Holes
					motor_mounting_hole(0, nema_width/2-nema_screw_separation/2, nema_width/2-nema_screw_separation/2);
					motor_mounting_hole(0, nema_width/2+nema_screw_separation/2, nema_width/2-nema_screw_separation/2);
		
					// Fillets around motor mount
					translate([-0.5, nema_width+edge_thickness+0.01, nema_hub_radius-2.99]) rotate([90, 0, 90]) fillet(round_radius, mount_thickness+1, 32);
					translate([mount_thickness+0.5, -edge_thickness-0.1, nema_hub_radius-2.99]) rotate([90, 0, -90]) fillet(round_radius, mount_thickness+base_length/2 - 5.5, 32);
				}
			}

			rotate([0, 0, 90]) nema8(4);
		}

		// y-axis rod blocks
		color("royalblue")
		{
			translate([base_length/2 - rail_width, base_width - block_length/2, base_thickness+block_height/2])
				cube([block_width, block_length, block_height], center = true);
			translate([base_length/2 + rail_width, base_width - block_length/2, base_thickness+block_height/2])
				cube([block_width, block_length, block_height], center = true);
			//nut_washer(base_length/2 - rail_width, base_width - block_length, base_thickness+nut_clearance, 90, 0, 0);
		}
	}

	// rod holes and screw holes
	color("royalblue")
	{
		translate([base_length/2 - rail_width, base_width+1, base_thickness+nut_clearance]) rotate([90, 0, 0]) cylinder(h=block_length+2, r=threaded_diameter/2);
		translate([base_length/2 + rail_width, base_width+1, base_thickness+nut_clearance]) rotate([90, 0, 0]) cylinder(h=block_length+2, r=threaded_diameter/2);
		translate([base_length/2 - rail_width, base_width+1, base_thickness+nut_clearance + smooth_offset]) rotate([90, 0, 0])
			cylinder(h=block_length-5, r=smooth_diameter/2);
		translate([base_length/2 + rail_width, base_width+1, base_thickness+nut_clearance + smooth_offset]) rotate([90, 0, 0])
			cylinder(h=block_length-5, r=smooth_diameter/2);
		screw_holes();
	}
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
			translate([-2.5, -3, -1.5]) cube([5.5, block_length-6 , 3], center = false);
		}
	}
}

module motor_mounting_hole(x, y, z)
{
	translate([x-0.5, y, z-0.5]) rotate([0, 90, 0]) cylinder(h=mount_thickness+1, r=nema_screw_size/2+0.25);
	translate([x-0.5, y, z+0.5]) rotate([0, 90, 0]) cylinder(h=mount_thickness+1, r=nema_screw_size/2+0.25);
	translate([x-0.5, y-nema_screw_size/2-0.25, z-0.5]) cube([mount_thickness+1, nema_screw_size+0.5, 1]);
}

// Taken from the Prusa i3 functions.scad
module fillet(radius, height=100, $fn=0) {
    //this creates acutal fillet
    translate([-radius, -radius, -0.01])
        difference() {
            translate([0, 0, 0.02] )cube([radius, radius, height]);
            cylinder(r=radius, h=height+0.04, $fn=$fn);
        }
}