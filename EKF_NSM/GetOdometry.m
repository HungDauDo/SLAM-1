function [xnow,ACdelTh] = GetOdometry(odo_dat,xpast,ACdelTh)
i1=2;
Xrob=xpast(1); Yrob=xpast(2); the=xpast(3);
cl_tic=abs(odo_dat(i1,2));
cr_tic=abs(odo_dat(i1,3));
pl_tic=abs(odo_dat(i1-1,2));
pr_tic=abs(odo_dat(i1-1,3));
dlw=(cl_tic-pl_tic)*0.124/1000;
drw=(cr_tic-pr_tic)*0.124/1000;
delS=(drw+dlw)/2;
delTh=(drw-dlw)/wid;
delX=delS*cos(the+(delTh/2));
delY=delS*sin(the+(delTh/2));
Xrob=Xrob+delX;
Yrob=Yrob+delY;
the=the+delTh;
ACdelTh=ACdelTh+delTh;
xnow(1)=Xrob; xnow(2)=Yrob; xnow(3)=the;
end