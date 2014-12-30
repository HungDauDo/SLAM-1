clc;
clear all;
close all;
odometry
fid = fopen('laser.txt');
alpha=linspace(-30,210,682);
lastl=0;lastr=0;
X=0;Y=0;
dat=[];
for i=1:100
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
    rob_r=(lticks+rticks)*.138/2/1000;
    x=rob_r*cosd(theta);
    y=rob_r*sind(theta);
    X=X+x;
    Y=Y+y;
    %Xk = state vector
    Xk=[X;Y;theta];
    
    %Gather Laser Data
    dat=[];
    for j=1:681
        tline= fgets(fid);
        tline=str2num(tline);
        dat=[dat tline];
    end
    
    %Feature Extraction
    z=5;
    featno=0;
    while (z<675)
    dat1=dat(z);
    i1=z;
    while (z<675)
        dis=dat(z+5)-dat(z);
        if abs(dis) < 0.3
            z=z+5;
            continue
        end
            dat2=dat(z-5);
			X1 = dat1*100*cosd(alpha(i1));
			Y1 = dat1*100*sind(alpha(i1));
			X2 = dat2*100*cosd(alpha(z-5));
			Y2 = dat2*100*sind(alpha(z-5));
			length=sqrt((X2-X1)^2+(Y2-Y1)^2);
			centerx=(X1+X2)/200.0;
			centery=(Y1+Y2)/200.0;
 			if length >= 48 && length <=51
                 if centerx < 0
                     z=z+5;
                     break;
                 end
                 centx=centerx;
                 centy=centery;
                 len=length;
                 centx=centx+X;
                 centy=centy+Y;
                 featno=1;
            end
			z=z+5;
			break
    end
    end
     if featno==0
         continue
     end
    
    rm=sqrt((centx-X)^2+(centy-Y)^2);
    thetam=atan((centy-Y)/(centx-X));
    thetam=thetam*180/pi;
    Zk=[rm; thetam];

    centx
    centy

end
