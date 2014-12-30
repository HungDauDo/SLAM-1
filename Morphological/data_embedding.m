clear ed_x ed_y;
ed_x=0;
ed_y=0;
n=0;
for i=1:length(f_x)-1
    [xn,yn,N]=data_emb(f_x(i:i+1),f_y(i:i+1));
    ed_x=[ed_x,xn];
    ed_y=[ed_y,yn];
    n=[n,N];
end