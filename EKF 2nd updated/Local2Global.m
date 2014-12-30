function past_reG=Local2Global(Xnow,pastL,nowL)

past_poL=[pastL nowL];
siz=size(past_poL);

for i=1:siz(2)
    Gx(i)=past_poL(1,i)*cos(past_poL(2,i)-((pi/2)-Xnow(3)))+Xnow(1);
    Gy(i)=past_poL(1,i)*sin(past_poL(2,i)-((pi/2)-Xnow(3)))+Xnow(2);    
end

[Gx,Gy]=unique_tol(Gx,Gy,0.15);
past_reG=[Gx;Gy];

end