clc;
clear n1 n2 n3 dat ind all_stc rto;
x=re_x;y=re_y;

% Normalize & image creation
max_im=125; % Maximum size of the resized image
rs=20; % Current resize value
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
rx=round(nx*rs)+1;
ry=round(ny*rs)+1;
% Normalize & image creation


% Structure element creation
max_st=round(max_im/10); % Structure element maximum size corresponding to max_im
if mod(max_st,2)==0
    max_st=max_st+1;
end

st_90=zeros(max_st,max_st);
c=((max_st-1)/2)+1;
for r=c:max_st
    st_90(r,c)=1;
end
r=((max_st-1)/2)+1;
for c=r:max_st
    st_90(r,c)=1;
end
% structure_element;
% Structure element creation


% Structure element resize
st_sz=round(rs*max_st/max_im);
if mod(st_sz,2)==0
    st_sz=st_sz+1;
end
% Structure element resize


% Limit for im1
lmt=((st_sz-1)/2);
% Limit for im1


% Image creation
I=zeros(rs+(2*lmt)+1,rs+(2*lmt)+1);
for ixy=1:length(rx)
    I(rx(ixy)+lmt,ry(ixy)+lmt)=1;
end
Im = imrotate(I,90,'bilinear','crop');
% Image creation
[ri,ci]=find(I);
ct=0;rt=0;
tic
% figure(1);
ang=30;
for i=ang:ang:360
    close all;
    clear num1 num2 num3;
    k=1;
    
    str_90=imrotate(st_90,i);
    len_90=((length(str_90)-1)/2)+1;
    stc_90=imcrop(str_90,[len_90-lmt len_90-lmt 2*lmt 2*lmt]);
    
%     all_stc(:,:,i/ang)=stc_90;
    
    for ik=1:length(ri)
        %crop image
        im1=imcrop(I,[ci(ik)-lmt ri(ik)-lmt 2*lmt 2*lmt]);
        log_opr;
        n1(k)=length(find(and1));
        n2(k)=length(find(and4));
        n3(k)=length(find(xnor));
        
        w_stc90=length(find(stc_90));
        b_stc90=length(find(stc_90==0));
        x_stc90=((lmt*2)+1)^2;
        
        rto(i/ang,k)=0.5*(n1(k)/w_stc90+n2(k)/b_stc90);
        %         rto(i/10,k)=(n1(k)/w_stc90+n2(k)/b_stc90+n3(k)/x_stc90)/3;
        
        if rto(i/ang,k)==1
            ind(rt+1)=ik;
            rt=rt+1;
        end
        
        if n3(k)>=st_sz^2%-(0.1*st_sz^2)
            dat(ct+1)=ik;
            ct=ct+1;
        end
        k=k+1;
        
    end
end

% for is=1:length(all_stc)
%     r=ceil(sqrt(length(all_stc)));
%     c=floor(sqrt(length(all_stc)));
%     subplot(r,c,is);imshow(all_stc(:,:,is));
% end
toc
% figure(2);
% imshow(Im);
% figure(3);
% plot(rto');
if rt>0    
    ind=unique(ind);
    hit1=[ci(ind) ri(ind)];    
    % Denormalization
    xm=hit1(:,2);
    ym=hit1(:,1);
    xm=(xm-lmt)/rs;
    ym=(ym-lmt)/rs;
    xn=xm;yn=ym;
    xm=xm/Slopex;
    ym=ym/Slopey;    
    xm=xm+xmin;
    ym=ym+ymin;
    % Denormalization
    figure(4);
    plot(re_x,re_y,'bx',xm-(max_im/rs)*0.03,ym-(max_im/rs)*0.03,'ro');
    tem1=size(hit1);
    lenh1=lenh1+tem1(1);
end
if ct>0
    dat=unique(dat);
    hit2=[ci(dat) ri(dat)];
    tem2=size(hit2);
    lenh2=lenh2+tem2(1);
end