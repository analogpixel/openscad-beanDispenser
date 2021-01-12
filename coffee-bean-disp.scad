$fn=50;
_build_middle=false;

// thick : how thick to make walls, floors, and ceilings
// d : diameter of base
module middle(d=100, wall_height=20, thick=10, hole_size=4) {

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
}


if (_build_middle) {middle();}
