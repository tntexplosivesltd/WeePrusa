module nut_washer(x, y, z, a, b, c)
{	
	color("silver") translate([x, y-3.4, z]) rotate([a, b, c]) difference()
	{
		union()
		{
			cylinder(h = 5.2, r = 5, $fn = 6, center = true);
			translate([0, 0, -2.6]) cylinder(h = 1.6, r = 6, center = true);
		}
		#translate([0, 0, -1]) cylinder(h = 8, r = 3, center = true);
	}
}