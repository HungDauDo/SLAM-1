clear all;
dat_las=load('laserdata.txt');
dat_odo=load('ododata.txt');
siz=size(dat_las);

k1=1;
for i=1:siz(1)
    a=dat_las(i,1)-dat_odo(:,1);
    [m,in]=min(abs(a));
    odo_dat(k1,:)=dat_odo(in,:);
    las_dat(k1,:)=dat_las(k1,:);
    k1=k1+1;
end
save lasandodo_data_maze2 las_dat odo_dat;
