and1=and(im1,stc_90);
and2=and(not(im1),stc_90);
and3=and(im1,not(stc_90));
and4=and(not(im1),not(stc_90));

or1=or(im1,stc_90);
or2=or(not(im1),stc_90);
or3=or(im1,not(stc_90));
or4=or(not(im1),not(stc_90));

nand1=not(and(im1,stc_90));
nand2=not(and(not(im1),stc_90));
nand3=not(and(im1,not(stc_90)));
nand4=not(and(not(im1),not(stc_90)));

nor1=not(or(im1,stc_90));
nor2=not(or(not(im1),stc_90));
nor3=not(or(im1,not(stc_90)));
nor4=not(or(not(im1),not(stc_90)));

xor1=xor(im1,stc_90);
xnor=not(xor1);
