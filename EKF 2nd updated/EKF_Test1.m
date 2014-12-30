% First run the file named Run_this_first.m and then execute this program

clear all; close all; clc;
% load lasandodo_data_corridor; % File containing las_dat, odo_dat
load lasandodo_data_maze1; % File containing las_dat, odo_dat
[r_las,c_las]=size(las_dat);
[r_odo,c_odo]=size(odo_dat);

dum=1;
pas_poL=[]; cas_poL=[]; re_pastG=[];
delTh=0; ACdelTh=0;

% Xnow = [0 0 pi/2]; % Start position (x, y, theta) for corridor
Xnow = [0.5 1.28 pi/2]; % Start position (x, y, theta) for maze
Jmeas=[];
start=1;
% Get the initial observation through LRF
[re_nowL,po_nowL,re_x,re_y] = GetObservation(las_dat(start,2:c_las));
% First observation re_nowL is global (initial condition)
re_pastG=re_nowL;
re_pastG(1,:)=re_pastG(1,:)+Xnow(1);
re_pastG(2,:)=re_pastG(2,:)+Xnow(2);
re_pastG

Xpast=Xnow;
% First observation re_nowL is global (initial condition)

PEst = diag([0.001 0.001 0.0025]); % start with a medium covariance (Attention EKF need a good initialization)
PriCov=PEst;


for k=start+1:1500
    [Xnow, ACdelTh,delX,delY,delTh] = GetOdometry(odo_dat(k-1:k,:),Xpast);
    po_pastL=GetObsModel(Xnow,re_pastG);
    po_pastL
    [re_nowL,po_nowL,re_x,re_y] = GetObservation(las_dat(k,2:c_las));
    po_nowL
    [pas_poL,cas_poL,pas_reG] = GetCurAssoFeature(po_pastL,po_nowL,re_nowL,re_pastG); % Get the current associated features
    pas_poL
    cas_poL
    if ~isempty(cas_poL)
        Jodo=[1 0 -delY;0 1 delX;0 0 1];
        Q=[(normrnd(0,0.03))^2 0 0;0 (normrnd(0,0.03))^2 0;0 0 (normrnd(0,0.0349))^2];        
        PriCov=Jodo*PriCov*Jodo'+Q;
        Innov=cas_poL-pas_poL;
        tem=size(Innov);
        for i=1:tem(2)
            Jmeas=Jac_meas(Xnow,pas_reG(:,i)); % Measurement model Jacobian
            R=[(normrnd(0,0.005))^2 0; 0 0.0349];
            imt=inv((Jmeas*PriCov*Jmeas')+R);
            Kgain=PriCov*Jmeas'*imt;
            Xnow=XCorrec(Xnow,Kgain,Innov(:,i));
            PriCov=(eye(3,3)-(Kgain*Jmeas))*PriCov;
        end
    end
    re_pastG=Local2Global(Xnow,po_pastL,po_nowL)    
    Xpast=Xnow;
    dum=dum+1;
    if dum>1
        figure(2)
        hold on;
        plot(Xnow(1),Xnow(2),'.k');
        dum=1;
        pause;
    end
end