// WeePrusa
// Stepper Motors
// GNU GPL v3
// Thomas Phillips (tntexplosivesltd@gmail.com)
// https://github.com/tntexplosivesltd/WeePrusa

include <motor.scad>
$fn = 32;

// Motor back
nema_width = 35.2;

// Shaft
nema_shaft = 24;
nema_shaft_radius = 2.5;
nema_keyway = 15;
nema_hub_radius = 11;
nema_hub_width = 2;

// Screws
nema_screw_size = 3;
nema_screw_depth = 4.5;
nema_screw_separation = 26;

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

module nema14(torque)
{
	length = get_length(torque);
	motor(length);
}