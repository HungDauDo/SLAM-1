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
       0 0 0 0 0 0 0 0 0 0 0;]
% st_90=zeros(11,11);
% im1=imread('sca1.bmp');
for i=0:10:360
    tic
    str_90=imrotate(st_90,i);
    d=((size(str_90)-size(im1))/2)+1;    
    stc_90=imcrop(str_90,[d sz(1)-1 sz(2)-1]);
    den=sz(1)*sz(2);
    figure(1);
    imshow(stc_90);
    figure(2);
    imshow(im1);
    std_90=not(xor(im1,stc_90));
    num=length(find(std_90));
    po=num/den
    and_st=and(im1,stc_90);
    an_nt=and(not(im1),not(stc_90));
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