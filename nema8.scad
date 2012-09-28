// WeePrusa
// Stepper Motors
// GNU GPL v3
// Thomas Phillips (tntexplosivesltd@gmail.com)
// https://github.com/tntexplosivesltd/WeePrusa

$fn = 32;

// Colours
black = [12/255, 12/255, 12/255];
grey = [200/255, 200/255, 200/255];

// Motor back
width = 20.3;
torque = 1.6;

// Shaft
shaft = 10;
shaft_radius = 2;
keyway = 7;
hub_radius = 8;
hub_width = 1.5;

// Screws
screw_size = 2;
screw_depth = 2.5;
screw_separation = 15.4;

function get_length(t) = lookup(t, [
			[1.6, 28],
			[1.8, 30],
			[2, 33],
			[3, 38],
			[4, 38],
	]);

length = get_length(torque);

difference()
{
	union()
	{
		color (black) cube ([width, length, width], center = false);
		color (grey)
		{
			translate ([width/2, 0, width/2])
			{
				rotate ([90,0,0]) cylinder (h = hub_width, r1 = hub_radius, r2 = hub_radius, center = false);
				rotate ([90,0,0]) cylinder (h = shaft, r1 = shaft_radius, r2 = shaft_radius, center = false);
			}
		}
	}
	
	color (grey)
	{
		translate([width/2, screw_depth, width/2])
		{
			// screw holes
			translate ([screw_separation/2, 0, screw_separation/2]) rotate ([90,0,0])
				cylinder (h = screw_depth+1, r1 = screw_size/2, r2 = screw_size/2, center = false);
			translate ([-screw_separation/2, 0, screw_separation/2]) rotate ([90,0,0])
				cylinder (h = screw_depth+1, r1 = screw_size/2, r2 = screw_size/2, center = false);
			translate ([screw_separation/2, 0, -screw_separation/2]) rotate ([90,0,0])
				cylinder (h = screw_depth+1, r1 = screw_size/2, r2 = screw_size/2, center = false);
			translate ([-screw_separation/2, 0, -screw_separation/2]) rotate ([90,0,0])
				cylinder (h = screw_depth+1, r1 = screw_size/2, r2 = screw_size/2, center = false);

			// flat on shaft
			rotate ([90,0,0]) translate ([-shaft_radius, shaft_radius-0.5, shaft+screw_depth-keyway]) 
				cube ([5, 0.5, keyway+1], center = false);
		}
	}
}