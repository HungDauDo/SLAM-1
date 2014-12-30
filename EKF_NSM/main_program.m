clear all; clc; close all;
load lasodo_dat; 
load robot_pos;
[r_las,c_las]=size(las_dat);
[r_odo,c_odo]=size(odo_dat);

fe_x=0;
fe_y=0;

alpha=linspace(0,180,511);
for i1=42:43
    laser_plot;
    laser_resamp;
    
%     Arob=atan(Yrob(i1)/Xrob(i1));
%     if isnan(Arob)
%         Arob=0;
%     end
    figure(1);
    plot(re_x,re_y,'ok','markersize',4); 
    
%     re_x=re_x*cos(ACdelTh(i1))-re_y*sin(ACdelTh(i1))+Xrob(i1);
%     re_y=+re_x*sin(ACdelTh(i1))+re_y*cos(ACdelTh(i1))+Yrob(i1);
%     
%     figure(1);
    hold on;
%     plot(re_x,re_y,'ok','markersize',4); 
    %plot(re_x,re_y,'ok','markersize',4); 
%     line_fit1;
%     feature_extraction;
%     data_association;
    pause;
%     clf;
end
