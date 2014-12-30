clear all;clc;
odo_data=load('rec_odometry.txt');
time=odo_data(:,1);
lwo=odo_data(:,2)*0.138*10^-3;
rwo=odo_data(:,3)*0.138*10^-3;

load std_data

lwod=diff(lwo);rwod=diff(rwo);
figure(1);subplot(1,2,1);plot(lwod);subplot(1,2,2);plot(rwod)
 barr=pi/2;
 lwxo=-0.16;lwyo=0;
rwxo=0.16;rwyo=0;
R=0.16
for io=1:length(rwod)
    if sign(lwod(io))==sign(rwod(io))
        disp('robo moves linear - barring constant disp-varies:');
        lwxo=lwxo+lwod(io)*cos(barr);lwyo=lwyo+lwod(io)*sin(barr);
        rwxo=rwxo+rwod(io)*cos(barr);rwyo=rwyo+rwod(io)*sin(barr);
    else
        disp('robo rotates - barring varies disp-constant:');
%         xmid=(lwxo+rwxo)/2;ymid=(lwyo+rwyo)/2;
%         
%         lwxo = lwxo + ((lwxo - xmid)*cos(barr) - (lwyo - ymid)*sin(barr));
%         lwyo = lwyo + ((lwxo - xmid)*sin(barr) + (lwyo - ymid)*cos(barr));
%         
%         rwxo = rwxo + ((rwxo - xmid)*cos(barr) - (rwyo - ymid)*sin(barr));
%         rwyo = rwyo + ((rwxo - xmid)*sin(barr) + (rwyo - ymid)*cos(barr));
        barr=barr-lwod(io)/R
        
    end
    lwxx(io)=lwxo;lwyy(io)=lwyo;
    rwxx(io)=rwxo;rwyy(io)=rwyo;
end
figure(2);plot(lwxx,lwyy,rwxx,rwyy);%xlim([0,5]);ylim([0,5]);
figure(3);plot(lwxro,lwyro,rwxro,rwyro);xlim([0,5]);ylim([0,5]);
