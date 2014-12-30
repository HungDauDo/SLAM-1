clear slp incpt;
dre_x=re_x; dre_y=re_y;
dum1=1;
while dum1<length(dre_x)
    slp(dum1)=(dre_y(dum1)-dre_y(dum1+1))/(dre_x(dum1)-dre_x(dum1+1));
    incpt(dum1)=dre_y(dum1)-(slp(dum1)*dre_x(dum1));
    dum1=dum1+1;
end
slpd=slp*180/pi;