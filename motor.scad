// WeePrusa
// Stepper Motors
// GNU GPL v3
// Thomas Phillips (tntexplosivesltd@gmail.com)
// https://github.com/tntexplosivesltd/WeePrusa

$fn = 32;

// Colours
black = [12/255, 12/255, 12/255];
grey = [200/255, 200/255, 200/255];

module motor(length)
{	
	difference()
	{
		union()
		{
			color (black) cube ([nema_width, length, nema_width], center = false);
			color (grey)
			{
				translate ([nema_width/2, 0, nema_width/2])
				{
					rotate ([90,0,0]) cylinder (h = nema_hub_width, r1 = nema_hub_radius, r2 = nema_hub_radius);
					rotate ([90,0,0]) cylinder (h = nema_shaft, r1 = nema_shaft_radius, r2 = nema_shaft_radius);
				}
			}
		}
	
		color (grey)
		{
			translate([nema_width/2, nema_screw_depth, nema_width/2])
			{
				// screw holes
				translate ([nema_screw_separation/2, 0, nema_screw_separation/2]) rotate ([90,0,0])
					cylinder (h = nema_screw_depth+1, r = nema_screw_size/2);
				translate ([-nema_screw_separation/2, 0, nema_screw_separation/2]) rotate ([90,0,0])
					cylinder (h = nema_screw_depth+1, r = nema_screw_size/2);
				translate ([nema_screw_separation/2, 0, -nema_screw_separation/2]) rotate ([90,0,0])
					cylinder (h = nema_screw_depth+1, r = nema_screw_size/2);
				translate ([-nema_screw_separation/2, 0, -nema_screw_separation/2]) rotate ([90,0,0])
					cylinder (h = nema_screw_depth+1, r=nema_screw_size/2);

				// flat on shaft
				rotate ([90,0,0]) translate ([-nema_shaft_radius, nema_shaft_radius-0.5, nema_shaft+nema_screw_depth-nema_keyway]) 
					cube ([5, 0.5, nema_keyway+1]);
			}
		}
	}
}