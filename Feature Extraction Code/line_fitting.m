function [slp1,incep1]=line_fitting(re_x,re_y,dev)
slp1=[]; incep1=[];
nex_pt=4; f_dat=1; len=length(re_x);
l_dat=nex_pt;
rem=len;
while (rem>0)
    x=re_x(f_dat:l_dat);
    y=re_y(f_dat:l_dat);
    p_lin=poly_fit(x,y);
    rem=rem-length(x);
    if rem>=nex_pt
        % Test the distance of next nex_pt with the above created line
        pts=test_dis(re_x(l_dat+1:l_dat+nex_pt),re_x(l_dat+1:l_dat+nex_pt),p_lin,dev);
        if pts<=round(nex_pt/2)
            l_dat=l_dat+nex_pt;
        else
            slp1=[slp1 p_lin(1)];
            incep1=[incep1 p_lin(2)];
            f_dat=l_dat+1;
            l_dat=f_dat+nex_pt-1;
        end
    elseif rem>0 && rem<nex_pt
        pts=test_dis(re_x(l_dat+1:l_dat+rem),re_x(l_dat+1:l_dat+rem),p_lin,dev);
        if pts<=round(rem/2)
            l_dat=l_dat+rem;
        else
            slp1=[slp1 p_lin(1)];
            incep1=[incep1 p_lin(2)];
        end
    else
        slp1=[slp1 p_lin(1)];
        incep1=[incep1 p_lin(2)];
    end
end
end

