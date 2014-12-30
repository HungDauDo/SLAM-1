clear f_x f_y;
d=1;
ka=1;
while ka<length(re_x)
    d2=sqrt((re_x(ka+1)-re_x(ka))^2+(re_y(ka+1)-re_y(ka))^2);
    if d2<=0.4
        f_x(d)=re_x(ka);
        f_y(d)=re_y(ka);
        d=d+1;
    end
    ka=ka+1;
end