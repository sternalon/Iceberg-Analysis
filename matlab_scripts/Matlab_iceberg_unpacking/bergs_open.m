function [bergs_handle] = bergs_open(filename)
% [bergs_handle]=bergs_open(nc);
% [bergs_handle]=bergs_open('filename');
%clear all
%filename='../../Test_data1/Alon_test1/icebergs_combined.nc';
%filename='../../Test_data1/Alon_test2/combined_iceberg.nc';
%clear all
%filename= '/home/aas/Iceberg_Project/Weddell_Sea/one_iceberg_testing/iceberg_trajectories.nc'
%filename='/home/aas/Iceberg_Project/Test_data1/Quick_Global_RK15/iceberg_trajectories.nc';

if isobject(filename)
  nc=filename;
else
  nc=netcdf(filename);
end

tic;
lat=nc{'lat'}(:);
disp( sprintf('%i lat entries read in %f secs',length(lat),toc)); tic
js=find(lat>91);
je=[js(2:end)'-1 length(lat)]';
disp( sprintf('%i segments found in %f secs',length(js),toc)); tic

% Scan for icebergs ids
lon=nc{'lon'}(:);
year=nc{'year'}(:);
day=nc{'day'}(:);
mass=nc{'mass'}(:);
disp( sprintf('Id fields read in %f secs',toc)); tic

h=zeros(length(js),1);
k=0;
for j=js'+1;
 k=k+1;
 h(k)=bergs_hash(year(j),day(j),lon(j),lat(j),mass(j));
end
disp( sprintf('Hashes made in %f secs',toc)); tic
h=(unique(h))';
disp( sprintf('Hashes sorted in %f secs',toc)); tic

% Create blank bergs with hash
berg.year0=[]; berg.day0=[]; berg.lon0=[]; berg.lat0=[]; berg.mass0=[]; berg.hash=[]; berg.js=[]; berg.je=[];
berg(length(h)).hash=[]; % Allocate memory for speed
for i=1:length(h); % Fill hash for searching
 berg(i).hash=h(i);
end
disp( sprintf('Created %i blank bergs in %f secs',length(berg),toc)); tic

% Copy start values from vector to berg, hash and segment 
for i=1:length(js); % for each segment
 j=js(i)+1; % Start values
 l=find(h==bergs_hash(year(j),day(j),lon(j),lat(j),mass(j)));
 % Index hash of segment against list of berg hashes
 if ~isempty(l)
  berg(l).year0=year(j);
  berg(l).day0=day(j);
  berg(l).lon0=lon(j);
  berg(l).lat0=lat(j);
  berg(l).mass0=mass(j);
  berg(l).js(end+1)=js(i)+2;
  berg(l).je(end+1)=je(i);
 else
  whos
  [i j js(i) je(i) l']
  error('oops')
 end
end
%berg(:).lat0
disp( sprintf('Filled start values in %i bergs in %f secs',length(berg),toc)); tic
if length(berg)~=length(h)
  error('The number of hashes and bergs do not match!')
end
% Sort segments for each berg
for i=1:length(h)
 yd=year(berg(i).js)+day(berg(i).js)/373;
 [y,ii]=sort(yd,'descend');
 berg(i).js=berg(i).js(ii);
 berg(i).je=berg(i).je(ii);
%berg(i).ydsort=y;
end

disp( sprintf('Sorted segments within each berg %f secs',toc)); tic

bergs_handle.nc=nc
bergs_handle.berg=berg;

