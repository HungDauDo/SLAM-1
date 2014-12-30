function Zmod=GetObsModel(Xnow,Past_re)
siz=size(Past_re);
if ~isempty(Past_re)
    for i=1:siz(2)
        R_Mod(i)=sqrt((Xnow(1)-Past_re(1,i))^2+(Xnow(2)-Past_re(2,i))^2);
        Th_Mod(i)=(pi/2)+atan2(Past_re(2,i)-Xnow(2),Past_re(1,i)-Xnow(1))-Xnow(3);
    end
    Zmod=[R_Mod;Th_Mod];
else
    Zmod=[];
end
end


