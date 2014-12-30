function [re_f,po_f]=AppendFeat(re_f,re_now,po_f,po_now)

re_f=[re_f re_now]; % Appending old features with new one
[x,y]=unique_tol(re_f(1,:),re_f(2,:),0.1);
re_f=[x;y];

po_f=[po_f re_now] % Appending old features with new one
[r,te]=unique_tol(po_f(1,:),po_f(2,:),0.1);
po_f=[r;te];


end