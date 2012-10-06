///////////////////////////////////////////////////////////////////////////////
//// WeePrusa HotEnd mk 1.0.0
// GNU GPL v3
//
// Maxumx (Maxumx2002@yahoo.com)
// Thomas Phillips (tntexplosivesltd@gmail.com)
//
// https://github.com/tntexplosivesltd/WeePrusa
//
// This hotend is a micro print hot end, intended for use with 1.75mm filament
// Material: High heat Stainless Steel or Inconel	
///////////////////////////////////////////////////////////////////////////////

include <configuration.scad>

$fn = 32;

// Hotend module
module hotend(block=true, res_width=5.52, therm_width=2.5, therm_depth=4, nozzle_width=0.4, insert=true)
{

	union()
	{
		difference()
		{
			union()
			{
				// Cold end
				color(stainless)
				{
					echo("lol", brass);
					translate([0,0,10]) cylinder(h = 12, r = 6); //BottomGripper
					translate([0,0,25]) cylinder(h = 3, r = 6);
					translate([0,0,31]) cylinder(h = 3, r = 6);
					translate([0,0,37]) cylinder(h = 3, r = 6);
					translate([0,0,45]) cylinder(h = 3, r = 6);

					translate([0,0,22]) cylinder(h = 3, r = 4);
					translate([0,0,28]) cylinder(h = 3, r = 4);
					translate([0,0,34]) cylinder(h = 3, r = 4);
					translate([0,0,40]) cylinder(h = 5, r = 4);   //Top Gripper
					//ToDo: Optional Bowden Connector top section
				}

				// Heated nozzle
				color(brass)
				{
					if (block) translate([-11, -7, 0]) cube([20, 14, 10]);
					else cylinder( h = 10, r = 11.25);
					translate([0,0,-3])cylinder( h = 3, r1 = 0.9, r = 4);
				}
			}
			union()  
			{
				// Inside of barrel
				color(brass)
				{
					// inside, allowed variance of filliment of +-.05r
					translate([0,0,-3.1])cylinder(h = 3.1, r = nozzle_width/2, $fn=100 );
					cylinder(h = 4, r1 = nozzle_width/2, r2 = 1, $fn =100);
					if (insert) translate([0,0,4])cylinder(h = 44.1, r = 3, $fn = 100);
					else translate([0,0,4])cylinder(h = 44.1, r = 1, $fn = 100);
				}

				color(brass)
				{
					// resistor slot for a 12mm x 5.5mm 6.8ohm +-0.02r
					rotate([90,0,0])translate([-7,5,-11.25])cylinder(h = 22.5, r = res_width/2, $fn=100);

					// Thermistor Hole (Epcos#B57560G0145) 2.3mm +-0.2r
					rotate([90,0,0])translate([7,5,7-therm_depth])cylinder(h = therm_depth+3, r = therm_width/2, $fn=100);
				}
			}
			if (!insert) color("silver") translate([0,0,45])cylinder(h = 6, r1 = 0, r2 = 6, $fn = 100);
		}

		// PTFE Liner
		if (insert) color("white") difference()
		{
			translate([0,0,4])cylinder(h = 44, r=3, $fn = 100);
			translate([0,0,4])cylinder(h = 44, r = 1, $fn = 100);
			translate([0,0,46])cylinder(h = 6, r1 = 0, r2 = 6, $fn = 100);
		}
	}
}