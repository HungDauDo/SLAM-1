clear all;
close all;
clc;
load_data;
alpha=linspace(-30,210,682);
fe_x=0;fe_y=0;
ct=0;
full_fex=[];full_fey=[];
for p1=46:r_odo
    rw_las=dat_las(p1,[2:c_las]);
    mf_las=medfilt1(rw_las,10);
%     figure(1);
%     subplot(2,1,1);
%     plot(rw_las);
%     subplot(2,1,2);
%     plot(mf_las,'b*-');
    in_las=rw_las;
    laser_plot_after_filter;
    ex1=ex;why1=why;
    in_las=mf_las;
    laser_plot_after_filter;
    ex2=ex;why2=why;
%     figure(2);
%     subplot(2,1,1);
%     plot(ex1,why1,'ob','markersize',2);
%     subplot(2,1,2);
%     plot(ex2,why2,'xk','markersize',8);
    
    d_alp=alpha;
    d_las=mf_las;
    ex=ex2;why=why2;
    laser_resamp;
%     figure(3);
%     plot(re_x,re_y,'xk','markersize',8);
    extra_point_remove;
%     figure(4);
%     plot(f_x,f_y,'xk','markersize',8);  
    data_embedding;
%     figure(5);
%     plot(f_x,f_y,'r*',ed_x,ed_y,'bO');
    ex=ed_x;why=ed_y;   
    laser_resamp;
    figure(6);
    plot(re_x,re_y,'bx');
%     hold on;
%     line_fit;
%     feature_extraction;
%     data_association;
%     hold off;
%     
%      full_fex=[full_fex,mfe_x]
%      full_fey=[full_fey,mfe_y]
%             
%     for i=1:length(mfe_x)
%         if mfe_x(i)~=0&&mfe_y(i)~=0
%             ct=ct+1;
%            
%         end
%     end
%     srk_compress_image;
    pause;
end