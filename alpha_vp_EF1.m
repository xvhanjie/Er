function [alpha,vp,ef,delta]=alpha_vp_EF1(thetaz,Height)

% solve for vp,alpha,ef 
% cn is solved by Newton iteration
parameters1;

H=Height*1000;            % Unit is m
a=EarthRadius*1000;
zd=Height_D*1000;
%zo=ZO*1000;
syms ze

for j=1:length(thetaz)
    theta=thetaz(j);
    Sn(j)=sin(theta);
    Cn(j)=cos(theta);     % roots of modal equation
    Cnp(j)=sqrt(Cn(j)^2+2*H/a*Sn(j)^2);
    Hn(j)=(a/(3*Sn(j)^2))*(Cnp(j)^3-Cn(j)^3);
    
    delta=sur_impe1(theta,Height);
    rho=delta(1,2)/delta(2,1);
    
    alpha(j)=8.6858*k0*imag(Sn(j));     % dB/m
    vp(j)=LightSpeed/real(Sn(j));      % m/s
    
    Rgn(j)=(Cn(j)-delta_g)/(Cn(j)+delta_g);
    Rhn(j)=(Cn(j)-1/delta_g)/(Cn(j)+1/delta_g);
    Mn(j)=(delta(2,1)*Cnp(j)...
     *(1-Rhn(j)*exp(2*1i*k0*Hn(j))))/...
     (Cnp(j)*(1-Rgn(j)*exp(2*1i*k0*Hn(j)))...
     +delta(1,1)*(1+Rgn(j)*exp(2*1i*k0*Hn(j))));
    
    sita(j)=(1-rho*Mn(j)^2+(1+rho*Mn(j)^2)...
              *(sin(2*k0*Cn(j)*H)/...
             (2*k0*Cn(j)*H)))^(-1);
    fze=sqrt(Cn(j)^2+(2*ze/a)*Sn(j)^2);
    Fnz0(j)=1/(1+Rgn(j))*...
           (exp(-1i*k0*int(fze,ze,0,zd))...
           +Rgn(j)*exp(1i*k0*int(fze,ze,0,zd)));
    %Fnz(j)=1/(1+Rgn(j))*...
           %(exp(-1i*k0*int(fze,ze,0,zo))...
           %+Rgn(j)*exp(1i*k0*int(fze,ze,0,zo)));
    % excitation factor 
  ef(j)=double(sita(j)*Fnz0(j)*(Sn(j))^(3/2)); %Er
 %ef(j)=double(sita(j)*Fnz0(j)*(-(Sn(j))^(1/2)));%Hphi

end

end
