$fn=150;
_build_middle=false;
_build_base=false;
_build_container=false;

module pieSlice(a, r, h){
  // a:angle, r:radius, h:height
  $fn=100;
  rotate_extrude(angle=a) square([r,h]);
}

module container(inner_d=100, outer_d=110, h1=40, h2=70, thick=5) {

  module tube_shape() {
    linear_extrude(h2) 
      difference() {
        circle(d=outer_d);
        circle(d=inner_d);
      }
  }

  module bottom_lip(){
    linear_extrude(thick) 
      difference() {
        circle(d=outer_d);
        circle(d=inner_d-(thick*2));
      }
  }

  module main_shape() {
    difference() {
      union() {
        tube_shape();
        bottom_lip();
      }
      translate([-80,0,h1]) cube([150,90,1000]);
    }
  }

  main_shape();
}

// thick : how thick to make walls, floors, and ceilings
// d : diameter of base
module middle(d=100, wall_height=30.5, thick=5, hole_size=4) {
  union() {
    translate([5,-10,-thick]) rotate([0,0,-45]) linear_extrude(thick) square([(d-d/5),10] ); // handle
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

      translate([0,0,-thick ]) rotate([0,0,90]) translate([thick/2,thick/2,0]) pieSlice(90, d, 40);
      //  translate([-30,30,10]) rotate([0,0,90]) cube(50,true);
    }
  }
}

module base(d=100, wall_height=20, thick=5, hole_size=4) {
  difference() {
    union() {
      linear_extrude(thick) circle(d=d);
      linear_extrude(thick*2) circle(r=hole_size);
    }
    translate([0,0,-thick]) rotate([0,0,90]) translate([thick/2,thick/2,0]) pieSlice(90, d, 40);
  }
}

if (_build_container) { container(); }
if (_build_base) { base(thick=5); }
if (_build_middle) {middle(d=95, thick=5);}

