function [re_alf,po_alf,re_cor,po_cor]=GroupAndCorr(re_past,re_now)
all=[]; past=[]; now=[];
Psiz=size(re_past); Nsiz=size(re_now);
len=Psiz(2)+Nsiz(2);
i=1;j=1;k=1;
if ~isempty(re_past)&&~isempty(re_now)
    while k<len
        
     
        
        
        
        
        
        ecd=sqrt((now(1,at)-past(1,bt))^2+(now(2,at)-past(2,bt))^2);