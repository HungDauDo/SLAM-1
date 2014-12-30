clear all;
close all;
tic;
load laser_data;
d=laser;
N=681;
Nd=size(d)/N;
%n=1
%in=1;
for n=1:10
    n
%for in=n:n+1
    rho=d(1+(n-1)*N:N+(n-1)*N)';
    res=(210-(-30))/680;
    t=-30:res:210;
    for i=1:length(t)
        theta(i)=t(end-(i-1));
    end
    the_rad=theta*pi/180;
    x=rho.*sin(the_rad);
    y=rho.*cos(the_rad);
    %figure(2)
    %plot(x,y,'.','MarkerSize',1);
%normalize
xmin=min(x);
xmax=max(x);
Slopex=1/(xmax-xmin);

ymin=min(y);
ymax=max(y);
Slopey=1/(ymax-ymin);

x2=x-xmin;
y2=y-ymin;

nx(n,:)=x2*Slopex;
ny(n,:)=y2*Slopey;
%end
if n>=2
%dif_nx=mean(nx(n-1,:)-nx(n,:));
%dif_ny=mean(ny(n-1,:)-ny(n,:));
dx=nx(n-1,:)-nx(n,:);
dy=ny(n-1,:)-ny(n,:);

devx=dx-mean(dx);
devy=dy-mean(dy);

sum_x=0;
sum_y=0;
for ixy=1:length(devx)
    if abs(devx(ixy)) < 0.001
        sum_x=sum_x+devx(ixy);
    end
    if abs(devy(ixy)) < 0.001
        sum_y=sum_y+devy(ixy);
    end
end
mx=sum_x/length(devx);
my=sum_y/length(devy);

%figure(1);plot(nx,ny,'rO');
figure(2);
plot(nx(n-1,:),ny(n-1,:),'bO',nx(n,:)-mx,ny(n,:)-my,'r*')
%hold on;
pause(0.5);
end
end
%pause(1);
