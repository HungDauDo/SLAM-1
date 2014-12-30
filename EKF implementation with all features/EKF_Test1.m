% First run the file named Run_this_first.m and then execute this program

clear all; close all; clc;
% load lasandodo_data_corridor; % File containing las_dat, odo_dat
load lasandodo_data_maze1; % File containing las_dat, odo_dat
[r_las,c_las]=size(las_dat);
[r_odo,c_odo]=size(odo_dat);

pas_re=[]; pas_po=[]; cas_re=[]; cas_po=[]; re_apf=[]; po_apf=[]; po_past=[]; re_past=[];
delTh=0; ACdelTh=0; wid=0.257;

% Xnow = [0 0 pi/2]; % Start position (x, y, theta) for corridor
Xnow = [0.5 1.28 pi/2]; % Start position (x, y, theta) for maze
Jmeas=[];

% Get the initial observation through LRF
[po_now,re_now,re_x,re_y] = GetObservation(las_dat(1,2:c_las),ACdelTh);
po_past=po_now; re_past=re_now;
Xpast=Xnow;
% Get the initial observation through LRF

PEst = diag([0.1 0.1 0.07]); % start with a medium covariance (Attention EKF need a good initialization)
PriCov=PEst;
dum=1;
for k=2:1500
    [Xnow, ACdelTh,delX,delY,delTh] = GetOdometry(odo_dat(k-1:k,:),Xpast,ACdelTh);
    [po_now,re_now,re_x,re_y] = GetObservation(las_dat(k,2:c_las),ACdelTh);
    [pas_po,pas_re,cas_po,cas_re,po_all,re_all] = GetCurAssoFeature(re_past,re_now,po_past,po_now); % Get the current associated features  
    
    po_all
    cas_po
    if ~isempty(pas_re)
        pas_re(1,:)=pas_re(1,:)+Xpast(1);
        pas_re(2,:)=pas_re(2,:)+Xpast(2);
        Zmod=GetObsModel(Xnow,pas_re,pas_po,delTh);  % Get observation model
        Jodo=[1 0 -delY;0 1 delX;0 0 1];
        Q=[(normrnd(0,0.05))^2 0 0;0 (normrnd(0,0.05))^2 0;0 0 (normrnd(0,0.0349))^2];        
        PriCov=Jodo*PriCov*Jodo'+Q;
        Innov=cas_po-Zmod;
        tem=size(Innov);
        for i=1:tem(2)
            Jmeas=Jac_meas(Zmod(:,i),Xnow,pas_re(:,i)); % Measurement model Jacobian
            R=[(normrnd(0,0.01))^2 0; 0 0.015];
            imt=inv((Jmeas*PriCov*Jmeas')+R);
            Kgain=PriCov*Jmeas'*imt;
            Xnow=XCorrec(Xnow,Kgain,Innov(:,i));
            PriCov=(eye(3,3)-(Kgain*Jmeas))*PriCov;
        end
        po_past=po_all; re_past=re_all;
        Xpast=Xnow;        
    else
        po_past=po_all; re_past=re_all;
        Xpast=Xnow;
    end
    PriCov
    dum=dum+1;
    if dum>1
        figure(2)
        hold on;
        plot(re_x+Xnow(1),re_y+Xnow(2),'.k');
        plot(Xnow(1),Xnow(2),'.k');
        dum=1;
        pause;
    end
end