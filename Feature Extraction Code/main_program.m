clear all; clc; close all;
load lasandodo_data; 
[r_las,c_las]=size(las_dat);
[r_odo,c_odo]=size(odo_dat);

fe_x=0;
fe_y=0;

alpha=linspace(0,pi,511);
for i1=1:3600
%     alpha=linspace(0-ACdelTh(i1),pi-ACdelTh(i1),511);
    laser_plot;
    laser_resamp;
%     re_x=re_x+Xrob(i1); re_y=re_y+Yrob(i1);
    figure(1);
    plot(re_x,re_y,'ok','markersize',4);
    hold on;
    line_fit2;
    feature_extraction;
    data_association;

    pause;
    clf;
end
