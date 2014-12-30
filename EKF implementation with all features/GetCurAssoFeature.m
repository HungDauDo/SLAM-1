function [as_po,as_re,anw_po,anw_re,po_all,re_all] = GetCurAssoFeature(past,now,po_past,po_now)

a=size(now);
afe_x=[];afe_y=[];afe_r=[];afe_ta=[];as_re=[];as_po=[];anw_re=[];anw_po=[];
nafe_x=[];nafe_y=[];nafe_r=[];nafe_ta=[];
tol=0.1;
r1=1;
k=1;
for at=1:a(2)
    k=1; b=size(past); re_pst=[]; po_pst=[]; re_nw=[]; po_nw=[];
    for bt=1:b(2)
        ecd=sqrt((now(1,at)-past(1,bt))^2+(now(2,at)-past(2,bt))^2);
        if ecd<=tol
            afe_x(r1)=past(1,bt);
            afe_y(r1)=past(2,bt);
            afe_r(r1)=po_past(1,bt);
            afe_ta(r1)=po_past(2,bt);
            
            nafe_x(r1)=now(1,at);
            nafe_y(r1)=now(2,at);
            nafe_r(r1)=po_now(1,at);
            nafe_ta(r1)=po_now(2,at);
            r1=r1+1;
        else
            re_pst(1,k)=past(1,bt);
            re_pst(2,k)=past(2,bt);
            po_pst(1,k)=po_past(1,bt);            
            po_pst(2,k)=po_past(2,bt);
            k=k+1;
        end
    end
    past=[]; po_past=[];
    past=re_pst; po_past=po_pst;
end
as_re=[afe_x;afe_y];
as_po=[afe_r;afe_ta];
anw_re=[nafe_x;nafe_y];
anw_po=[nafe_r;nafe_ta];

if ~isempty(past)&&~isempty(now)
    X_all=[past(1,:) now(1,:)];
    Y_all=[past(2,:) now(2,:)];
    [X_all,Y_all]=unique_tol(X_all,Y_all,tol);
    re_all=[X_all;Y_all];
    r=sqrt(X_all.^2+Y_all.^2);
    ta=atan2(Y_all,X_all);
    po_all=[r;ta];
elseif isempty(past)&&isempty(now)
    re_all=[];
    po_all=[];
elseif isempty(past)&&~isempty(now)
    X_all=now(1,:);
    Y_all=now(2,:);
    re_all=now;
    r=sqrt(X_all.^2+Y_all.^2);
    ta=atan2(Y_all,X_all);
    po_all=[r;ta];
else
    X_all=past(1,:);
    Y_all=past(2,:);
    re_all=past;
    r=sqrt(X_all.^2+Y_all.^2);
    ta=atan2(Y_all,X_all);
    po_all=[r;ta];
    
end

end