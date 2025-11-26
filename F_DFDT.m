function [Fv,dFdtheta]=F_DFDT(thetaz)

parameters;
%Height=HH;
%Height=HH+dH(1);
Height=HH-dH(1);

a=EarthRadius*1000;  % m
H=Height*1000;

delta_theta=thetaz/100;
theta_c=[thetaz-delta_theta thetaz+delta_theta thetaz];
F_theta=zeros(1,3);

for j=1:3

theta=theta_c(j);

Cn=cos(theta);
Sn=sin(theta);
Cnp=sqrt(Cn^2+2*H/a*Sn^2);
Hn=(a/(3*Sn^2))*(Cnp^3-Cn^3);

% surface impedance matrix of ionosphere
delta=sur_impe(theta,Height);

% R matrix of ionosphere
R=delta2R(delta,Cnp);

% R of ground
R_g=(Cn-delta_g)/(Cn+delta_g);
R_h=(Cn-1/delta_g)/(Cn+1/delta_g);

% modal equation
fx=(1-R_g*R(1,1)*exp(2*1i*k0*Hn))*...
    (1-R_h*R(2,2)*exp(2*1i*k0*Hn))-...
    R(1,2)*R(2,1)*R_g*R_h*exp(4*1i*k0*Hn);

F_theta(j)=fx;

end

dFdtheta=(F_theta(2)-F_theta(1))/(2*delta_theta);
Fv=F_theta(3);

end





