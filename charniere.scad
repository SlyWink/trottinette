include <structure.scad>;
include <pince.scad>;

epai_charniere=4; espa_charniere=5; prof_carre=4;

module Charniere(carre=false) {
  difference() {
    hull() union() {
      cube([prof_encoche,larg_charniere,haut_pince],center=true);
      translate([(diam0_tuyau+epai_charniere+prof_encoche)/2+espa_charniere,0,0])
        rotate([90,0,0]) cylinder(h=larg_charniere,r=diam0_tuyau/2+epai_charniere,center=true,$fn=40);
    }
    translate([(diam0_tuyau+epai_charniere+prof_encoche)/2+espa_charniere,0,0])
      rotate([90,0,0]) cylinder(h=larg_charniere+0.2,r=diam0_tuyau/2,center=true,$fn=40);
    rotate([90,0,0]) cylinder(r=diam_vis/2,h=larg_charniere+0.2,center=true,$fn=16);
    if (carre)
      translate([0,(larg_charniere-prof_carre)/2+0.1,0] )
        rotate([90,0,0]) cube([diam_vis,diam_vis,prof_carre],center=true);   
  }
}