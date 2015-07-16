function [bergs] = bergs_yearday(bergs)
% bergs=bergs_yearday(bergs)
% Read year-day data

if ~isfield(bergs.berg,'year')
  bergs=bergs_read(bergs,'year');
end
if ~isfield(bergs.berg,'day')
  bergs=bergs_read(bergs,'day');
end

tic;
if ~isfield(bergs.berg,'yearday')
  for b=1:length(bergs.berg)
    bergs.berg(b).yearday=bergs.berg(b).year+bergs.berg(b).day/372;
  end
  disp( sprintf('Variable "yearday" calculated in %f secs',toc)); tic
end
