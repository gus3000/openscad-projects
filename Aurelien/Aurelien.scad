
t = "Aurélien";

linear_extrude(15) {
	text(t, 50, font="Roboto Condensed:style=Bold");
}
color("darkslategray") {
	linear_extrude(2) {
		offset(4) {
			fill() {
				text(t, 50, font="Roboto Condensed:style=Bold");
			}
		}
	}
}