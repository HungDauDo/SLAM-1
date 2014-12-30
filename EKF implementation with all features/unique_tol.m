function [obj_r,obj_c]=unique_tol(r,c,tol)
if isempty(r)
    obj_r=[];obj_c=[];
else
    grp=zeros(size(r));
    g_no=1;
    for ir=1:length(r)
        %ir=1;
        if grp(ir)==0
            for ir1=1:length(r)
                if grp(ir1)==0
                    diff_r=abs(r(ir)-r(ir1));
                    diff_c=abs(c(ir)-c(ir1));
                    if diff_r<tol && diff_c<tol
                        grp(ir1)=g_no;
                    end
                end
            end
            g_no=g_no+1;
        end
    end
    no_grps=unique(grp);
    
    for ig=1:length(no_grps)
        sum_c=0;
        sum_r=0;
        idx=0;
        for ig1=1:length(r)
            if no_grps(ig)==grp(ig1)
                sum_r=sum_r+r(ig1);
                sum_c=sum_c+c(ig1);
                idx=idx+1;
            end
        end
        obj_r(ig)=sum_r/idx;
        obj_c(ig)=sum_c/idx;
    end
end
end