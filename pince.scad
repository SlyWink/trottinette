include <commun.scad>;

ecart_vis=100;

diam_arrondi=4;
diam_guidon=34+0.4;
ecar_charniere=54;
larg_charniere=16;
diam_vis=6+0.2; 
prof_encoche=12+diam_vis;
retr_guidon=12;

module Pince_2D() {
  offset(r=diam_arrondi/2) offset(delta=-diam_arrondi/2) difference() {
    hull() {
      translate([-diam_arrondi/2,diam_guidon/2]) circle(r=diam_arrondi/2);
      translate([-diam_arrondi/2,,-diam_guidon/2]) circle(r=diam_arrondi/2);
      translate([diam_guidon/2+(prof_encoche+retr_guidon)/2,0])
        square([prof_encoche+retr_guidon,ecar_charniere+larg_charniere*2],center=true) ;
    }
    circle(r=diam_guidon/2,$fn=60);
    translate([diam_guidon/2+retr_guidon,ecar_charniere/2])
      square([prof_encoche+0.1,larg_charniere+0.1]) ;
    translate([diam_guidon/2+retr_guidon,-ecar_charniere/2-larg_charniere-0.1])
      square([prof_encoche+0.1,larg_charniere+0.1]) ;
  }
}

larg_collier=9+1; epai_collier=1.8+1; retr_collier=3;
haut_pince=larg_collier+10; 


module Pince() {
  intersection() {
    difference() {
      linear_extrude(haut_pince,center=true) Pince_2D();
      scale([1.2,1,1]) Tuyau(larg_collier,diam_guidon+(epai_collier+retr_collier)*2,epai_collier);
      translate([diam_guidon/2+retr_guidon+prof_encoche/2,0,0])
        rotate([90,0,0]) cylinder(r=diam_vis/2,h=ecar_charniere+0.2,center=true,$fn=16);
    }
    union() {
      cube([diam_guidon+retr_guidon*2+prof_encoche,ecar_charniere+larg_charniere*2+0.2,haut_pince+0.2],center=true);
      translate([diam_guidon/2+retr_guidon+prof_encoche-haut_pince/2,0,0])
        rotate([90,0,0]) cylinder(r=haut_pince/2,h=ecar_charniere+larg_charniere*2+0.2,center=true,$fn=40);
    }
  }
}