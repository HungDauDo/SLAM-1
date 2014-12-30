inter=[1 1 0 0 0;
       0 1 1 0 0;
       0 0 1 1 0;
       0 0 0 1 1;
       0 0 0 0 1];
bw5 = bwhitmiss(I,inter);
%bw4=imrotate(bw4,-90);
[xm5,ym5]=find(bw5);

inter=[1 0 0 0 0;
       1 1 0 0 0;
       0 1 1 0 0;
       0 0 1 1 0;
       0 0 0 1 1];
bw6 = bwhitmiss(I,inter);
%bw4=imrotate(bw4,-90);
[xm6,ym6]=find(bw6);

inter=[0 0 0 0 1;
       0 0 0 1 1;
       0 0 1 1 0;
       0 1 1 0 0;
       1 1 0 0 0];
bw7 = bwhitmiss(I,inter);
%bw4=imrotate(bw4,-90);
[xm7,ym7]=find(bw7);

inter=[0 0 0 1 1;
       0 0 1 1 0;
       0 1 1 0 0;
       1 1 0 0 0;
       1 0 0 0 0];
bw8 = bwhitmiss(I,inter);
%bw4=imrotate(bw4,-90);
[xm8,ym8]=find(bw8);

