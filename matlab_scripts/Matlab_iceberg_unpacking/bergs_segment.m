function [seg] = bergs_segment(bergs,n)
% seg=bergs_segment(bergs,n)
% Create segment structure for berg number n

nc=bergs.nc;
for l=1:length(bergs.berg(n).js)
  seg(l).year0=nc{'year'}( bergs.berg(n).js(l)-1 );
  seg(l).day0=nc{'day'}( bergs.berg(n).js(l)-1 );
  seg(l).lon0=nc{'lon'}( bergs.berg(n).js(l)-1 );
  seg(l).lat0=nc{'lat'}( bergs.berg(n).js(l)-1 );
  seg(l).mass0=nc{'mass'}( bergs.berg(n).js(l)-1 );
  seg(l).hash=bergs_hash(seg(l).year0,seg(l).day0,seg(l).lon0,seg(l).lat0,seg(l).mass0);
end
