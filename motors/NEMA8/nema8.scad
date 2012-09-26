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
		color (black) cube ([width, length, width], center = true);
		color (grey)
		{
			translate ([0, -length/2, 0]) rotate ([90,0,0]) cylinder (h = hub_width*2, r1 = hub_radius, r2 = hub_radius, center = true);
			translate ([0, -length/2, 0]) rotate ([90,0,0]) cylinder (h = shaft*2, r1 = shaft_radius, r2 = shaft_radius, center = true);
		}
	}
	
	color (grey)
	{
		// screw holes
		translate ([screw_separation/2, -length/2, screw_separation/2]) rotate ([90,0,0]) cylinder (h = screw_depth*2, r1 = screw_size/2, r2 = screw_size/2, center = true);
		translate ([-screw_separation/2, -length/2, screw_separation/2]) rotate ([90,0,0]) cylinder (h = screw_depth*2, r1 = screw_size/2, r2 = screw_size/2, center = true);
		translate ([screw_separation/2, -length/2, -screw_separation/2]) rotate ([90,0,0]) cylinder (h = screw_depth*2, r1 = screw_size/2, r2 = screw_size/2, center = true);
		translate ([-screw_separation/2, -length/2, -screw_separation/2]) rotate ([90,0,0]) cylinder (h = screw_depth*2, r1 = screw_size/2, r2 = screw_size/2, center = true);

		// flat on shaft
		translate ([0, -length/2 - shaft, shaft_radius]) rotate ([90,0,0]) cube ([5, 0.5, keyway*2], center = true);
	}
}