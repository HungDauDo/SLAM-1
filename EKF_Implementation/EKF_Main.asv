% First run the file named Run_this_first.m and then execute this program

clear all; close all; clc;
load lasandodo_data; % File containing las_dat, odo_dat
[r_las,c_las]=size(las_dat);
[r_odo,c_odo]=size(odo_dat);

delTh=0; ACdelTh=0; wid=0.257;

NFeatures=50;
LandFeatures = zeros(2,1,NFeatures);
MapFeatures = NaN*zeros(NFeatures,2); % Space for mapped features
OAsf_re=[];OAsf_po=[]; %Initialize array for Old Associated features in rectangular global coordinates & polar local coordinates
CAsf_re=[];CAsf_po=[]; %Initialize array for Current Associated features in rectangular global coordinates & polar local coordinates
NAsf_re=[];NAsf_po=[]; %Initialize array for New Associated features in rectangular global coordinates & polar local coordinates
AAsf_re=[];AAsf_po=[]; %Initialize array for All Associated features in rectangular global coordinates & polar local coordinates
Xnow = [0.5 1.28 pi/2]; % Start position (x, y, theta)

% Get the initial observation through LRF and the initial association of
% features with a second observation
[po_now,re_now] = GetObservation(las_dat(1,2:c_las),ACdelTh);
po_past=po_now; re_past=re_now;
Xpast=Xnow;

[Xnow, ACdelTh] = GetOdometry(odo_dat(1:2,:),Xpast,ACdelTh);
Xpast=Xnow;
[po_now,re_now] = GetObservation(las_dat(2,2:c_las),Xnow,ACdelTh);
[Tas_po,Tas_re] = GetCurAssoFeature(re_past,re_now,po_now); % Get the current associated features
po_past=po_now; re_past=re_now;
CAsf_re=Tas_re; CAsf_po=Tas_po;
AAsf_re=[OAsf_re CAsf_re NAsf_re];

% Get the initial observation through LRF and the initial association of
% features with a second observation

PEst = diag([1 1 0.01]); % start with a medium covariance (Attention EKF need a good initialization)

% Standart deviation errors added to control
UTrue = diag([0.01,0.01,1.5*pi/180]).^2;

% Standard deviation errors regarding observation
RTrue = diag([1.1,5*pi/180]).^2;


for k=3:100
    [Xnow, ACdelTh] = GetOdometry(odo_dat(k-1:k,:),Xpast,ACdelTh);
    % Get observation model
    Zmod=GetObsModel(Xpast,Xnow,CAsf_po)
    
    
    Xpast=Xnow;
    [po_now,re_now] = GetObservation(las_dat(k,2:c_las),Xnow,ACdelTh);
    [Tas_po,Tas_re] = GetCurAssoFeature(re_past,re_now,po_now); % Get the current associated features
    po_past=po_now; re_past=re_now;    
    CAsf_re=Tas_re; CAsf_po=Tas_po;
%     if isempty(AAsf_re)
%         CAsf_re=Tas_re; CAsf_po=Tas_po;
%     elseif isempty(Tas_re)
%     else
%         [OAsf_re,CAsf_re,NAsf_re]=GetAssoFeature(AAsf_re,Tas_re);
%     end
%     AAsf_re=[OAsf_re CAsf_re NAsf_re];
    
    
    
    pause

end