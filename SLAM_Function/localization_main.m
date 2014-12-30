clear all;
close all;
clc;
load_data;
alpha=linspace(-30,210,682);
fe_x=0;fe_y=0;
ct=0;
full_fex=[];full_fey=[];
X=0;Y=0;

%start at 130 for p1
for p1=530:r_odo
    rw_las=dat_las(p1,[2:c_las]);
    mf_las=medfilt1(rw_las,10);
    
    if p1~=100
    tik_l=dat_odo(p1+1,2)-dat_odo(p1,2);
    tik_r=dat_odo(p1+1,3)-dat_odo(p1,3);
    theta=90;
    if (tik_l<0 && tik_r<0)||(tik_l>0 && tik_r>0)
        d_l=tik_l*0.138;
        d_r=tik_r*0.138;
        avg_dr=(d_l+d_r)/(2*1000);
        x_r=avg_dr*cosd(theta);
        y_r=avg_dr*sind(theta);
        X=X+x_r;
        Y=Y+y_r;
    end
    end
    
    in_las=mf_las;
    laser_plot_after_filter;
    ex2=ex;why2=why;
    d_alp=alpha;
    d_las=mf_las;    
    ex=ex2;why=why2;
    laser_resamp;
    extra_point_remove;
    data_embedding;
    ex=ed_x+X;why=ed_y+Y;
    laser_resamp;
    line_fit;
    feature_extraction;

    data_association;
    full_fex=[full_fex,mfe_x]
    full_fey=[full_fey,mfe_y]
            
    for i=1:length(mfe_x)
        if mfe_x(i)~=0&&mfe_y(i)~=0
            ct=ct+1;           
        end
    end
    figure(1);
    hold on;
    plot(re_x,re_y,'xk','markersize',8);
    plot(mfe_x,mfe_y,'xk','LineWidth',2,'markersize',10);

    pause;
end