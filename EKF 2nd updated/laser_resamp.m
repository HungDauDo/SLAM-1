% Resampling of the laser data i.e. discard data points with ecludian distance less than 3cm.
% Store the starting and ending index of line break if the distance between two points is greater than 10cm.
clear re_x re_y re_las re_alp st_pt en_pt;
k2=1;
i2=1;
dum=i2+1;
j2=1;
re_x(k2)=ex(i2);
re_y(k2)=why(i2);
st_pt(j2)=k2;
while (dum<=length(ex)-1)
    ec_dis=sqrt((ex(i2)-ex(dum))^2+(why(i2)-why(dum))^2);
    if (ec_dis>=0.03)
        if (ec_dis>=0.1)
            st_pt(j2+1)=k2+1;
            en_pt(j2)=k2;
            j2=j2+1;
        end        
        k2=k2+1;
        re_x(k2)=ex(dum);
        re_y(k2)=why(dum);
        i2=dum;
        dum=dum+1;
    else
        dum=dum+1;
    end
end
en_pt(j2)=k2;


