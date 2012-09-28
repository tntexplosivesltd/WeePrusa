/////////////////////////////////////////////////////////////////
//// WeePrusa Y-Axis v 1.0.0
// GNU GPL v3
//
// Maxumx (maxumx2002@yahoo.com)
//
// Y - axis carrage base
//
// Material: ABS, PLA(recomended)
////////////////////////////////////////////////////////////////

// Peramiters:

// Top Plate Options
Top_Plate_Size = 60;
Top_Plate_Thikness = 4;

//Print Table Mounting Holes
Hole_Size = 2.25;
Hole_FromEdge = 12;

// Barring Holder dimetions
LM8_Lingth = 25;
LM8_Diamiter = 16;
LM8_Holder_Lingth = 30;
LM8_Holder_Hieght = 15;
LM8_Holder_Width =  22;
LM8_Holder_X = 18; //distance from center

// Rod size
Rod_Size = 8; 

//some options
ZipTie = true;
Fingers = true;

module BarringHolder (X, Y, Z)
	{
		translate([X,Y,Z])
		{
			difference()
			{
				cube(size = [ LM8_Holder_Lingth , LM8_Holder_Width , LM8_Holder_Hieght ], center = true);
				rotate([0,90,0]) translate([-(LM8_Holder_Hieght*0.25),0,0]) cylinder (h = LM8_Lingth, r = (LM8_Diamiter/2), center = true );
				rotate([0,90,0]) translate([-(LM8_Holder_Hieght*0.25),0,0]) cylinder (h = LM8_Holder_Lingth+0.2, r = (Rod_Size/2+2), center = true );
				
				if (ZipTie)
				{
					translate([(LM8_Holder_Lingth*0.33),0,-(LM8_Holder_Hieght/2-1)])cube(size =[4,(LM8_Holder_Width+0.1),2], center = true); //ziptie tubes
					translate([-(LM8_Holder_Lingth*0.33),0,-(LM8_Holder_Hieght/2-1)])cube(size =[4,(LM8_Holder_Width+0.1),2], center = true); //ziptie tubes
				}
				if (Fingers)
				{
					translate([(LM8_Holder_Lingth*0.33),0,(LM8_Holder_Hieght/2-(LM8_Holder_Hieght/4-0.1))])
							cube(size =[4,(LM8_Holder_Width+0.1),(LM8_Holder_Hieght/2)], center = true); //side finger one
					translate([-(LM8_Holder_Lingth*0.33),0,(LM8_Holder_Hieght/2-(LM8_Holder_Hieght/4-0.1))])
							cube(size =[4,(LM8_Holder_Width+0.1),(LM8_Holder_Hieght/2)], center = true); //side finger two
					translate([0,0,(LM8_Holder_Hieght/2-(LM8_Holder_Hieght/4-0.1))])
							cube(size =[4,(LM8_Holder_Width+0.1),(LM8_Holder_Hieght/2)], center = true); //Middle finger
				}
			}
		}
	
	}

module HolePunch()
	{
		for (i = [ [ (Top_Plate_Size/2-Hole_FromEdge),(Top_Plate_Size/2-Hole_FromEdge),0],
				  [ -(Top_Plate_Size/2-Hole_FromEdge),(Top_Plate_Size/2-Hole_FromEdge), 0],
				  [ (Top_Plate_Size/2-Hole_FromEdge),-(Top_Plate_Size/2-Hole_FromEdge), 0],
				  [ -(Top_Plate_Size/2-Hole_FromEdge),-(Top_Plate_Size/2-Hole_FromEdge), 0] ])
			{
  		  	translate(i)
			cylinder(h = Top_Plate_Thikness+0.2, r = Hole_Size/2, center = true, $fn = 100);
			}
	}

union()
	{
		difference()
		{
			cube(size = [Top_Plate_Size ,Top_Plate_Size,Top_Plate_Thikness], center = true); //top plate
			#HolePunch();
		}
		BarringHolder(0,LM8_Holder_X,(Top_Plate_Thikness/2+(LM8_Holder_Hieght/2)));
		BarringHolder(0,-LM8_Holder_X,(Top_Plate_Thikness/2+(LM8_Holder_Hieght/2)));
	}


//spell check difference, cylinder, cube, translate, rotate, union
