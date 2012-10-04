// WeePrusa
// Stepper Motors
// GNU GPL v3
// Thomas Phillips (tntexplosivesltd@gmail.com)
// https://github.com/tntexplosivesltd/WeePrusa

include <motor.scad>
$fn = 32;

// Motor back
nema_width = 20.3;

// Shaft
nema_shaft = 10;
nema_shaft_radius = 2;
nema_keyway = 7;
nema_hub_radius = 8;
nema_hub_width = 1.5;

// Screws
nema_screw_size = 2;
nema_screw_depth = 2.5;
nema_screw_separation = 15.4;

function get_length(t) = lookup(t, [
			[1.6, 28],
			[1.8, 30],
			[2, 33],
			[3, 38],
			[4, 38],
	]);


module nema8(torque)
{
	length = get_length(torque);
	motor(length);
}