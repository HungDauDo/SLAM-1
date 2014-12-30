clear
clc
close all
odometry
fid = fopen('laser.txt');
alpha=linspace(-30,210,682);
lastl=0;lastr=0;
X=0;Y=0;
for i=1:100
    tic
    theta=abs((xpos(i)-ypos(i)))*.138/1000;
    theta=theta/.0086344;
    while(theta>360)
        theta=theta-360;
    end
    theta=90-theta;
    lsamp=xpos(i);rsamp=ypos(i);
    lticks=lsamp-lastl;
    rticks=rsamp-lastr;
    lastl=lsamp;
    lastr=rsamp;
    r=(lticks+rticks)*.138/2/1000;
    x=r*cosd(theta);
    y=r*sind(theta);
    X=X+x;
    Y=Y+y;
    for j=1:681
        tline= fgets(fid);
        for ie=1:length(tline)-1
            a1(ie)=tline(ie);
        end
        a=str2num(a1);
        for ie=1:length(a1)
            a1(ie)=' ';
        end
        ex=a*cosd(alpha(j)-(90-theta));
        why=a*sind(alpha(j)-(90-theta));
        X_ex(j)=X+ex;
        Y_why(j)=Y+why;
    end
    figure(1);
    
%     X_ex=medfilt1(X_ex,20);
%     Y_why=medfilt1(Y_why,20);

    plot(X_ex,Y_why,'.','MarkerSize',1);
    
%     hold on;

% figure;
% max_x=max(X_ex);
% min_x=min(X_ex);
% for i=1:length(X_ex);
%     if X_ex(i)<0
%         norm_x(i)=X_ex(i)/abs(min_x);
%     else
%         norm_x(i)=X_ex(i)/max_x;
%     end
% end
% max_y=max(Y_why);
% min_y=min(Y_why);
% for i=1:length(Y_why);
%     if Y_why(i)<0
%         norm_y(i)=Y_why(i)/abs(min_y);
%     else
%         norm_y(i)=Y_why(i)/max_y;
%     end
% end
% plot(norm_x,norm_y,'.','MarkerSize',1);

% normalize
xmin=min(X_ex);
xmax=max(X_ex);
Slopex=1/(xmax-xmin);

ymin=min(Y_why);
ymax=max(Y_why);
Slopey=1/(ymax-ymin);

x2=X_ex-xmin;
y2=Y_why-ymin;

nx=x2*Slopex;
ny=y2*Slopey;

%figure(3);plot(round(nx*100),round(ny*100),'r*');
%toc
rx=round(nx*100)+1;
ry=round(ny*100)+1;
I=zeros(101,101);

for ixy=1:length(rx)
I(rx(ixy),ry(ixy))=1;
end

inter=[0 0 0 0 0;
       0 0 0 0 0;
       1 1 1 1 1;
       0 0 0 0 0;
       0 0 0 0 0];
bw1 = bwhitmiss(I,inter);
%bw1=imrotate(bw1,-90);
[xm1,ym1]=find(bw1);

inter=[0 0 1 0 0;
       0 0 1 0 0;
       0 0 1 0 0;
       0 0 1 0 0;
       0 0 1 0 0];
bw2 = bwhitmiss(I,inter);
%bw2=imrotate(bw2,-90);
[xm2,ym2]=find(bw2);

inter=[1 0 0 0 0;
       0 1 0 0 0;
       0 0 1 0 0;
       0 0 0 1 0;
       0 0 0 0 1];
bw3 = bwhitmiss(I,inter);
%bw3=imrotate(bw3,-90);
[xm3,ym3]=find(bw3);

inter=[0 0 0 0 1;
       0 0 0 1 0;
       0 0 1 0 0;
       0 1 0 0 0;
       1 0 0 0 0];
bw4 = bwhitmiss(I,inter);
%bw4=imrotate(bw4,-90);
[xm4,ym4]=find(bw4);



bw=bw1|bw2|bw3|bw4;
figure(2);
subplot(1,2,1);imshow(I);
subplot(1,2,2);imshow(bw);

xm=[xm1;xm2;xm3;xm4];
ym=[ym1;ym2;ym3;ym4];

xm=(xm-1)/100;
ym=(ym-1)/100;

xm=xm/Slopex;
ym=ym/Slopey;

xm=xm+xmin;
ym=ym+ymin;

figure(3);
plot(X_ex,Y_why,'.',xm,ym,'rO');
% hold on;
toc
pause;
end
