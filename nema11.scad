// WeePrusa
// Stepper Motors
// GNU GPL v3
// Thomas Phillips (tntexplosivesltd@gmail.com)
// https://github.com/tntexplosivesltd/WeePrusa

include <motor.scad>
$fn = 32;

// Motor back
nema_width = 28.2;

// Shaft
nema_shaft = 20;
nema_shaft_radius = 2.5;
nema_keyway = 15;
nema_hub_radius = 11;
nema_hub_width = 2;

// Screws
nema_screw_size = 2.5;
nema_screw_depth = 2.5;
nema_screw_separation = 23;

function get_length(t) = lookup(t, [
			[4.3, 31.5],
			[6, 31.5],
			[7.5, 44.5],
			[9, 50.5],
			[9.5, 44.5],
			[12, 50.5],
	]);

module nema11(torque)
{
	length = get_length(torque);
	motor(length);
}