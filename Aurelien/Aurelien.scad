DIAMETRE = 5;
HAUTEUR = 7;

text_size = 25;
t = "Aurélien";
font="Roboto Condensed:style=Bold";
spacing=.95;
fat = 2;

$fs = 0.01;
$fa = 2;

// translate([0,0,fat]) linear_extrude(8) {
// 	text(t, text_size, font=font, spacing=spacing);
// }

color("darkslategray") {
	linear_extrude(fat) {
		offset(4) {
			fill() {
				text(t, text_size, font=font, spacing=spacing);
			}
		}
	};

	translate([0,0,-HAUTEUR]) {
		cylinder(h =HAUTEUR,r =DIAMETRE/2);
		translate([144,0,0]) cylinder(h =HAUTEUR,r =DIAMETRE/2);
		translate([77,24,0]) cylinder(h =HAUTEUR,r =DIAMETRE/2);
	}
}