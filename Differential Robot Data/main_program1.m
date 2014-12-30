clear all;
clc;
close all;
WorldSize =8;
fe_x=0;
fe_y=0;
load_data;
alpha=linspace(0,180,c_las-1);
for i1=1:r_odo
    laser_plot;
%     laser_resamp;
    figure(1);
    plot(ex,why,'ok','markersize',4);
    axis([-WorldSize/2 WorldSize/2 -WorldSize/2 WorldSize/2]);
    pause(0.1);
    clf;
end
