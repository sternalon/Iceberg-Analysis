function [h]=bergs_hash(year,day,x,y,m)
% h=bergs_hash(year,day,x,y,m)
% Return hash of year, day, position and mass
 ilat=(90.+y)/180;
 ilon=mod(x,360)/360;
 iyear=floor(year);
 iday=(day/372);
 im=log10(m)-7.9;
 h=ilon+1e3*ilat+1e6*iday+1e9*iyear+1e12*im;
