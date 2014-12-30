% Structure element creation
max_st=33; % Structure element maximum size corresponding to max_im
st1=zeros(max_st,max_st);
st2=zeros(max_st,max_st);
c=((max_st-1)/2)+1;
for r=c:max_st
    st1(r,c)=1;
end
r=((max_st-1)/2)+1;
for c=r:max_st
    st2(r,c)=1;
end
% st_90=or(st1,st2);
st_90=or(st1,st2);
% st_90=st_90>=1;
st_10=imrotate(st1,10);
mid=((length(st_10)-1)/2)+1;
st_10=imcrop(st_10,[mid-16 mid-16 32 32]);
st_80=or(st_10,st2);
st_10=imrotate(st2,10);
mid=((length(st_10)-1)/2)+1;
st_10=imcrop(st_10,[mid-16 mid-16 32 32]);
st_100=or(st1,st_10);

% figure(1)
% subplot(2,2,1);
% imshow(st_90);
% subplot(2,2,2);
% imshow(st_80);
% subplot(2,2,3);
% imshow(st_100);

% Structure element creation