clear all;
close all;
dat_las=load('lasernew.txt');
alpha=linspace(-30,210,682);
[r_las,c_las]=size(dat_las);

    
for i=1:r_las
    for j=2:c_las
        l_ex(j-1)=dat_las(i,j);
        ex(j-1)=dat_las(i,j)*cosd(alpha(j-1));
        why(j-1)=dat_las(i,j)*sind(alpha(j-1));
    end
    j=1;
    k=1;
    j1=1;
    clear re_x re_y;
    while (j+j1<681)
        ec_dis=sqrt((ex(j)-ex(j+j1))^2+(why(j)-why(j+j1))^2);
        if ec_dis>0.04
            re_x(k)=ex(j);
            re_y(k)=why(j);
            k=k+1
            j=j+j1;
            j1=1;
        else
            j1=j1+1;
        end
    end
%     plot(re_x,re_y,'or','markersize',1);
% %     hold on;
%     pause(0.1);


%figure(3);plot(round(nx*100),round(ny*100),'r*');
x=ex;y=why;
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


%toc
% nx=re_x;
% ny=re_y;

rx=round(nx*200)+1;
ry=round(ny*200)+1;
I=zeros(210,210);

for ixy=1:length(rx)
I(rx(ixy)+5,ry(ixy)+5)=1;
end
%imshow(I);

%I=medfilt2(I,[4,4]);
%I=imrotate(I,90);
%figure(4);imshow(I)
%se=[1 1;1 1]
%I=imdilate(I,se);imshow(I);
se=ones(4,4);
Id=imdilate(I,se);
Ie=imerode(Id,se);
%imshow(Id);
I=Id;

%%% For Creating SEs
N1=11;
xn=N1;
yn=N1;
se=zeros(xn,yn);

xc=round(xn/2);
yc=round(yn/2);

se(xc,yc)=1;

xne=(-1:1)+xc; 
yne=(-1:1)+yc;
n=1;
for i=1:length(xne)
    for j=1:length(yne)
        if (x(i)== xc)&&(y(j)==yc)
            %%
        else
        se(xc,yc)=1;
        se(xne(i),yne(j))=1;
        se(2*xne(i)-xc,2*yne(j)-yc)=1;
        se(3*xne(i)-2*xc,3*yne(j)-2*yc)=1;
        se(4*xne(i)-3*xc,4*yne(j)-3*yc)=1;
        se(5*xne(i)-4*xc,5*yne(j)-4*yc)=1;
 %       se
%        pause;
        se_data(:,n:n+(N1-1))=se;
        n=n+N1;
        se=zeros(xn,yn);
    %pause;
        end
    end
end

l=length(se_data)/N1;
xm=0;
ym=0;


for ip=1:l-1
    In=se_data(:,1+(ip-1)*N1:N1+(ip-1)*N1);
    for ip1=ip+1:l
        In1=se_data(:,1+(ip1-1)*N1:N1+(ip1-1)*N1);
    if ip1 == l+1-ip
        %%
    else
        Inter=round((In+In1)/2);
        if sum(sum(Inter))>6
    %imshow(Inter)
    %pause
%     figure(6);
%     imshow(Inter);
%     pause
    bw4 = bwhitmiss(I,Inter);
%bw4=imrotate(bw4,-90);
[xm1,ym1]=find(bw4);
xm =[xm; xm1];
ym=[ym ;ym1];

%pause;
        end
    end
    end
end



%bw=bw1|bw2|bw3|bw4;
%subplot(1,2,1);imshow(I);
%subplot(1,2,2);imshow(bw1);



% xm=[xm1;xm2;xm3;xm4];
% ym=[ym1;ym2;ym3;ym4];
tol=20;
if isempty(xm)
    
else
[xm,ym]=unique_tol(xm,ym,tol);
end


% plot(x,y,'.');
xm=(xm-5)/210;
ym=(ym-5)/210;

xm=xm/Slopex;
ym=ym/Slopey;

xm=xm+xmin;
ym=ym+ymin;

figure(5);
subplot(2,1,1);plot(x,y,'.',xm,ym,'rO');
subplot(2,1,2);imshow(I);

% figure(5);
%plot(x,y,'.',xm,ym,'rO');
% hold on;
ht;
%toc
pause;
close all;
%hold on;
end