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
Top_Plate_Size = 60;		//70mm bed needed for lm6uu
Top_Plate_Thikness = 5;

//Print Table Mounting Holes
Hole_Size = 2.25;
Hole_FromEdge = 6.125;

// Barring Holder dimetions
LM6 = false;     // change to true for LM6UU bearings You will still need to change the dimetions below to mach lm6uu not lm8uu
LM6_Clr = 8;  // room top and bottom of the 4 mounts.

LM8_Lingth = 25;			//lm6uu = 19mm
LM8_Diamiter = 16;			//lm6uu = 12mm
LM8_Holder_Lingth = 30;	//lm6uu = 25mm
LM8_Holder_Hieght = 15;	//lm6uu = no change
LM8_Holder_Width =  22;	//lm6uu = 16mm
LM8_Holder_X = 18; //distance from center

// Rod size
Rod_Size = 8; 

//some options
ZipTie = true;
Fingers =true;

module BarringHolder (X, Y, Z)
	{
		translate([X,Y,Z])
		{
			difference()
			{
				if (!Fingers) translate([0, 0, -4])cube(size = [ LM8_Holder_Lingth , LM8_Holder_Width , LM8_Holder_Hieght ], center = true);
				else cube(size = [ LM8_Holder_Lingth , LM8_Holder_Width , LM8_Holder_Hieght ], center = true);
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

module BeltHoles()
	{
		for (i = [ [ (Top_Plate_Size/2-5-(Hole_Size/2)),5.5,0],
				   [ -(Top_Plate_Size/2-5-(Hole_Size/2)),5.5,0],
				   [ (Top_Plate_Size/2-5-(Hole_Size/2)),-5.5,0],
				   [ -(Top_Plate_Size/2-5-(Hole_Size/2)),-5.5,0] ])
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
			HolePunch();
			BeltHoles();
		}
		if(LM6)
		{
			BarringHolder((Top_Plate_Size/2-LM8_Holder_Lingth/2-LM6_Clr),LM8_Holder_X,(Top_Plate_Thikness/2+(LM8_Holder_Hieght/2)));
			BarringHolder((-Top_Plate_Size/2+LM8_Holder_Lingth/2+LM6_Clr),LM8_Holder_X,(Top_Plate_Thikness/2+(LM8_Holder_Hieght/2)));
			BarringHolder((Top_Plate_Size/2-LM8_Holder_Lingth/2-LM6_Clr),-LM8_Holder_X,(Top_Plate_Thikness/2+(LM8_Holder_Hieght/2)));
			BarringHolder((-Top_Plate_Size/2+LM8_Holder_Lingth/2+LM6_Clr),-LM8_Holder_X,(Top_Plate_Thikness/2+(LM8_Holder_Hieght/2)));
		}
		
		else 
		{
			BarringHolder(0,LM8_Holder_X,(Top_Plate_Thikness/2+(LM8_Holder_Hieght/2)));
			BarringHolder(0,-LM8_Holder_X,(Top_Plate_Thikness/2+(LM8_Holder_Hieght/2)));
		}
	}


//spell check difference, cylinder, cube, translate, rotate, union
