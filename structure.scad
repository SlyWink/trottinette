include <commun.scad>;

diam0_tuyau=16+0.2;

tron_coude=22; retr_coude=diam0_tuyau/2+1;
long_coude=tron_coude+retr_coude*2; epai_coude=1;

long0_cadre=300; long1_cadre=long0_cadre-retr_coude*4;
larg0_cadre=200; larg1_cadre=larg0_cadre-retr_coude*4;
epai_cadre=1;


module Tuyau_Ep1(p_long,p_dext) {
  Tuyau(p_long,p_dext,1);
}


module Coude(p_dint) {
  union() {
    color("LightGray") translate([retr_coude,retr_coude,0])
      rotate_extrude(angle=90) translate([-retr_coude,0,0]) difference() {
        circle(r=p_dint/2+1);
        circle(r=p_dint/2);
      }
    translate([0,tron_coude/2+retr_coude-0.1,0])
      rotate([-90,0,0]) Tuyau_Ep1(tron_coude,p_dint+epai_coude*2);
    translate([tron_coude/2+retr_coude-0.1,0,0])
      rotate([0,90,0]) Tuyau_Ep1(tron_coude,p_dint+epai_coude*2);
    }
}


module _Structure() {
  translate([-larg0_cadre/2+retr_coude,-long0_cadre/2+retr_coude,0]) union() {
    Coude(diam0_tuyau);
    translate([0,long1_cadre/2+retr_coude,0]) rotate([90,0,0]) Tuyau_Ep1(long1_cadre,diam0_tuyau);
    translate([0,long1_cadre+retr_coude*2,0]) rotate([0,0,-90]) Coude(diam0_tuyau);
  }
}


module Structure() {
  union() {
    _Structure();
    mirror([1,0,0]) _Structure();
    translate([0,-long0_cadre/2+retr_coude,0]) rotate([0,90,0]) Tuyau_Ep1(larg1_cadre,diam0_tuyau);
    translate([0,long0_cadre/2-retr_coude,0]) rotate([0,90,0]) Tuyau_Ep1(larg1_cadre,diam0_tuyau);
  }
}