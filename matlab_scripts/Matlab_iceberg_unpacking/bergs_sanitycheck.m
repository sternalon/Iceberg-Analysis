function [] = bergs_sanitycheck(bergs)
% Check berg segments are consistent

tic
for b=1:length(bergs.berg)
  seg=bergs_segment(bergs,b);
  found=0;
  for s=2:length(seg)
    if seg(s).year0~=seg(s-1).year0 | ...
       seg(s).day0~=seg(s-1).day0 | ...
       seg(s).lon0~=seg(s-1).lon0 | ...
       seg(s).lat0~=seg(s-1).lat0 | ...
       seg(s).mass0~=seg(s-1).mass0
         found=found+1
    end
  end
  if mod(b,100)==0
    disp( sprintf('Checked %i (%5.2f%%)',b,100*b/length(bergs.berg))) 
  end
  if found>0
    disp( sprintf('Berg %i had %i inconsistencies',b,found) )
  end
end
disp( sprintf('%i checks made in %f secs',length(bergs.berg),toc)); tic

