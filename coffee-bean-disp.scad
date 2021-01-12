$fn=50;
_build_middle=true;

module pieSlice(a, r, h){
  // a:angle, r:radius, h:height
  $fn=100;
  rotate_extrude(angle=a) square([r,h]);
}

// thick : how thick to make walls, floors, and ceilings
// d : diameter of base
module middle(d=100, wall_height=20, thick=10, hole_size=4) {



  difference() {
    difference() {
      union() {
        translate([0,0,-thick]) linear_extrude(thick) circle(d=d);
        linear_extrude(wall_height) {
          difference() {
            union() {
              circle(d=30);
              translate([0,d/2]) square([thick,d], center=true);
              rotate([0,0,90]) translate([0,d/2]) square([thick,d], center=true);
            }

            // use this to subtract the edges
            difference() {
              circle(d=d*4);
              circle(d=d);
            }
          }
        }
      }
      translate([0,0,-50]) cylinder(100, r=hole_size, true);
    }

    translate([0,0,-thick]) rotate([0,0,90]) translate([thick/2,thick/2,0]) pieSlice(90, d, 40);
  }
}

if (_build_middle) {middle(d=95);}
