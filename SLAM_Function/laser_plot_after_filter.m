%converting the polar form data of laser range finder to rectangular form 
%loacal coordinates only

clear ex why;
for j1=1:length(alpha)
        ex(j1)=in_las(j1)*cosd(alpha(j1));
        why(j1)=in_las(j1)*sind(alpha(j1));
end

