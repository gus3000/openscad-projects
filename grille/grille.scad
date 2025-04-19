/*
en cm :
height: 22.8
width en haut: 10.5
width en bas: 10.2

épaisseur (ou trou ?) axe y: 1.5
épaisseur (ou trou ?) axe x: 1.3

*/

$fs = 0.01;
$fa = 2;

epaisseur = 1;
hauteur_totale = 228;
largeur_totale = 105;

hauteur = 200;
largeur = 80;

tailleFleur = largeur / 20;
tailleEtoile = tailleFleur * 8/5;
espacement = tailleEtoile * 2.5;

marge_x = (largeur_totale - largeur)/2;
marge_y = (hauteur_totale - hauteur)/2;


module petale(rayon, x, y, decalage = 0.8, superposition = 0.5) {
  intersection() {
    translate([ rayon * decalage, -rayon * superposition, 0 ])
        circle(r = rayon);
    translate([ rayon * decalage, rayon * superposition, 0 ]) circle(r = rayon);
  }
}

module fleur(x, y) {
  for (i = [0:60:359]) {
    rotate([ 0, 0, i ]) petale(tailleFleur/2, x, y);
  }
}

module etoile(x, y) {
  for (i = [0:60:359]) {
    rotate([ 0, 0, i ]) petale(tailleEtoile/2, x, y);
    rotate([ 0, 0, i + 30 ]) petale(tailleEtoile/2 * 0.75, x, y);
  }
}

module motif() {
  for (x = [0:1:5]) {
    for (y = [0:1:15]) {
      translate([ x * espacement, y * espacement, 0 ]) etoile(0, 0);
      translate([ (x+0.5) * espacement, (y+0.5) * espacement, 0]) fleur(0, 0);
    }
  }
}
// color("grey") translate([ 0, 0, -5 ]) fleur(0, 0);


difference() {
  color("white") translate([-marge_x,-marge_y]) cube([largeur_totale, hauteur_totale, epaisseur]);
  translate([0,0,-1]) linear_extrude(5) intersection() {
    square([largeur,hauteur]);
    motif();
  }
}