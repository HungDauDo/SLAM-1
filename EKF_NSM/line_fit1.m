clear l_lin slop incep;
i3=1;
l_lin=en_pt-st_pt+1;
for kd=1:length(l_lin)
    rem=l_lin(kd);
    f_dat=st_pt(kd);
    tot=f_dat+3;
    pnt=4;
    while (tot<=en_pt(kd)&&l_lin(kd)>=8)
        x_las=re_x(f_dat:tot);
        y_las=re_y(f_dat:tot);
        [p_lin,er]=polyfit(x_las,y_las,1);
        rem=rem-pnt;
        if rem>=4
            var=tot;
            cnt=0;
            for i2=1:4
                var=var+1;
                d_xy=abs(re_y(var)-(p_lin(1)*re_x(var))-p_lin(2))/sqrt(p_lin(1)^2+1);
                if d_xy<=0.04;
                    cnt=cnt+1;
                end
            end
            if (cnt>=2)
                tot=var;
            else
                y_new=(p_lin(1).*x_las)+p_lin(2);              
%                 len=sqrt((x_las(1)-x_las(length(x_las)))^2+(y_new(1)-y_new(length(y_new)))^2);                
%                 if len>=0.15               
                    slop(i3)=p_lin(1);
                    incep(i3)=p_lin(2);
                    i3=i3+1;
                    figure(1);
                    plot(x_las,y_new,'-r','markersize',4);
%                 end
                f_dat=var-3;
                tot=f_dat+3;
            end
        else
            tot=tot+rem;
            x_las=re_x(f_dat:tot);
            y_las=re_y(f_dat:tot);
            [p_lin,er]=polyfit(x_las,y_las,1);
            y_new=(p_lin(1).*x_las)+p_lin(2);
%             len=sqrt((x_las(1)-x_las(length(x_las)))^2+(y_new(1)-y_new(length(y_new)))^2);
%             if len>=0.15
                slop(i3)=p_lin(1);
                incep(i3)=p_lin(2); 
                i3=i3+1;
                figure(1);
                plot(x_las,y_new,'-r','markersize',4);
%             end
            tot=tot+1;
        end
    end
    slop(i3)=0;
    incep(i3)=0;
    i3=i3+1;
end

