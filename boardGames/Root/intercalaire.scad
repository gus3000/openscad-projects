width = 5;
text_width = 2;

box_width = 292; // on divise par 2, l'imprimante est trop petite
space_left = 141;
height = 38;

part = 4;

module cale() {
  translate([ box_width, 0, 0 ]) rotate([ 0, 0, 90 ]) difference() {
    cube([ height, box_width, height ]);
    translate([ height, -1, 0 ]) rotate([ 0, -45, 0 ]) translate([ 0, 0, -2 ])
        cube([ height, box_width + 2, 60 ]);
  }
}

difference() {
  difference() {
    color("red") union() {
      cube([ box_width, space_left, width ]);
      cube([ box_width, width, height ]);
      translate([ 0, width, 0 ]) cale();
    }

    translate([ box_width / 2, space_left / 2 + 15, width - text_width ])
        linear_extrude(height = text_width + 1)
            import("root_logo.svg", center = true);
  }
  translate([(box_width/2) * (part-1),0,0]) 
  cube([box_width/2,space_left,height]);
}

// X = 292
// Y = 38
// Z = 141
