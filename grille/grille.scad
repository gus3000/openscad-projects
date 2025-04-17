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

tailleFleur = 5;
tailleEtoile = 8;
espacement = 40;

module petale(rayon, x, y, decalage = 0.8, superposition = 0.5) {
  intersection() {
    translate([ rayon * decalage, -rayon * superposition, 0 ])
        circle(r = rayon);
    translate([ rayon * decalage, rayon * superposition, 0 ]) circle(r = rayon);
  }
}

module fleur(x, y) {
  for (i = [0:60:359]) {
    rotate([ 0, 0, i ]) petale(tailleFleur, x, y);
  }
}

module etoile(x, y) {
  for (i = [0:60:359]) {
    rotate([ 0, 0, i ]) petale(tailleEtoile, x, y);
    rotate([ 0, 0, i + 30 ]) petale(tailleEtoile * 0.75, x, y);
  }
}

for (x = [0:1:5]) {
  for (y = [0:1:5]) {
    translate([ x * espacement, y * espacement, 0 ]) etoile(0, 0);
    translate([ (x+0.5) * espacement, (y+0.5) * espacement, 0]) fleur(0, 0);
  }
}
// color("grey") translate([ 0, 0, -5 ]) fleur(0, 0);