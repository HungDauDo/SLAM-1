load lasandodo_data;
[r_las,c_las]=size(dat_las);
[r_odo,c_odo]=size(dat_odo);

k1=1;
for i=1:r_las
    a=dat_las(i,1)-dat_odo(:,1);
    [m,in]=min(abs(a));
    odo_dat(k1,:)=dat_odo(in,:);
    las_dat(k1,:)=dat_las(k1,:);
    k1=k1+1;
end
save lasodo_dat odo_dat las_dat;