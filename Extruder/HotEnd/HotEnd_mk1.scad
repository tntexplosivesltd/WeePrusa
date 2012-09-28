/////////////////////////////////////////////////////////////////
// WeePrusa HotEnd mk 1.0.0
// This hotend is a micro print hot end, intended for use with 1.75 filiment
// 
//
// Material: High heat Stainless Steel or Inconel
////////////////////////////////////////////////////////////////

difference()
	{
		union() //outside
		{
			cylinder( h = 10, r = 11.25); //Thermal Mass insulation
			translate([0,0,10]) cylinder(h = 12, r = 6); //BottomGripper
			translate([0,0,22]) cylinder(h = 3, r = 4);   //colling vanes
			translate([0,0,24]) cylinder(h = 3, r = 6);
			translate([0,0,27]) cylinder(h = 3, r = 4);
			translate([0,0,30]) cylinder(h = 3, r = 6);
			translate([0,0,33]) cylinder(h = 3, r = 4);
			translate([0,0,36]) cylinder(h = 3, r = 6);
			translate([0,0,39]) cylinder(h = 5, r = 4);   //Top Gripper
			translate([0,0,44]) cylinder(h = 3, r = 6);
			//ToDo: Optional Bowden Connector top section
			translate([0,0,-3])cylinder( h = 3, r1 = 0.9, r = 4);
		}
		union()  
		{
			// inside, allowed variance of filliment of +-.05r
			translate([0,0,-3.1])cylinder(h = 3.1, r = 0.1, $fn=100 );
			cylinder(h = 4, r1 = 0.125, r = 0.9, $fn =100);
			translate([0,0,4])cylinder(h = 43.1, r = 0.9, $fn = 100);
			
			// resistor slot for a 12mm x 5.5mm 6.8ohm +-0.02r
			rotate([90,0,0])translate([-7,5,-20])cylinder(h = 40, r = 2.76, $fn=100);
			
			// Thermistor Hole (Epcos#B57560G0145) 2.3mm +-0.2r
			rotate([90,0,0])translate([7,5,-3])cylinder(h = 13, r = 1.25, $fn=100);
		}
		
	}