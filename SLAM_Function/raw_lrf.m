clear all;
close all;
clc;
load_data;
alpha=linspace(-30,210,682);

for p1=1:r_odo
    rw_las=dat_las(p1,[2:c_las]);
    mf_las=medfilt1(rw_las,10);
    figure(1);
    subplot(2,1,1);
    plot(rw_las);
    subplot(2,1,2);
    plot(mf_las);
    in_las=rw_las;
    laser_plot_after_filter;
    ex1=ex;why1=why;
    in_las=mf_las;
    laser_plot_after_filter;
    ex2=ex;why2=why;
    figure(2);
    subplot(2,1,1);
    plot(ex1,why1,'ob','markersize',2);
    subplot(2,1,2);
    plot(ex2,why2,'xk','markersize',8);
    
    % moving average
    a = 1;
    b = 0.1*ones(1,5);
    mv_rw_las=filter(b,a,rw_las);
    mv_mf_las=filter(b,a,mf_las);
    figure(3);
    subplot(2,1,1);
    plot(mv_rw_las);
    subplot(2,1,2);
    plot(mv_mf_las);   
    
    in_las=mv_rw_las;
    laser_plot_after_filter;
    ex3=ex;why3=why;
    in_las=mv_mf_las;
    laser_plot_after_filter;
    ex4=ex;why4=why;
    figure(4);
    subplot(2,1,1);
    plot(ex3,why3,'ob','markersize',2);
    subplot(2,1,2);
    plot(ex4,why4,'xk','markersize',8);
    
    d_alp=alpha;
    d_las=mf_las;
    ex=ex2;why=why2;
    laser_resamp;
    figure(5);
    plot(re_x,re_y,'xk','markersize',8);
    
    
    figure(6);
    plot(ex1,why1,'ob','markersize',2);
    figure(7);
    plot(ex2,why2,'xk','markersize',8);
    
    
    pause;
end