function [bergs] = bergs_read(bergs,varname)
% bergs_handle=bergs_open(nc);
% bergs_handle=bergs_open('filename');
%
% bergs=bergs_read(bergs_handle,'variable');

if ~isstruct(bergs)
  error('First argument must be a result of function openbergs')
end

tic;
nc=bergs.nc;
var=nc{varname}(:);
disp( sprintf('Variable "%s" vector read in %f secs',varname,toc)); tic

%bergs=bergsin;
%disp( sprintf('Berg structure copied in %f secs',toc)); tic

for b=1:length(bergs.berg)
  k=[];
  js=bergs.berg(b).js;
  je=bergs.berg(b).je;
  for l=1:length(js);
        k=[k js(l):je(l)];
  end
  bergs.berg(b).(varname)=var(k);
end
disp( sprintf('Berg variable inserted in %f secs',toc)); tic
