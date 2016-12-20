module Tuyau(p_long,p_dext,p_epai) {
 color("LightGray") difference() {
    cylinder(r=p_dext/2,h=p_long,center=true);
    cylinder(r=p_dext/2-p_epai,h=p_long+0.2,center=true);
  }
}