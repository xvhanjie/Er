% reflection coefficients

% define variables
Cn=cn;
Sn=sqrt(1-Cn^2);
Cnp=sqrt(Cn^2+2*H/a*Sn^2);
Hn=(a/(3*Sn^2))*(Cnp^3-Cn^3);


% R of ionosphere
%delta=delta_h0_ode;
Cdelta=(Cnp+delta(1,1))*(Cnp*delta(2,2)-1)...
    -Cnp*delta(1,2)*delta(2,1);
R_11=((Cnp-delta(1,1))*(Cnp*delta(2,2)-1)+...
    Cnp*delta(1,2)*delta(2,1))/Cdelta;
R_12=-2*Cnp*delta(2,1)/Cdelta;
R_21=-2*Cnp*delta(1,2)/Cdelta;
R_22=((Cnp+delta(1,1))*(1+Cnp*delta(2,2))-...
    Cnp*delta(1,2)*delta(2,1))/Cdelta;
Rmatrix=[R_11 R_12;R_21 R_22];

% R of ground
R_g=(Cn-delta_g)/(Cn+delta_g);
R_h=(Cn-1/delta_g)/(Cn+1/delta_g);
Rg=abs([R_g;R_h]);




