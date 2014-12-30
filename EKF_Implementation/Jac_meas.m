function Jmeas=Jac_meas(Zmod,Xnow,Tas_re); % Measurement model Jacobian

siz=size(Zmod);
Jmeas=[];
for i=1:siz(2)
    Jmeas=[(Xnow(1)-Tas_re(1,i))/Zmod(1,i) (Xnow(2)-Tas_re(2,i))/Zmod(1,i) 0;(Tas_re(2,i)-Xnow(2))/Zmod(1,i)^2 (Tas_re(1,i)-Xnow(1))/Zmod(1,i)^2 -1];
end
if isempty(Jmeas)
    Jmeas=[];
end
end
