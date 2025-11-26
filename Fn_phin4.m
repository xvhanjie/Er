function [EMagnitude,F_n,phi_n]=Fn_phin4(alpha,vp,ef,d)
% compute F_n,phi_n
parameters4;

h0=HH*1000;
Pkw=1;                      % power kW
E0=-3e2*sqrt(Pkw)/(d);    % mV/m, d in km

WaveLength=2*pi/k0;            % wavelength
a=EarthRadius*1000;   

for j=1:length(alpha)
    F_n(j)=abs(ef(j))*exp(-0.115*alpha(j)*(d*1000));
    phi_n(j)=omega*(d*1000)/vp(j)+angle(ef(j));  
end
  
for j=1:length(F_n)
    rho_n(j)=F_n(j)/F_n(1);
    theta_n(j)=phi_n(j)-phi_n(1);
end

Mf=sqrt(sum(rho_n.*cos(theta_n))^2+...
    sum(rho_n.*sin(theta_n))^2);
Mp=sum(rho_n.*sin(theta_n))/...
    (sum(rho_n.*cos(theta_n))-1+1);

% total magnitude F and phase phi
EMagnitude=-exp(-1i*pi/4)*E0*...
    (((d*1000/WaveLength*d*1000/a)^(1/2))/...
    ((sin(d*1000/a))^(1/2)*(h0/WaveLength)));

FM=EMagnitude*F_n(1)*Mf;
phiM=phi_n(1)+atan(Mp);

FnFs=F_n/(F_n(1)*Mf);

end



