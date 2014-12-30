clear l_lin slop incep;
i3=1;
num_pt=6; dev=0.08;
l_lin=en_pt-st_pt+1;
for kd=1:length(l_lin)
    rem=l_lin(kd);
    f_dat=st_pt(kd);
    tot=f_dat+num_pt-1;
    while (tot<=en_pt(kd)&&l_lin(kd)>=8)
        x_las=re_x(f_dat:tot);
        y_las=re_y(f_dat:tot);
        [p_lin,er]=polyfit(x_las,y_las,1);
        rem=rem-num_pt;
        if rem>=num_pt
            var=tot;
            cnt=0;
            for i2=1:num_pt
                var=var+1;
                d_xy=abs(re_y(var)-(p_lin(1)*re_x(var))-p_lin(2))/sqrt(p_lin(1)^2+1);
                if d_xy<=dev;
                    cnt=cnt+1;
                end
            end
            if (cnt>=round(num_pt/2))
                tot=var;
            else
                y_new=(p_lin(1).*x_las)+p_lin(2);
                slop(i3)=p_lin(1);
                incep(i3)=p_lin(2);
                i3=i3+1;
                figure(1);
                plot(x_las,y_new,'-r','markersize',4);
                f_dat=var-(num_pt-1);
                tot=f_dat+(num_pt-1);
            end
        else
            tot=tot+rem;
            x_las=re_x(f_dat:tot);
            y_las=re_y(f_dat:tot);
            [p_lin,er]=polyfit(x_las,y_las,1);
            y_new=(p_lin(1).*x_las)+p_lin(2);
            slop(i3)=p_lin(1);
            incep(i3)=p_lin(2);
            i3=i3+1;
            figure(1);
            plot(x_las,y_new,'-r','markersize',4);
            tot=tot+1;
        end
    end
    slop(i3)=0;
    incep(i3)=0;
    i3=i3+1;
end

