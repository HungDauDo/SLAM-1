close all;
clear all;
clc;
st_90=imread('st_90.bmp');
sz=size(st_90);
im1=[0 0 0 0 0 1 0 0 0 0 0;
       0 0 0 0 0 1 0 0 0 0 0;
       0 0 0 0 0 1 0 0 0 0 0;
       0 0 0 0 0 1 0 0 0 0 0;
       0 0 0 0 0 1 0 0 0 0 0;
       0 0 0 0 0 1 1 1 1 1 1;
       0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0 0 0;   
       0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0 0 0];
% st_90=zeros(11,11);
% im1=imread('sca1.bmp');
w1=0.9; w2=0.1;
for i=0:10:360
    tic
    str_90=imrotate(st_90,i);
    d=((size(str_90)-size(im1))/2)+1;    
    stc_90=imcrop(str_90,[d sz(1)-1 sz(2)-1]);
    ss=size(stc_90);
    figure(1);
    imshow(stc_90);
    figure(2);
    imshow(im1);
    std_90=not(xor(im1,stc_90));    
    den1=length(find(stc_90))
    den2=length(find(stc_90==0))
    w1=den2/(ss(1)*ss(2));
    w2=den1/(ss(1)*ss(2));
    and_st=and(im1,stc_90);
    num1=length(find(and_st))
    an_nt=and(not(im1),not(stc_90));
    num2=length(find(an_nt))
%     po=(w1*num1+w2*num2)/(w1*den1+w2*den2)
    po=w1*(num1/den1)+w2*(num2/den2)
%     num=num1+num2;
%     po=(num/num1+num/num2)/(1/num1+1/num2)
    figure(3);
    subplot(2,2,1);
    imshow(std_90);
    subplot(2,2,2);
    imshow(and_st);
    subplot(2,2,3);
    imshow(an_nt);

    toc
    pause;
end