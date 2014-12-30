clear all;
close all;
tic;
load laser_data1;
d=laser;
N=681;
Nd=length(d)/N;
in=1;
for in=1:Nd
    rho=d(1+(in-1)*N:N+(in-1)*N)';
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

nx=x2*Slopex;
ny=y2*Slopey;

%figure(3);plot(round(nx*100),round(ny*100),'r*');
%toc
rx=round(nx*200)+1;
ry=round(ny*200)+1;
I=zeros(210,210);

for ixy=1:length(rx)
I(rx(ixy)+5,ry(ixy)+5)=1;
end
%imshow(I);

%I=medfilt2(I,[4,4]);
%I=imrotate(I,90);
%figure(4);imshow(I)
%se=[1 1;1 1]
%I=imdilate(I,se);imshow(I);
se=ones(4,4);
Id=imdilate(I,se);
Ie=imerode(Id,se);
%imshow(Id);
I=Ie;

%%% For Creating SEs
N1=11;
xn=N1;
yn=N1;
se=zeros(xn,yn);

xc=round(xn/2);
yc=round(yn/2);

se(xc,yc)=1;

xne=(-1:1)+xc; 
yne=(-1:1)+yc;
n=1;
for i=1:length(xne)
    for j=1:length(yne)
        if (x(i)== xc)&&(y(j)==yc)
            %%
        else
        se(xc,yc)=1;
        se(xne(i),yne(j))=1;
        se(2*xne(i)-xc,2*yne(j)-yc)=1;
        se(3*xne(i)-2*xc,3*yne(j)-2*yc)=1;
        se(4*xne(i)-3*xc,4*yne(j)-3*yc)=1;
        se(5*xne(i)-4*xc,5*yne(j)-4*yc)=1;
 %       se
%        pause;
        se_data(:,n:n+(N1-1))=se;
        n=n+N1;
        se=zeros(xn,yn);
    %pause;
        end
    end
end

l=length(se_data)/N1;
xm=[0];
ym=[0];

for ip=1:l-1
    In=se_data(:,1+(ip-1)*N1:N1+(ip-1)*N1);
    for ip1=ip+1:l
        In1=se_data(:,1+(ip1-1)*N1:N1+(ip1-1)*N1);
    if ip1 == l+1-ip
        %%
    else
        Inter=round((In+In1)/2);
        if sum(sum(Inter))>6
    %imshow(Inter)
    %pause
    bw4 = bwhitmiss(I,Inter);
%bw4=imrotate(bw4,-90);
[xm1,ym1]=find(bw4);
xm =[xm;xm1];
ym=[ym;ym1];
%pause;
        end
    end
    end
end



%bw=bw1|bw2|bw3|bw4;
%subplot(1,2,1);imshow(I);
%subplot(1,2,2);imshow(bw1);



% xm=[xm1;xm2;xm3;xm4];
% ym=[ym1;ym2;ym3;ym4];
tol=20;
if isempty(xm)
    
else
[xm,ym]=unique_tol(xm,ym,tol);
end

figure(5);
plot(rx,ry,'.',xm-4,ym-4,'rO');
% plot(x,y,'.');
xm=(xm-5)/210;
ym=(ym-5)/210;

xm=xm/Slopex;
ym=ym/Slopey;

xm=xm+xmin;
ym=ym+ymin;

% figure(5);
%plot(x,y,'.',xm,ym,'rO');
% hold on;
toc
pause(0.5);
%hold on;
end