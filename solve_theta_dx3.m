function [theta_dx,t1,t2]=solve_theta_dx3(F_n,phi_n,dalpha,dvp,vp,d,nv)
% solve theta_d*
parameters3;

for j=1:length(F_n)
    rho_n(j)=F_n(j)/F_n(1);
    theta_n(j)=phi_n(j)-phi_n(1);
end

TD1=0;
TD2=0;
for ii=1:length(F_n)
    for jj=1:length(F_n)
        td1=rho_n(ii)*rho_n(jj)*dalpha(ii)*...
            sin(phi_n(ii)-phi_n(jj));
        td2=rho_n(ii)*rho_n(jj)*dvp(jj)*...
            cos(phi_n(ii)-phi_n(jj))/(vp(jj)^2);
        TD1=TD1+td1;
        TD2=TD2+td2;
    end 
end

Mtd_2=sum(rho_n.*cos(theta_n))^2+...
    sum(rho_n.*sin(theta_n))^2;

K=2.4;
theta_dx=K*vp(nv)^2*(d/1000)^(1/4)/(100*dvp(nv)*f)*...
         (0.115*TD1+omega*TD2)/Mtd_2;  %theda_d*
t1=K*vp(nv)^2*(d/1000)^(1/4)/(100*dvp(nv)*f);
t2=(0.115*TD1+omega*TD2)/Mtd_2; 
end

