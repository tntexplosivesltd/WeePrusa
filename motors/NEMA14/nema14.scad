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
width = 35.2;
torque = 4;

// Shaft
shaft = 24;
shaft_radius = 2.5;
keyway = 15;
hub_radius = 11;
hub_width = 2;

// Screws
screw_size = 3;
screw_depth = 4.5;
screw_separation = 26;

function get_length(t) = lookup(t, [
			[4, 20],
			[6.5, 26],
			[7, 28],
			[12.5, 28],
			[10, 26],
			[14, 26],
			[18, 34],
			[18.5, 41],
			[23, 42],
			[40, 52],
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
	color (black) translate ([0, length, 0]) rotate ([90,0,0]) cube ([width, width, length], center = true);
}