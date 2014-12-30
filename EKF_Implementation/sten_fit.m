function [xfe,yfe]=sten_fit(x,y)
len=length(x); thres=0.05; xe=[]; ye=[];  xfe=[]; yfe=[];
% Initiatize with starting and ending points
xe=[1,len];
ye=[1,len];
% Initiatize with starting and ending points
i=1;
while i<length(xe)
    x1=x(xe(i)); x2=x(xe(i+1));
    y1=y(ye(i)); y2=y(ye(i+1));
    si=polyfit([x1 x2],[y1 y2],1); % Joining starting and ending points & find slope & intercept
    len=length(x(xe(i):xe(i+1)));
    d=abs(y(ye(i):ye(i+1))-(si(1)*x(xe(i):xe(i+1)))-(si(2)*ones(1,len)))/sqrt(si(1)^2+1);
    [M,I]=max(d);
    if M>=thres
        xe=[xe xe(i)-1+I]; ye=[ye ye(i)-1+I];
        xe=sort(xe);
        ye=sort(ye);
    else
        i=i+1;
    end   
end
for k=1:length(xe)-1
    sl_in=polyfit(x(xe(k):xe(k+1)),y(ye(k):ye(k+1)),1);
    slp(k)=sl_in(1);inpt(k)=sl_in(2);
end
v=1;
while v<length(slp)
    xfe(v)=(inpt(v+1)-inpt(v))/(slp(v)-slp(v+1));
    yfe(v)=(slp(v)*xfe(v))+inpt(v);
    v=v+1;
end
end
