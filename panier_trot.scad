function r(d)=d/2;

//long0_vis=1; long1_vis=40; long2_vis=5;
//diam0_vis=8; diam1_vis=5; diam2_vis=6;

diam0_tuyau=16+0.2;
ecart_vis=100;

module Vis() {
  color("LightSlateGray") union() {
    cylinder(r=diam0_vis/2,h=long0_vis);
    translate([0,0,long0_vis-0.1]) cylinder(r=diam2_vis/2,h=long2_vis);
    translate([0,0,-long1_vis+0.1]) cylinder(r=diam1_vis/2,h=long1_vis);
  }
}


module Tuyau(p_long,p_dext,p_epai) {
 color("LightGray") difference() {
    cylinder(r=p_dext/2,h=p_long,center=true);
    cylinder(r=p_dext/2-p_epai,h=p_long+0.2,center=true);
  }
}


module Tuyau_Ep1(p_long,p_dext) {
  Tuyau(p_long,p_dext,1);
}


tron_coude=22; retr_coude=diam0_tuyau/2+1; long_coude=tron_coude+retr_coude*2; epai_coude=1;


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


long0_cadre=300; long1_cadre=long0_cadre-retr_coude*4;
larg0_cadre=200; larg1_cadre=larg0_cadre-retr_coude*4;
epai_cadre=1;


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
//    translate([larg0_cadre/2-retr_coude,-ecart_vis/2,0]) rotate([90,0,0]) Tuyau_Ep1(20,diam0_tuyau+2);
//    translate([larg0_cadre/2-ret4r_coude,ecart_vis/2,0]) rotate([90,0,0]) Tuyau_Ep1(20,diam0_tuyau+2);
  }
}


/*
haut_pince=20;
diam_guidon=40; dist_guidon=10;
diam_trou=5; dist_trou=10; ecar_trou=100;
diam_arrondi=4;

module Pince1() {
  hull() {
    circle(r=diam_guidon-0.1);
    translate([diam_guidon+dist_guidon+diam_trou+dist_trou-diam_arrondi/2,0]) {
      translate([0,ecar_trou/2+diam_trou/2+dist_trou-diam_arrondi/2]) circle(r=diam_trou/2);
      translate([0,-(ecar_trou/2+diam_trou/2+dist_trou-diam_arrondi/2)]) circle(r=diam_trou/2);
    }
  }
}
*/

diam_arrondi=4;
diam_guidon=34+0.4;
ecar_charniere=54;
//larg_charniere=12;
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


//Structure();
module Visu() {
  color("Blue") Pince();
  color("Red") {
    translate([diam_guidon/2+retr_guidon+prof_encoche/2,-ecar_charniere/2-larg_charniere/2,0]) Charniere();
    translate([diam_guidon/2+retr_guidon+prof_encoche/2,ecar_charniere/2+larg_charniere/2,0]) Charniere(true);
  }
//  translate([larg0_cadre/2+diam_guidon/2+retr_guidon+prof_encoche+espa_charniere+1,0,0]) Structure();
}


module Imprime() {
//  translate([0,0,haut_pince/2]) Pince();
  translate([0,0,larg_charniere/2]) {
    translate([-15,0,0]) rotate([90,0,90]) Charniere();
    translate([15,15,0]) rotate([90,0,-90]) Charniere(true);
  }
}
translate([0,45,0]) 
//Visu();
Imprime();

// ATTENTION AU PARAMETRE POUR CHARNIERE
echo(ecar_charniere+2*larg_charniere);