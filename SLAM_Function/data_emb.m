function [xn,yn,N]=data_emb(x,y)

dist=sqrt((x(1)-x(2))^2+(y(1)-y(2))^2);
dist_min=0.01;
N=round(dist/dist_min);
if N>2 && N<25
     xn=linspace(x(1),x(2),N);
     yn=linspace(y(1),y(2),N);
     
 else
     xn=x;
     yn=y;
     N=0;
 end
end


