function [xf,yf]=extpt_method(re_x,re_y,Spt,Enpt)
xf=[];yf=[]; % Initialize slope and intercept for each scan

% % This was done to include start and end points also as feature
% xf=[re_x(Spt) re_x(Enpt)];yf=[re_y(Spt) re_y(Enpt)]; % Initialize slope and intercept for each scan
% % This was done to include start and end points also as feature

len=length(Spt);
for i1=1:len
    x=re_x(Spt(i1):Enpt(i1));
    y=re_y(Spt(i1):Enpt(i1));
    [xfe,yfe]=sten_fit(x,y);
    xf=[xf xfe];
    yf=[yf yfe];
end

[xf,yf]=unique_tol(xf,yf,0.1);
end
