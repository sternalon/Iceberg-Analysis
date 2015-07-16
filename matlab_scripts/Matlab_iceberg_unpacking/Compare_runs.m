%Script to run the other scripts
clear all
close all

%Note: The first time you have to run nc64startup.m


%Flags
plot_tradjectories=1;
plot_distribution_historgram=0;
plot_velocities=0;
Weddel_domain=1;

%Note: The first time you have to run nc64startup.m

%%%%%%%%%%%%%%%%%%%%%%%   Global Model   %%%%%%%%%%%%%%%%%%%%%%%%%%
fileroot='/home/aas/Iceberg_Project/Test_data1/';
 %dirname1='Global_iceberg_Verlet';
 %dirname2='Global_iceberg_RK';

%dirname1='Quick_Global_Verlet';
%dirname2='Quick_Global_Verlet15';
dirname1='Quick_Global_RK15';
dirname2='Quick_Global_RK16';
%dirname1='Quick_Global_RK_original';
%dirname1='Quick_Global_RK_Coriolis_only';
%dirname2='Quick_Global_Verlet_Coriolis_only';
%dirname1='Global_mass_dist'
%dirname2='Global_freq_dist'


%%%%%%%%%%%%%%%%%%%%%%%  Weddle Sea %%%%%%%%%%%%%%%%%%%%%%%%5
if Weddel_domain==1

%Weddel Sea Version
fileroot='/home/aas/Iceberg_Project/Weddell_Sea/'
dirname1='one_iceberg_testing_Verlet';
dirname2='one_iceberg_testing_RK';
end


%%%%%%%%%%%%%%%%%%%%%%%  Loading data %%%%%%%%%%%%%%%%%%%%%%%%5
filename1=[fileroot dirname1 '/iceberg_trajectories.nc'];
filename2=[fileroot dirname2 '/iceberg_trajectories.nc'];
%Getting icebergs from File 1
[bergs1]=bergs_open(filename1)
[bergs1]=bergs_yearday(bergs1)
[bergs1]=bergs_read(bergs1,'lon')
[bergs1]=bergs_read(bergs1,'lat')
[bergs1]=bergs_read(bergs1,'width')
[bergs1]=bergs_read(bergs1,'length')
[bergs1]=bergs_read(bergs1,'mass')
[bergs1]=bergs_read(bergs1,'uvel')
[bergs1]=bergs_read(bergs1,'vvel')
%Getting iceberg from 2ile 2
[bergs2]=bergs_open(filename2)
[bergs2]=bergs_yearday(bergs2)
[bergs2]=bergs_read(bergs2,'lon')
[bergs2]=bergs_read(bergs2,'lat')
[bergs2]=bergs_read(bergs2,'width')
[bergs2]=bergs_read(bergs2,'length')
[bergs2]=bergs_read(bergs2,'mass')
[bergs2]=bergs_read(bergs2,'uvel')
[bergs2]=bergs_read(bergs2,'vvel')

if plot_tradjectories==1
       figure(1)
       if Weddel_domain==1
       xlim([-85,20]); ylim([-76.75 -60])
    end
    for N=1:length(bergs1.berg)
        %N=1;   %This variable describes what berg number we are plotting.
        hold on
        plot(bergs1.berg(N).lon,bergs1.berg(N).lat,'b','linewidth',2)
        plot(bergs1.berg(N).lon,bergs1.berg(N).lat,'*b','linewidth',2)
        plot(bergs2.berg(N).lon,bergs2.berg(N).lat,'k')
        plot(bergs2.berg(N).lon,bergs2.berg(N).lat,'*k')
        
        [a1 b1]=min(bergs1.berg(N).yearday);   
        [a2 b2]=min(bergs2.berg(N).yearday);

        plot(bergs1.berg(N).lon(b1),bergs1.berg(N).lat(b1),'r*','linewidth',5)
        plot(bergs2.berg(N).lon(b2),bergs2.berg(N).lat(b2),'m*','linewidth',5)

    end
    xlabel('Longitude')
    ylabel('Latitude')
end
% 
% 
% 
% %This section plots L_eff circles around the icebergs
% Radius_earth=6378.135*(10^(3));
% circ_ind=[0:0.1:2*pi];
% for i=1:length(bergs1.berg(N).lat)
%     L_eff=sqrt(((bergs1.berg(N).width(i)*bergs1.berg(N).width(i))/pi));
%     d_lat=(L_eff/Radius_earth)*(180/pi);
%     d_lon=L_eff/(111.320*(10^(3))*cos(bergs1.berg(N).lat(i)/180*pi));
%     plot(bergs1.berg(N).lon(i)+(d_lon*cos(circ_ind)),bergs1.berg(N).lat(i)+(d_lat*sin(circ_ind)));
% end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if plot_distribution_historgram==1
initial_mass=[8.8e7 4.1e8 3.3e9 1.8e10 3.8e10 7.5e10 1.2e11 2.2e11 3.9e11 7.4e11];
mass_list1=zeros(length(bergs1.berg),1);
mass_list2=zeros(length(bergs2.berg),1);
    for k=1:length(bergs1.berg)
        mass_list1(k)=bergs1.berg(k).mass(1);
    end
    for k=1:length(bergs2.berg)
        mass_list2(k)=bergs2.berg(k).mass(1);
    end
    figure(2)
    subplot(2,1,1)
    hist(mass_list1,initial_mass)
    subplot(2,1,2)
    hist(mass_list2,initial_mass)
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if plot_velocities==1
     for N=1:length(bergs1.berg)
        %N=1;   %This variable describes what berg number we are plotting.
        figure(1)
        hold on
        plot(bergs1.berg(N).uvel,bergs1.berg(N).vvel,'b')
        plot(bergs1.berg(N).uvel,bergs1.berg(N).vvel,'*b')
        plot(bergs2.berg(N).uvel,bergs2.berg(N).vvel,'r')
        plot(bergs2.berg(N).uvel,bergs2.berg(N).vvel,'*r')
        
        
        xlabel('u')
ylabel('v')
        
    end
end




