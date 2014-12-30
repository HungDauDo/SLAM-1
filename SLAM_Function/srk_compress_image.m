close all;
clc;
x=re_x;y=re_y;
%normalize
xmin=min(x);
xmax=max(x);
Slopex=1/(xmax-xmin);

ymin=min(y);

ymax=max(y);
Slopey=1/(ymax-ymin);

x2=x-xmin;
y2=y-ymin;

nx=x2*Slopex;
ny=y2*Slopey;


rx=round(nx*100)+1;
ry=round(ny*100)+1;
I=zeros(115,115);

for ixy=1:length(rx)
    I(rx(ixy)+5,ry(ixy)+5)=1;
end
se=ones(6,6);
Id=imdilate(I,se);
se1=ones(2,2);
Ie=imerode(Id,se);
I=I ;
[ri,ci]=find(I);
r=1;
im1=ones(11,11);
for i=30:30:360
    close all;
    clear num1 num2 num3;
    tic
    k=1;
    st_90=imread('st_90.bmp');
    sz=size(st_90);
    str_90=imrotate(st_90,i);
    d=((size(str_90)-size(im1))/2)+1;    
    stc_90=imcrop(str_90,[d sz(1)-1 sz(2)-1]);
for im=1:length(ri)
    %crop images
    im1=imcrop(I,[ci(im)-5 ri(im)-5 10 10]);
    log_opr;
    n1(k)=length(find(and1));
    n2(k)=length(find(and4));
    n3(k)=length(find(xnor));
    
%     po(r,k)=(0.7*n3(k)+0.2*n1(k)+0.1*n2(k));
    
%     po(r,k)=((n3(k)*(n2(k)/n1(k)))+(n1(k)*(n3(k)/n2(k)))+(n2(k)*(n1(k)/n3(k))))/((n2(k)/n1(k))+(n1(k)/n3(k))+(n3(k)/n2(k)));
%     po(r,k)=((n3(k)*(n1(k)+n2(k)))+(n2(k)*(n1(k)+n3(k)))+(n1(k)*(n2(k)+n3(k))))/(n1(k)+n2(k)+n3(k));
    k=k+1;
%     pause;
end
r=r+1;
toc
 nu1=n1-mean(n1);
 nu2=n2-mean(n2);
 nu3=n3-mean(n3);
figure(1);
plot(nu1);
hold on;
plot(nu2,'k');
plot(nu3,'r');
% plot(po,'o');
pause;
end
