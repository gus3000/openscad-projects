//mm
HAUTEUR_INTERIEURE = 18;
LARGEUR = 50;
EPAISSEUR_TAQUET = 4;

// module stolen from https://www.reddit.com/r/openscad/comments/vmn3az/comment/ie2xzsg
module RoundedCube(size = [1, 1, 1], center = false, radius = 0.5, fn = 10) {

  obj_translate =
    (center == true) ?
      [0, 0, 0]
    : [
      (size[0] / 2),
      (size[1] / 2),
      (size[2] / 2),
    ];

  //echo (obj_translate);
  translate(v=obj_translate) {
    hull() {
      cube([size[0] - radius - radius, size[1] - radius - radius, size[2]], center=true);
      cube([size[0] - radius - radius, size[1], size[2] - radius - radius], center=true);
      cube([size[0], size[1] - radius - radius, size[2] - radius - radius], center=true);

      translate([size[0] / 2 - radius, size[1] / 2 - radius, size[2] / 2 - radius])
        sphere(r=radius, $fn=fn);
      translate([-size[0] / 2 + radius, size[1] / 2 - radius, size[2] / 2 - radius])
        sphere(r=radius, $fn=fn);
      translate([-size[0] / 2 + radius, -size[1] / 2 + radius, size[2] / 2 - radius])
        sphere(r=radius, $fn=fn);
      translate([size[0] / 2 - radius, -size[1] / 2 + radius, size[2] / 2 - radius])
        sphere(r=radius, $fn=fn);

      translate([size[0] / 2 - radius, size[1] / 2 - radius, -size[2] / 2 + radius])
        sphere(r=radius, $fn=fn);
      translate([-size[0] / 2 + radius, size[1] / 2 - radius, -size[2] / 2 + radius])
        sphere(r=radius, $fn=fn);
      translate([-size[0] / 2 + radius, -size[1] / 2 + radius, -size[2] / 2 + radius])
        sphere(r=radius, $fn=fn);
      translate([size[0] / 2 - radius, -size[1] / 2 + radius, -size[2] / 2 + radius])
        sphere(r=radius, $fn=fn);
    }
  }
}

module coin(largeur) {
  polygon(
    points=[
      [0, 0],
      [largeur, 0],
      [0, largeur],
    ], paths=[
      [0, 1, 2],
    ]
  );
}

intersection() {
  difference() {
    translate(v=[0, 0, -EPAISSEUR_TAQUET])
      RoundedCube(size=[LARGEUR, LARGEUR, HAUTEUR_INTERIEURE + EPAISSEUR_TAQUET * 2], radius=5, fn=100);

    translate(v=[EPAISSEUR_TAQUET, EPAISSEUR_TAQUET, 0])
      linear_extrude(height=HAUTEUR_INTERIEURE) {
        color("white") coin(LARGEUR * 2);
      }
  }

  translate(v=[0, 0, -10])
    linear_extrude(height=HAUTEUR_INTERIEURE * 2)
      coin(LARGEUR+EPAISSEUR_TAQUET);
}
