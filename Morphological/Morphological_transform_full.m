clear all;
close all;
clc;
load_data;
alpha=linspace(0,180,511);
fe_x=0;fe_y=0;
ct=0;
full_fex=[];full_fey=[]; 
lenh1=0;lenh2=0;
for p1=75:r_odo
    rw_las=dat_las(p1,[2:c_las]);
    mf_las=medfilt1(rw_las,10);
    in_las=rw_las;
    laser_plot_after_filter;
    ex1=ex;why1=why;
    in_las=mf_las;
    laser_plot_after_filter;
    ex2=ex;why2=why;  
    d_alp=alpha;
    d_las=mf_las;
    ex=ex2;why=why2;
    laser_resamp;
    extra_point_remove;
    data_embedding;
    ex=ed_x;why=ed_y;   
    laser_resamp;
%     figure(5);
%     plot(re_x,re_y,'bx');
    morphological_trans1;
    
    pause;
end