function [] = bergs_plottraj(bergs,yearday,dt)
circ_ind=[0:0.1:2*pi];
% plottraj(bergs,yearday,dt)
switch length(yearday)
    case 1;
        year=floor(yearday);
        day=round(372*(yearday-year));
    case 2;
        year=yearday(1);
        day=yearday(2);
        yearday=yearday(1)+yearday(2)/372;
    otherwise
        error('Second argument should be a yearday or vector [year day]')
end

tic
ax=axis;
hold on
tcount=0;
for b=1:length(bergs.berg);
    bergs.berg(b).day;
    day;
    %k=find(bergs.berg(b).yearday>=yearday-dt/372 & bergs.berg(b).yearday<=yearday);
    k=find(bergs.berg(b).day>=day-dt & bergs.berg(b).day<=day);
    if ~isempty(k)
        x=bergs.berg(b).lon(k);
        if max(x)<ax(1) || min(x)>ax(2) %|| mean(bergs.berg(b).uvel(k).^2+bergs.berg(b).vvel(k).^2)<0.0001^2 || bergs.berg(b).mass(k(1)) < 1e6
            continue
        end
        if length(x)>1
            if max(abs(x(2:end)-x(1:end-1)))>5
                continue
            end
        end
        y=bergs.berg(b).lat(k);
        if y(1)<ax(3) || y(1)>ax(4)
            continue
        end
        if max(x)>80
            x=x-360;
        end
        tcount=tcount+1;
        while min(x)<80
            if length(x)>1
                plot(x,y,'k-');
            end
            %  if bergs.berg(b).mass(k(1))>0.001*1e8;
            plot(x(1),y(1),'k.');
            %   plot(x(1),y(1),'m.');
            
            d=(x(1)/300)
            % plot(x(1)+(d*cos(circ_ind)),y(1)+(d*sin(circ_ind)),'m');
            bergs.berg(b).width(k)
            %This section plots L_eff circles around the icebergs
            Radius_earth=6378.135*(10^(3));
            circ_ind=[0:0.1:2*pi];
            %  for i=1:length(bergs.berg(N).lat)
            L_eff=sqrt(((bergs.berg(b).width(k(1))*bergs.berg(b).width(k(1)))/pi));
            d_lat=(L_eff/Radius_earth)*(180/pi)
            d_lon=L_eff/(111.320*(10^(3))*cos(bergs.berg(b).lat(k(1))/180*pi))
            plot(bergs.berg(b).lon(k(1))+(d_lon*cos(circ_ind)),bergs.berg(b).lat(k(1))+(d_lat*sin(circ_ind)),'m');
            %  end
            
            
            %  end
            x=x+360;
        end % while
    end
end
hold off
axis(ax)

disp( sprintf('Drew %i trajectories in %f secs',tcount,toc)); tic;
