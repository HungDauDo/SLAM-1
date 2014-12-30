function [ps_po,nw_po,ps_re] = GetCurAssoFeature(past_po,now_po,now_re,Gpast_re)

Pr=[];Pt=[];Nr=[];Nt=[];Px=[];Py=[];
if ~isempty(now_po)
    tem=size(past_po);
    for i=1:tem(2)
        Xp(i)=past_po(1,i)*cos(past_po(2,i));
        Yp(i)=past_po(1,i)*sin(past_po(2,i));
    end
    past_re=[Xp;Yp];
    
    a=size(past_re);
    r1=1; tol=0.1;
    
    for at=1:a(2)
        k=1; b=size(now_re); re_nw=[];
        for bt=1:b(2)
            ecd=sqrt((past_re(1,at)-now_re(1,bt))^2+(past_re(2,at)-now_re(2,bt))^2);
            if ecd<=tol
                Pr(r1)=past_po(1,at);
                Pt(r1)=past_po(2,at);
                
                Px(r1)=Gpast_re(1,at);
                Py(r1)=Gpast_re(2,at);
                
                Nr(r1)=now_po(1,bt);
                Nt(r1)=now_po(2,bt);
                r1=r1+1;
            else
                re_nw(1,k)=now_re(1,bt);
                re_nw(2,k)=now_re(2,bt);
                k=k+1;
            end
        end
        now_re=[];
        now_re=re_nw;
    end
    ps_po=[Pr;Pt];
    nw_po=[Nr;Nt];
    ps_re=[Px;Py];
else
    ps_po=[]; nw_po=[]; ps_re=[];
end
