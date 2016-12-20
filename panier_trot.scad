include <structure.scad>;
include <pince.scad>;
include <charniere.scad>;

module Visu() {
  color("Blue") Pince();
  color("Red") {
    translate([diam_guidon/2+retr_guidon+prof_encoche/2,-ecar_charniere/2-larg_charniere/2,0]) Charniere();
    translate([diam_guidon/2+retr_guidon+prof_encoche/2,ecar_charniere/2+larg_charniere/2,0]) Charniere(true);
  }
  translate([larg0_cadre/2+diam_guidon/2+retr_guidon+prof_encoche+espa_charniere+1,0,0]) Structure();
}


module Imprime() {
//  translate([0,0,haut_pince/2]) Pince();
  translate([0,0,larg_charniere/2]) {
    translate([-15,0,0]) rotate([90,0,90]) Charniere();
    translate([15,15,0]) rotate([90,0,-90]) Charniere(true);
  }
}
//translate([0,45,0]) 
Visu();
//Imprime();

// ATTENTION AU PARAMETRE POUR CHARNIERE
echo(ecar_charniere+2*larg_charniere);