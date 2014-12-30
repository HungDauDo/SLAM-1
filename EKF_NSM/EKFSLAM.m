%% Extended kalman filter
function EKFSLAM
% Clear all
close all; clear all;

load lasodo_dat; 
[r_las,c_las]=size(las_dat);
[r_odo,c_odo]=size(odo_dat);

pl_tic=abs(odo_dat(1,2));
pr_tic=abs(odo_dat(1,3));

delTh=0; ACdelTh=0;
wid=0.257;

% Global variables (avoid extra copies)
global xVehicleTrue;
global LandFeatures;
global LaserSensorSettings;
global VisionSensorSettings; % for latter incorporation id possible
global xOdomLast;
global nSteps;
global UTrue;


% Length of the experiment
nSteps =r_odo; % change to extend the lentgh of the simulation

nLandFeatures =25;

% Make some spare for then
LandFeatures = zeros(2,1,nLandFeatures);


% Initial position of the vehicle
xVehicleTrue = [0.4 1.28 pi/2]'; % start position (x, y, theta)

% Set the initial conditions of the filter
xEst =[xVehicleTrue]; % already an columm vector
PEst = diag([1 1 0.01]); % start with an medium covar ( Atention EKF need an good initialization)

% Make some space to save the Landmarks detected (arraylist (x,y)
MappedLandFeatures = NaN*zeros(nLandFeatures,2);

% Standart deviation errors added to control
UTrue = diag([0.01,0.01,1.5*pi/180]).^2;

% Standard deviation errors regarding observation
RTrue = diag([1.1,5*pi/180]).^2;

% Aditive factor for control estimation and noise
UEst = 2.0*UTrue;
REst = 2.0*RTrue;

% All Setup and ready to go
% Extract first odometry for predict
xOdomLast=xEst;

for k = 2:nSteps
    
    [xOdomNow, ACdelTh] = GetOdometry(odo_dat(k-1:k,:),xOdomLast,ACdelTh);

    xOdomLast = xOdomNow; % refresh odometry vector
    
    % extract the two compoments of the estimation ( Vehicle and
    % landfeatures
    % get vehicle estimation
    xVehicle = xEst(1:3); % estimated only the part for the vehicle
    % get landferatures estimation
    xMap = xEst(4:end); % Landfeatures estimation are the rest ones
 
    
    %do prediction (the following is simply the result of multiplying 
    %out block form of jacobians)     
    xVehiclePred = xVehicle; % estimation is regarding current and control vector
    % covariance for vehicle
    %J2 is just an simple rotation matrix over x
    % just need to change to the cnematic model and speeds
    
    % Change this!!!
    PPredvv = J1(xVehicle)* PEst(1:3,1:3) *J1(xVehicle)' + J2(xVehicle)* UEst * J2(xVehicle)';
    % vehicle/ landmarks,
    PPredvm = J1(xVehicle)*PEst(1:3,4:end);
    % For the rest just extract (landfeatures
    PPredmm = PEst(4:end,4:end);
    
    % agregates robot prediction and beacons
    xPred = [xVehiclePred;xMap];
%     % Compose the covariance matrix
%          Ppred = |Pvv Pvm
%                  |Pvm' Pmm
    PPred = [PPredvv PPredvm;
        PPredvm' PPredmm];
       

    % Get the observation (passing noise to be added and Noise true
    z = GetObservation(las_dat(k,:),ACdelTh);
    
   
     if(~isempty(z)) % if i get an valid observation
            
            % Extract feature values in state vector
            xFeature = xPred(4:5);
            
            % predict the observation
            zPred = DoObservationModel(xVehicle,xFeature);
            
            % get observation Jacobians
            [jHxv,jHxf] = GetObsJacs(xVehicle,xFeature);
            
            % fill in state jacobian
            jH = zeros(2,length(xEst));
            jH(:,4:5) = jHxf;
            jH(:,1:3) = jHxv;
            
            %do Kalman update:
            % check for inovation (here we can use the validation gate
            Innov = z-zPred;
            % angles have always to be checked only betwewn 0 an 2Pi
            Innov(2) = AngleWrapping(Innov(2));
            
            S = jH*PPred*jH'+REst;
            W = PPred*jH'*inv(S); 
            xEst = xPred+ W*Innov;
            
            PEst = PPred-W*S*W'
            
            %ensure P remains symmetric
            PEst = 0.5*(PEst+PEst');
        else
            % this is a new feature
            
            % extract length of the current tracking landmarks
            nStates = length(xEst); 
            
            % Compute the x,y position of the landmark x,y robot plus
            % Xxvehicle +distance*cos(angle + Xthvehicle)
            % Xyvehicle + distance* sin(angle + Xthvehicle)
            xFeature = xVehicle(1:2)+ [z(1)*cos(z(2)+xVehicle(3));z(1)*sin(z(2)+xVehicle(3))];
            xEst = [xEst;xFeature]; %add to state vector estimated
            % compute jacobians regaing feature and observation 
            [jGxv, jGz] = GetNewFeatureJacs(xVehicle,z); 
            
            % M=| 1 0 0  0 0
            %   | 0 1 0  0 0
            %   | 0 0 1  0 0
            %   -------------
            %   |
            
            M = [eye(nStates), zeros(nStates,2);% no use jacobian w.r.t vehicle
                jGxv zeros(2,nStates-3)  , jGz];
            
            PEst = M*blkdiag(PEst,REst)*M';
            
            %remember this feature as being mapped we store its ID and position in the state vector
            MappedLandFeatures(iFeature,:) = [length(xEst)-1, length(xEst)];
            
        end;
        xEst = xPred;
        PESt = PPred;
        pause
end
end












