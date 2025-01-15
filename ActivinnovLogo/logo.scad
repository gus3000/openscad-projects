
module regular_polygon(sides, radius)
{
  function dia(r) = sqrt(pow(r*2,2)/2);  //sqrt((r*2^2)/2) if only we had an exponention op
  if(sides<2) square([radius,0]);
  if(sides==3) triangle(radius);
  if(sides==4) square([dia(radius),dia(radius)],center=true);
  if(sides>4) {
    angles=[ for (i = [0:sides-1]) i*(360/sides) ];
    coords=[ for (th=angles) [radius*cos(th), radius*sin(th)] ];
    polygon(coords);
  }
}

module pentagon(radius)
{
  regular_polygon(5,radius);
}

module logo_pentagon(radius)
{
minkowski() {
linear_extrude(1)
pentagon(10);
cylinder(r=2,h=1);
}
}

$fn=50;
color("#55aac7") rotate(-15) logo_pentagon(5);
color("#007eb0") translate([0,0,2]) logo_pentagon(5);