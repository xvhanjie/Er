function ZEROSS1=Compare_ZEROS(ZEROS)
% Search for unique zeros of theta

ZEROSM=[];
ZEROSS=[];

NR_ZT=length(ZEROS);

if NR_ZT<2
    ZEROSS1=ZEROS;
    return
end

jm=1;
ZEROSM(1)=ZEROS(1);

for jj=2:NR_ZT
    match=0;
for ii=1:jj-1
    DIFFS=ZEROS(jj)-ZEROS(ii);
    if (abs(real(DIFFS)))<0.1&&(abs(imag(DIFFS)))<0.01 
        % same zeros
        match=1;
    end
end
if match~=1
    jm=jm+1;
    ZEROSM(jm)=ZEROS(jj);
end
end

nzsm=size(ZEROSM,2);
j=1;
while nzsm>0
    [minz,loct]=min(real(ZEROSM));
    ZEROSS(j)=ZEROSM(loct);
    ZEROSM(loct)=99999;
    j=j+1;
    nzsm=nzsm-1;
end
        
ii=1;
for jj=1:length(ZEROSS)
    if ZEROSS(jj)~=100 %NaN
        ZEROSS1(ii)=ZEROSS(jj);
        ii=ii+1;
    end
end
        
disp('Compare ZEROS completed')
end



