clc; clear all; close all;
load lasandodo_data;

[r_las,c_las]=size(las_dat);
[r_odo,c_odo]=size(odo_dat);
ACdelTh=0;
alpha=linspace(0+ACdelTh,pi+ACdelTh,511);
% pt_dis is the distance between two points for a line to exist 
% lin_bk is the distance between two points for a new line to start
% num_pt is the minimum number of points for a line to exist
% dev is the deviation allowed for fitting line
pt_dis=0.03; lin_bk=0.1; num_pt=5; dev=0.08;
slp=[]; incep=[]; % Initializing slope and intercept of line
for i1=1:r_las
    [ex,why]=polar_rectangular(las_dat(i1,2:c_las),alpha);
    [re_x,re_y,st_pt,en_pt]=resample_linepts(ex,why,pt_dis,lin_bk);
    % To find minimum points needed for a line to exist
    num_sten=en_pt-st_pt+1;
    % The minmum number of points for a line to exist is num_pt (num_sten)
    for i2=1:length(num_sten) 
        if num_sten(i2)>=num_pt
            [slp1,incep1]=line_fitting(re_x(st_pt(i2):en_pt(i2)),re_y(st_pt(i2):en_pt(i2)),dev);
            slp=[slp slp1]; incep=[incep incep1];
        end
            
        
    end
    

    pause
end