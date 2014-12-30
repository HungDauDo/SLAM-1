close all;
clear all;
clc;
st_90=imread('st_90.bmp');
sz=size(st_90);
% im1=[0 0 0 0 0 1 0 0 0 0 0;
%        0 0 0 0 0 1 0 0 0 0 0;
%        0 0 0 0 0 1 0 0 0 0 0;
%        0 0 0 0 0 1 0 0 0 0 0;
%        0 0 0 0 0 1 0 0 0 0 0;
%        0 0 0 0 0 1 1 1 1 1 1;
%        0 0 0 0 0 0 0 0 0 0 0;
%        0 0 0 0 0 0 0 0 0 0 0;   
%        0 0 0 0 0 0 0 0 0 0 0;
%        0 0 0 0 0 0 0 0 0 0 0;
%        0 0 0 0 0 0 0 0 0 0 0];
im1=imread('sca2.bmp');
k=1;
for i=0:30:360
tic
    str_90=imrotate(st_90,i);
    d=((size(str_90)-size(im1))/2)+1;    
    stc_90=imcrop(str_90,[d sz(1)-1 sz(2)-1]);
    log_opr;
    num1(k)=length(find(and1));
    num2(k)=length(find(and4));
    num3(k)=length(find(xnor));
    po(k)=(num3(k)*(num1(k)+num2(k))+num2(k)*(num1(k)+num3(k))+num1(k)*(num2(k)+num3(k)))/(num1(k)+num2(k)+num3(k));
    k=k+1;
toc
%     pause;
end
%  nu1=num1-mean(num1);
%  nu2=num2-mean(num2);
%  nu3=num3-mean(num3);
figure(1);
plot(nu1);
hold on;
plot(nu2,'k');
plot(nu3,'r');
plot(po
% figure(2);
% plot(diff(nu1));
% hold on;
% plot(diff(nu2),'k');
% plot(diff(nu3),'r');

