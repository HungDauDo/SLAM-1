clear dat_las dat_odo;
dat_las=load('laserdata.txt');
[r_las,c_las]=size(dat_las);
dat_odo=load('ododata.txt');
[r_odo,c_odo]=size(dat_odo);
