%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [z] = GetObservation(las_dat,ACdelTh)

z =[]; 

% get all landfeatures and tested each
  
    alpha=linspace(0+ACdelTh,pi+ACdelTh,511);
    laser_plot;
    laser_resamp;
    re_x=re_x+Xrob; re_y=re_y+Yrob;
    
    line_fit2;
    feature_extraction;
    data_association;
    r=sqrt((mfe_x^2)+(mfe_y^2))
    zTemp=[mfe_x mfe_y];
    if (mfe_x==0 && mfe_y==0)
    else        
        z=zTemp; % copy calculated observation
    end
end
