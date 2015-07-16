%b=bergs_open('00090101.iceberg_trajectories.nc')
%b=bergs_yearday(b)
%b=bergs_read(b,'lon')
%b=bergs_read(b,'lat')
%b=bergs_read(b,'mass')
nc=netcdf('00090101.ice_daily.nc');
xt=nc{'xt'}(:);
yt=nc{'yt'}(:);
mc=netcdf('00090101.icebergs_month.nc');

name='ross'
ax=[-200 -120 -78 -40]
name='weddell'
ax=[-90 5 -78 -40]
cmap=hsv(256);cmap=cmap(end:-1:1,:);

cax=[-2.25 .25];
hcx=[-2.25:.1:.25];

msk=mc{'mask'}(:,:);
x=mc{'lon'}(:,:);
y=mc{'lat'}(:,:);
x(:,2:end+1)=x; x(:,1)=x(:,end)-360;
x(2:end+1,:)=x; x(1,:)=x(1,:);
y(:,2:end+1)=y; y(:,1)=y(:,end);
y(2:end+1,:)=y; y(1,:)=y(1,:);

for d=128:1:365
  sst=msk.*nc{'SSH'}(d,:,:);
  sst(:,end+1)=NaN; sst(end+1,:)=NaN;
  clf;patch([-280 80 80 -280],[-90 -90 90 90],[1 1 1]*.5)
  hold on
  pcolor(x,y,sq(sst));shading flat
 %contour(xt,yt,cn,[-1 .15],'w','LineWidth',1.5)
  axis(ax);
  caxis([-2.25 .25]);colormap(cmap)
  bergs_plottraj(b,[9 d],10)
  de=.04;set(gca,'Position',[de de 1-2*de 1-2*de],'FontSize',8)
  title( sprintf('Year %i  Month %2i  Day %2i',1955,1+floor((d-1)/31),1+mod(d-1,31)) )
  hcb=axes('position',[.05 .08 .25 .04]);pcolor(hcx,[0 1],[hcx' hcx']');axis([min(hcx) max(hcx) 0 1]);shading interp
 %hcb=axes('position',[.70 .065 .25 .02]);pcolor([-5:.1:20],[0 1],[[-5:.1:20]' [-5:.1:20]']');axis([-2 20 0 1]);shading interp
  set(hcb,'YTick',[],'FontSize',6);title('SSH (m)','FontSize',8)
  drawnow
  print('-djpeg100','-r90', sprintf('frames/%s.%4.4i.jpg',name,d));
end
