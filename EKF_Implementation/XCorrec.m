function Xnow=XCorrec(Xnow,Kgain,Innov)

Xnow=Xnow+(Kgain*Innov)';
end
