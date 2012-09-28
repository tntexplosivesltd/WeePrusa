module nut_washer(x, y, z, a, b, c)
{	
	color("silver") translate([x, y-4.25, z]) rotate([a, b, c]) difference()
	{
		union()
		{
			cylinder(h = 7, r = 7.5, $fn = 6, center = true);
			translate([0, 0, -3.5]) cylinder(h = 1.5, r = 8, center = true);
		}
		#translate([0, 0, -1]) cylinder(h = 10, r = 4, center = true);
	}
}