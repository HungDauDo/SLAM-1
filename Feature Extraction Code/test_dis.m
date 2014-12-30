function pts=test_dis(x1,y1,p_lin,dev)

d_xy=abs(y1-(p_lin(1)*x1)-p_lin(2))/sqrt(p_lin(1)^2+1);
d1=dev-d_xy;
pts=length(find(d1<0));


end