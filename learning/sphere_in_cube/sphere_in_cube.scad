// to modify

_WhichColor = "All";
cubeSize = 100;
ratio = 3 / 4;

// code

module coloredModule(colorValue) {
  if(_WhichColor == "All" || _WhichColor == colorValue)
  color(colorValue) children();
}

coloredModule("purple")
difference() {
  cube(cubeSize);
//   union() {
//     delta = cubeSize * ((1 - ratio) / 2);
//     translate(v = [ -cubeSize / 2, delta, delta ])
//         cube([ cubeSize * 2, cubeSize * ratio, cubeSize * ratio ]);
//     translate(v = [ delta, -cubeSize / 2, delta ])
//         cube([ cubeSize * ratio, cubeSize * 2, cubeSize * ratio ]);
//     translate(v = [ delta, delta, -cubeSize / 2 ])
//         cube([ cubeSize * ratio, cubeSize * ratio, cubeSize * 2 ]);
//   }
  translate([ cubeSize / 2, cubeSize / 2, cubeSize / 2 ])
  sphere(r = cubeSize * 2/3);
}

coloredModule("orange")
translate(v = [cubeSize/2,cubeSize/2,cubeSize/2])
sphere(r = cubeSize/2);
