/////////////////////////////////////////////////////////////////
//// WeePrusa Y-Axis v 1.0.0
// GNU GPL v3
//
// Maxumx (maxumx2002@yahoo.com)
// Thomas Phillips (tntexplosivesltd@gmail.com)
//
// https://github.com/tntexplosivesltd/WeePrusa
//
// Y - axis carrage base
// Material: ABS, PLA(recomended)
////////////////////////////////////////////////////////////////

include<configuration.scad>

$fn = 32;
// Parameters:

// Top Plate Options
Top_Plate_Thickness = 4;

//Print Table Mounting Holes
Hole_Size = 2.25;
Hole_FromEdge = 5;

// Bearing Holder dimesions

LM6_Clr = 5;  // room top and bottom of the 4 mounts.


//some options
ZipTie = true;
Fingers = false;


// Main Call
color("royalblue")
{
	if (LM6) carriage(19, 12, 25, 16, 15, 6);
	else carriage(25, 16, 30, 22, 15, 8);
}



module BearingHolder (X, Y, Z, bearing_length, bearing_diameter, holder_length, holder_width, holder_height, Rod_Size)
{
	translate([X,Y,Z])
	{
		difference()
		{
			if (!Fingers) translate([0, 0, -4])cube(size = [ holder_length, holder_width, holder_height ], center = true);
			else cube(size = [ holder_length, holder_width, holder_height ], center = true);
			rotate([0,90,0]) translate([-(holder_height*0.25),0,0]) cylinder (h = bearing_length+1, r = (bearing_diameter/2+0.2), center = true );
			rotate([0,90,0]) translate([-(holder_height*0.25),0,0]) cylinder (h = holder_length+0.2, r = (Rod_Size/2+2), center = true );
			
			if (ZipTie)
			{
				translate([0,0,-(holder_height/2-1-0.1)])cube(size =[4,(holder_width+0.1),2], center = true); 		//ziptie tube
			}
			if (Fingers)
			{
				translate([(holder_length*0.33),0,(holder_height/2-(holder_height/4-0.1))])
					cube(size =[4,(holder_width+0.1),(holder_height/2)], center = true); 		//side finger one
				translate([-(holder_length*0.33),0,(holder_height/2-(holder_height/4-0.1))])
					cube(size =[4,(holder_width+0.1),(holder_height/2)], center = true); 		//side finger two
				translate([0,0,(holder_height/2-(holder_height/4-0.1))])
					cube(size =[4,(holder_width+0.1),(holder_height/2)], center = true); 		//Middle finger
			}
		}
	}
}

module BedHoles()
{
	for (i = [ [ (Top_Plate_Size/2-Hole_FromEdge),(Top_Plate_Size/2-Hole_FromEdge),0],
			  [ -(Top_Plate_Size/2-Hole_FromEdge),(Top_Plate_Size/2-Hole_FromEdge), 0],
			  [ (Top_Plate_Size/2-Hole_FromEdge),-(Top_Plate_Size/2-Hole_FromEdge), 0],
			  [ -(Top_Plate_Size/2-Hole_FromEdge),-(Top_Plate_Size/2-Hole_FromEdge), 0] ])
	{
	  	translate(i)
		cylinder(h = Top_Plate_Thickness+0.2, r = Hole_Size/2, center = true, $fn = 100);
	}
}

module BeltHoles()
{
	for (i = [ [ (Top_Plate_Size/2-5-(Hole_Size/2)),5.5,0],
			  [ -(Top_Plate_Size/2-5-(Hole_Size/2)),5.5,0],
			  [ (Top_Plate_Size/2-5-(Hole_Size/2)),-5.5,0],
			  [ -(Top_Plate_Size/2-5-(Hole_Size/2)),-5.5,0] ])
	{
	  	translate(i)
		cylinder(h = Top_Plate_Thickness+0.2, r = Hole_Size/2, center = true, $fn = 100);
	}
}

module carriage(b_length, b_dia, h_length, h_width, h_height, rod)
{
	union()
	{
		difference()
		{
			cube(size = [Top_Plate_Size, Top_Plate_Size, Top_Plate_Thickness], center = true); 			//top plate
			BedHoles();
			BeltHoles();
		}
		if(LM6)
		{
			BearingHolder((Top_Plate_Size/2-h_length/2-LM6_Clr),rail_width,(Top_Plate_Thickness/2+(h_height/2)), b_length, b_dia, h_length, h_width, h_height, rod);
			BearingHolder((-Top_Plate_Size/2+h_length/2+LM6_Clr),rail_width,(Top_Plate_Thickness/2+(h_height/2)), b_length, b_dia, h_length, h_width, h_height, rod);
			BearingHolder(0,-rail_width,(Top_Plate_Thickness/2+(h_height/2)), b_length, b_dia, h_length, h_width, h_height, rod);
		}
		
		else 
		{
			BearingHolder(0,rail_width,(Top_Plate_Thickness/2+(h_height/2)), b_length, b_dia, h_length, h_width, h_height, rod);
			BearingHolder(0,-rail_width,(Top_Plate_Thickness/2+(h_height/2)), b_length, b_dia, h_length, h_width, h_height, rod);
		}
	}
}


//spell check difference, cylinder, cube, translate, rotate, union
