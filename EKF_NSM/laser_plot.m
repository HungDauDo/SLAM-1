%converting the polar form data of laser range finder to rectangular form 
%loacal coordinates only

clear d_las d_alp ex why;
k1=1;
i1=1;
for j1=1:c_las-1
    if (las_dat(i1,j1+1)>=0.15)
        d_las(k1)=las_dat(i1,j1+1);
        d_alp(k1)=alpha(j1);
        ex(k1)=las_dat(i1,j1+1)*cos(alpha(j1));
        why(k1)=las_dat(i1,j1+1)*sin(alpha(j1));
        k1=k1+1;
    end
end

