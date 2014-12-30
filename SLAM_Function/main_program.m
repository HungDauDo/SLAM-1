
clear all;
clc;
close all;
fe_x=0;
fe_y=0;
load_data;
alpha=linspace(-30,210,682);
for i1=1:r_odo
    laser_plot;
    laser_resamp;
    figure(1);
%     plot(ex,why,'ok','markersize',4); 

    plot(re_x,re_y,'ok','markersize',4); 
    hold on;
    line_fit;
    feature_extraction;
    data_association;
    hold off;
    pause;
end
