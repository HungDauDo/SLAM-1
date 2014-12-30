afe_x=fe_x;
afe_y=fe_y;
clear fe_x fe_y;
fe_x=0;fe_y=0;
v1=1;
kt=1;
tol=0.1;
while (kt<=length(slop)-1)
    if (slop(kt)~=0&&slop(kt+1)~=0)
        fe_x1=(incep(kt+1)-incep(kt))/(slop(kt)-slop(kt+1));
        fe_y1=slop(kt)*fe_x1+incep(kt);
        if (fe_x1>(max(re_x)+tol)||fe_y1>(max(re_y)+tol)||fe_x1<(min(re_x)-tol)||fe_y1<(min(re_y)-tol))
        else
            fe_x(v1)=fe_x1;
            fe_y(v1)=fe_y1;
            v1=v1+1;
        end
        kt=kt+1;
    else
        kt=kt+1;
    end
end
figure(1);
plot(fe_x,fe_y,'xk','LineWidth',2,'markersize',10);