function ZEROSS=Compare_ZEROSin(ZEROSM)
nzsm=size(ZEROSM,2);
j=1;
while nzsm>0
    [minz,loct]=min(imag(ZEROSM));
    ZEROSS(j)=ZEROSM(loct);
    ZEROSM(loct)=99999*1i;
    j=j+1;
    nzsm=nzsm-1;
end
end