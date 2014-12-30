%converting the polar form data of laser range finder to rectangular form 
%loacal coordinates only
function [ex,why]=polar_rectangular(dat,alpha)
k1=1;
len=length(dat);
for j1=1:len-1
    if dat(j1)>=0.15
        ex(k1)=dat(j1)*cos(alpha(j1));
        why(k1)=dat(j1)*sin(alpha(j1));
        k1=k1+1;
    end
end
end

