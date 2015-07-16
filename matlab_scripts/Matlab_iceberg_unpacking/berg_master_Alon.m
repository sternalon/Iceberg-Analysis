%Script to run the other scripts
clear all

%Note: The first time you have to run nc64startup.m

%filename='../../Test_data1/iceberg_trajectories.nc.0001';
%filename='../../Test_data1/Alon_test1/icebergs_combined.nc';
%filename='../../Test_data1/Alon_test2/combined_iceberg.nc';
%filename='../../Test_data1/Iceberg_Weddell_Test2/iceberg_combined.nc';
%filename='/home/aas/Iceberg_Project/Test_data1/Global_iceberg_test2/combined_iceberg.nc';
filename='/home/aas/Iceberg_Project/Weddell_Sea/one_iceberg_testing/iceberg_trajectories.nc';



'************************************************'
'*****     Running function bergs_open     ******'
'************************************************'
[bergs]=bergs_open(filename)

'************************************************'
'*****    Running function bergs_yearday   ******'
'************************************************'
[bergs]=bergs_yearday(bergs)


'************************************************'
'*****    Running function bergs_latlon   ******'
'************************************************'
%[bergs]=bergs_latlon(bergs)
[bergs]=bergs_read(bergs,'lat')
[bergs]=bergs_read(bergs,'lon')

[bergs]=bergs_read(bergs,'width')
[bergs]=bergs_read(bergs,'length')

N=1;   %This variable describes what berg number we are plotting.
figure
hold on
plot(bergs.berg(N).lon,bergs.berg(N).lat)
plot(bergs.berg(N).lon,bergs.berg(N).lat,'*')

%This section plots L_eff circles around the icebergs
Radius_earth=6378.135*(10^(3));
circ_ind=[0:0.1:2*pi];
for i=1:length(bergs.berg(N).lat)
    L_eff=sqrt(((bergs.berg(N).width(i)*bergs.berg(N).length(i))/pi));
    d_lat=(L_eff/Radius_earth)*(180/pi);
    d_lon=L_eff/(111.320*(10^(3))*cos(bergs.berg(N).lat(i)/180*pi));
    plot(bergs.berg(N).lon(i)+(d_lon*cos(circ_ind)),bergs.berg(N).lat(i)+(d_lat*sin(circ_ind)));
end

xlabel('Longitude')
ylabel('Latitude')
% halt
% yearday=bergs.berg.yearday
% 
% 'Sanity check:'
% %bergs_sanitycheck(bergs)
% 
% dt=1
% 
% bergs_plottraj(bergs,yearday,dt)
