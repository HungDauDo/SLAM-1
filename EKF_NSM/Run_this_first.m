dat_las=load('laserdata.txt');
dat_odo=load('ododata.txt');

fil=size(dat_las);
for d1=1:fil(1)
    dat_las(d1,[2:fil(2)])=medfilt1(dat_las(d1,[2:fil(2)]),10);
end

save lasandodo_data dat_las dat_odo;
