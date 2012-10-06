/////////////////////////////////////////////////////////////////
// WeePrusa Y-Carriage v 1.0.0
// GNU GPL v3
//
// Xander Brown aka. Maxumx (maxumx2002@yahoo.com)
// Thomas Phillips (tntexplosivesltd@gmail.com)
//
// https://github.com/tntexplosivesltd/WeePrusa
//
// Material: Almumium Billet Bracket
//			ABS Or PLA Bearing holders.
//
//Ends: made for a pressfit on the smooth rods, smooth rods may need chilled before insertion.
// 		a set screw may be added on the top and bottom. if press fit is not enough.
//
//To do: add holes in 'ends' to allow for eayer access to pully set screws. 
////////////////////////////////////////////////////////////////

//Includes & Useings

include <Configuration.scad>
use <utils.scad>
use <nema8.scad>

// Peramiters
	
//Bearing Options.
	ZipTies = true;			// Set to false to remove ziptie holes
	Fingers = true;			// set to false to remove fingers from the bearing mountings.
	
//Misc Options.
	$fn=64;	

x_asm();

module x_asm()
{
	color("Pink")Carriage(2);
	color("Gray")HotEndBracket(2);
	color("skyblue")SmoothRod(0,90,0,  -1.5,-11.5,0, smooth_diameter);
	color("skyblue")SmoothRod(0,90,0,  -28.5,-11.5,0, smooth_diameter);
	translate([100,-11.5,3])Motor_End(smooth_diameter,4);
	translate([-100,-11.5,3])Idle_End(smooth_diameter,4);
}

module HotEndBracket(ScrewSize)
{		
	difference()
	{
		cube(size = [20,22,30]);
		translate([-0.5,3,7]) cube(size=[21,31,18]);
		translate([10,12,24.9])cylinder(h = 5.2, r = 4);	
		translate([10,12,-0.5])cylinder(h = 8, r = 6);
		translate([-0.5,11.75,-0.1,])cube(size = [21,0.5,30.2]);
		
		//Wire Guide Hole
		translate([2.25,5,-0.05])cylinder(h = 30.1, r = 1.5);

		//Screw Holes Clamps
		rotate([-90,0,0]) translate([2.25,-3.5,-0.05])cylinder(h = 22.1, r = ScrewSize/2);
		rotate([-90,0,0]) translate([2.25,-27.5,-0.05])cylinder(h = 22.1, r = ScrewSize/2);
		rotate([-90,0,0]) translate([17.75,-3.5,-0.05])cylinder(h = 22.1, r = ScrewSize/2);
		rotate([-90,0,0]) translate([17.75,-27.5,-0.05])cylinder(h = 22.1, r = ScrewSize/2);

		//Screw Holes Mounting to Carriage
		rotate([-90,0,0]) translate([17.75,-15.5,-0.05])cylinder(h = 3.1, r = ScrewSize/2);
		rotate([-90,0,0]) translate([2.75,-15.5,-0.05])cylinder(h = 3.1, r = ScrewSize/2);

		//Fan Mounting holes.( place holer code.)
		//rotate([0,90,0]) translate([0,0,0])cylinder(h = 22.1, r = ScrewSize/2);
		//rotate([0,90,0]) translate([0,0,0])cylinder(h = 22.1, r = ScrewSize/2);
		//rotate([0,90,0]) translate([0,0,0])cylinder(h = 22.1, r = ScrewSize/2);
			
	}
}


module BearringHolder(Bearing_H, Bearing_R, Holder_L, Holder_H, Holder_W, Rod)
{
	difference()
	{
		union(){
		cube(size = [Holder_L ,Holder_H, Holder_W], center = true);
		}

		#translate([0,((Holder_H/2)-0.5),0])cylinder(h = Bearing_H, r = Bearing_R/2, center = true);
		translate([0,((Holder_H/2)-0.5),0])cylinder(h = Holder_W+0.1, r = Rod/2+0.5, center = true);
		
		if(Fingers)
		{
			translate([0,Holder_H/4+.01,0])cube(size = [Holder_L+.5,Holder_H/2,3], center = true);
			translate([0,Holder_H/4+.01,Holder_W*0.33])cube(size = [Holder_L+.5,Holder_H/2,3], center = true);
			translate([0,Holder_H/4+.01,-Holder_W*0.33])cube(size = [Holder_L+.5,Holder_H/2,3], center = true);
		}

		if(ZipTies)
		{
			translate([0,-Holder_H/2+.01,0])cube(size = [Holder_L+.5,3,3], center = true);
		}
	}
}

module Carriage(ScrewSize)
{
	union()
	{	
			difference() // belt mounts.
			{
				union() {
					translate([1.5,-25.5,10.5])cube(size = [7,7,2], center = true);
					translate([18.5,-25.5,10.5])cube(size = [7,7,2], center = true);
					translate([1.5,-25.5,19.5])cube(size = [7,7,2], center = true);
					translate([18.5,-25.5,19.5])cube(size = [7,7,2], center = true);
					
					translate([10,-16,15])cube(size = [10,26,11], center = true);
				}
					translate([1.5,-25.5,10.5])cylinder(h=2.1, r = 1.5, center = true);
					translate([18.5,-25.5,10.5])cylinder(h=2.1, r = 1.5, center = true);
					translate([1.5,-25.5,19.5])cylinder(h=2.1, r = 1.5, center = true);
					translate([18.5,-25.5,19.5])cylinder(h=2.1, r = 1.5, center = true);	
				
			}

			// connector plate
			difference()
			{
				translate([-1.5,-3,-6.5])cube(size = [23,3,43]);
				
				//Screw Holes
				rotate([-90,0,0]) translate([17.75,-15.5,-3.05])cylinder(h = 3.1, r = ScrewSize/2);
				rotate([-90,0,0]) translate([2.75,-15.5,-3.05])cylinder(h = 3.1, r = ScrewSize/2);
				
			}

			if (LM6)
			{
				rotate([180,-90,0])translate([1.5,7.5,10])BearringHolder(19,12,16,9,23,6);
				rotate([180,90,0])translate([-28.5,7.5,-10])BearringHolder(19,12,16,9,23,6);
			}
			else 
			{
				BearringHolder(25,16,22,11,29,8);
			}
	}
}

module SmoothRod(rot_x, rot_y, rot_z, x, y, z, smooth_diameter)
{
	rotate([rot_x,rot_y,rot_z])translate([x,y,z])cylinder(h = 200, r = smooth_diameter/2, center = true);

}
module GT2Pully()
{
	//40mm 20tooth 2mm pitch
	color("lightblue")difference(){
		union()
		{
			cylinder(h = 6, r = 7.5, center = true);
			translate([0,0,3])cylinder(h = 1, r = 12, center = true );
			translate([0,0,6])cylinder(h = 6, r = 10, center = true );
			translate([0,0,9.5])cylinder(h = 1, r = 12, center = true );
		}
		cylinder(h = 20.01, r = 2.5, center = true);
	}
	
}
module Motor_End(smooth_diameter, nema8_torque)
{
	color("pink")difference()
	{
		union()
		{
			hull()
				{
					rotate([0,90,0])cylinder(h = 40, r = 8, center = true);
					rotate([0,90,0])translate([-24,0,0])cylinder(h = 40, r = 8, center = true);
				}
			rotate([0,0,-90])translate([0,24.5,12])BearringHolder(19,12,16,9,23,6);
		}
		
		translate([10,0,12])cylinder(h = 45, r = 3, center = true);
		rotate([0,90,0])translate([1.5,0,0])cylinder(h = 41, r = 3, center = true);
		rotate([0,90,0])translate([-25.5,0,0])cylinder(h = 41, r = 3, center = true);
		translate([10,0,4])cube(size = [10,16.5,6.25], center = true);
		translate([10,0,20])cube(size = [10,16.5,6.25], center = true);
		translate([-8,9.0,12])cube(size = [20.5,14.1,20.5], center = true);
		translate([-8,-4.0,12])cube(size = [20.5,8.1,20.5], center = true);
		rotate([90,0,0])translate([-8,12,3])cylinder(h = 10.1, r = 2.5, center = true);

		rotate([90,0,0])translate([-15.7,19.7,3])cylinder(h = 10.1, r = 1, center = true);
		rotate([90,0,0])translate([-0.3,19.7,3])cylinder(h = 10.1, r = 1, center = true);
		rotate([90,0,0])translate([-15.7,4.3,3])cylinder(h = 10.1, r = 1, center = true);
		rotate([90,0,0])translate([-0.3,4.3,3])cylinder(h = 10.1, r = 1, center = true);
		
	}
	translate([-18.15,3,1.85])nema8(4);
	rotate([90,0,0])translate([-8,12,6.25])GT2Pully();
}

module Idle_End(smooth_diameter, nema8_torque)
{
	color("pink")difference()
	{
		union()
		{
			hull()
				{
					rotate([0,90,0])cylinder(h = 40, r = 8, center = true);
					rotate([0,90,0])translate([-24,0,0])cylinder(h = 40, r = 8, center = true);
				}
			rotate([0,0,90])translate([0,24.5,12])BearringHolder(19,12,16,9,23,6);
		}
		
		translate([-10,0,12])cylinder(h = 45, r = 3, center = true);
		rotate([0,90,0])translate([1.5,0,0])cylinder(h = 41, r = 3, center = true);
		rotate([0,90,0])translate([-25.5,0,0])cylinder(h = 41, r = 3, center = true);
		translate([-10,0,4])cube(size = [10,16.5,6.25], center = true);
		translate([-10,0,20])cube(size = [10,16.5,6.25], center = true);

		rotate([90,0,0])translate([8,12,0])cylinder(h = 20, r = 2.5, center = true);
		#rotate([90,0,0])translate([8,12,2.01])cylinder(h = 6, r = 7.6 );
		

		
	}
	rotate([90,0,0])translate([8,12,6.25])GT2Pully();
}




