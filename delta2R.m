function Reflection_Coefficients=delta2R(delta,C)


% transform delta to R
RC=(C+delta(1,1))*...
    (C*delta(2,2)-1)-C*delta(1,2)*delta(2,1);
R11=((C-delta(1,1))*...
    (C*delta(2,2)-1)+C*delta(1,2)*delta(2,1))/RC;
R12=-2*C*delta(2,1)/RC;
R21=-2*C*delta(1,2)/RC;
R22=((C+delta(1,1))*...
    (1+C*delta(2,2))-C*delta(1,2)*delta(2,1))/RC;

Reflection_Coefficients=[R11 R12;R21 R22];

end



