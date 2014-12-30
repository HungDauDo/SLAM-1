close all; clear all; clc;
load lasodo_dat;
[r_las,c_las]=size(las_dat);
[r_odo,c_odo]=size(odo_dat);

pl_tic=abs(odo_dat(1,2));
pr_tic=abs(odo_dat(1,3));
k=1;
Xrob(k)=0.4; Yrob(k)=1.28; the(k)=pi/2;
delTh=0; ACdelTh(k)=0;
k=k+1;
wid=0.257;
for i1=2:500
    cl_tic=abs(odo_dat(i1,2));
    cr_tic=abs(odo_dat(i1,3));
    dlw=(cl_tic-pl_tic)*0.10375/1000;
    drw=(cr_tic-pr_tic)*0.1046875/1000;
    pl_tic=cl_tic;
    pr_tic=cr_tic;
    delS=(drw+dlw)/2;
    delTh=(drw-dlw)/wid;
    delX=delS*cos(the(k-1)+(delTh/2));
    delY=delS*sin(the(k-1)+(delTh/2));
%     if delTh~=0
%         tem=delS/delTh;
%         delX=tem*(sin(the(k-1)+delTh)-sin(the(k-1)));
%         delY=tem*(cos(the(k-1)+delTh)-cos(the(k-1)));
%     else
%         delX=delS*cos(the(k-1));
%         delY=delS*sin(the(k-1));        
%     end
    Xrob(k)=Xrob(k-1)+delX;
    Yrob(k)=Yrob(k-1)+delY;
    the(k)=the(k-1)+delTh;
    ACdelTh(k)=(pi/2)-abs(the(k));
%     ACdelTh(k)=ACdelTh(k-1)+delTh;
    k=k+1;
end
save robot_pos Xrob Yrob the ACdelTh;
figure(1);
plot(Xrob,Yrob,'Xk','markersize',5);