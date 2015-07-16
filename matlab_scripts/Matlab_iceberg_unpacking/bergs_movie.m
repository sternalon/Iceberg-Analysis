close all
clear all

%nc64startup; %Run this first time arond

fileroot='/home/aas/Iceberg_Project/Test_data1/';
dirname='Iceberg_Weddell_Test3/';

%Iceberg filename
%Global
%filename='../../Test_data1/Alon_test2/combined_iceberg.nc';
%filename='../../Test_data1/Iceberg_Weddell_Test2/iceberg_combined.nc';
%filename='/home/aas/Iceberg_Project/Test_data1/Global_iceberg_test2/combined_iceberg.nc';

%Weddell
filename=[fileroot dirname '/iceberg_trajectories.nc';]
%filename='/home/aas/Iceberg_Project/Test_data1/Iceberg_Weddell_Test2/combined_icebergs.nc';
%filename='/home/aas/Iceberg_Project/Test_data1/Iceberg_Weddell_Test3/iceberg_trajectories.nc';

%Background file name
%filename2='/home/aas/Iceberg_Project/Test_data1/Global_iceberg_test2/ocean_static.nc';
filename2='/home/aas/Iceberg_Project/Test_data1/Iceberg_Weddell_Test3/ocean_static.nc';


b=bergs_open(filename)
b=bergs_yearday(b)
b=bergs_read(b,'lon')
b=bergs_read(b,'lat')
b=bergs_read(b,'mass')
b=bergs_read(b,'width')
b=bergs_read(b,'length')

%nc=netcdf('icebergs.194001-195912.sst.nc');
%mc=netcdf('icebergs.static.nc');
%xt=nc{'xt'}(:);
%yt=nc{'yt'}(:);
%
rc=netcdf(filename2)
xt=rc{'xh'}(:);
yt=rc{'yh'}(:);


%name='ross'
%ax=[-200 -120 -78 -40]
name='weddell'
ax=[-90 5 -78 -60];%ax=[-90 5 -78 -40];

%name='weddle_zoom'
%ax=[-65 -50 -78 -60];
%cmap=mycm(256); %cmap=cmap(end:-1:1,:);

%msk=mc{'mask'}(:,:);
%x=mc{'lon'}(:,:);
%y=mc{'lat'}(:,:);
%x(:,2:end+1)=x; x(:,1)=x(:,end)-360;
%x(2:end+1,:)=x; x(1,:)=x(1,:);
%y(:,2:end+1)=y; y(:,1)=y(:,end);
%y(2:end+1,:)=y; y(1,:)=y(1,:);

field=rc{'wet_v'}(:,:);
% depth(find(~isnan(depth)))=0;
pcolor(xt,yt,field);shading flat

for d=1:1:500
  m0=(1955-1940)*0+floor((d+15)/31);
  d0=31*m0-15.5; d1=31*(m0+1)-15.5;
  w0=(d1-d)/(d1-d0); w1=1-w0;
  M0=(1955-1940)*12+m0;
  %sst0=nc{'sst'}(M0,:,:);
  %sst1=nc{'sst'}(M0+1,:,:);
  %sst=msk.*(w0*sst0+w1*sst1);
  %sst(:,end+1)=NaN; sst(end+1,:)=NaN;
  clf;
  hold on
  pcolor(xt,yt,field);shading flat;

  %pcolor(x,y,sq(sst));shading flat
  axis(ax);
  %caxis([-5 20]);colormap(cmap)
  bergs_plottraj(b,[1955 d],10);
  de=.04;set(gca,'Position',[de de 1-2*de 1-2*de],'FontSize',8,'Color',[1 1 1]*.7);
  title( sprintf('Month %2i  Day %2i',1+floor((d-1)/31),1+mod(d-1,31)) ,'Fontsize',12);
  hcb=axes('position',[.05 .07 .25 .04]);pcolor([-2:.1:20],[0 1],[[-2:.1:20]' [-2:.1:20]']');axis([-2 20 0 1]);shading interp;
 %hcb=axes('position',[.70 .065 .25 .02]);pcolor([-5:.1:20],[0 1],[[-5:.1:20]' [-5:.1:20]']');axis([-2 20 0 1]);shading interp
  set(hcb,'YTick',[],'FontSize',6);title('SST (monthly)','FontSize',10);
  drawnow
  %print('-djpeg100','-r90', sprintf('frames/%s.%4.4i.jpg',name,d));
end
