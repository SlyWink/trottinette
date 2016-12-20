include <structure.scad>;
include <pince.scad>;

//epai_charniere=4;
espa_charniere=5; prof_carre=4;
diam_teton=30; long0_teton=40; long1_teton=long0_teton-diam_teton/2;

module Teton(carre=false) {
  difference() {
    union() {
      hull() {
        cube([prof_encoche,larg_charniere,haut_pince],center=true);
        translate([(diam_teton+prof_encoche)/2+espa_charniere,0,0])
          rotate([90,0,0]) cylinder(h=larg_charniere,r=diam_teton/2,center=true,$fn=40);
      }
      translate([(diam_teton+prof_encoche)/2+espa_charniere,(long1_teton+larg_charniere)/2-0.1,0]) {
        rotate([90,0,0]) cylinder(h=long1_teton,r=diam_teton/2,center=true,$fn=40);
        translate([0,long1_teton/2,0]) rotate([90,0,0]) sphere(r=diam_teton/2,center=true,$fn=40);
      }
    }
    rotate([90,0,0]) cylinder(r=diam_vis/2,h=larg_charniere+0.2,center=true,$fn=16);
    if (carre)
      translate([0,(larg_charniere-prof_carre)/2+0.1,0] )
        rotate([90,0,0]) cube([diam_vis,diam_vis,prof_carre],center=true);   
  }
}

Teton(true);