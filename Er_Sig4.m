function [sum_Er,SigmaDeltaPhi]=Er_Sig4(EMagnitude,alpha,vp,ef,d,theta_dx)
parameters4;

sum_Er=0;
for j=1:length(alpha)
    Er(j)=EMagnitude*...
       ef(j)*exp(-0.115*alpha(j)*(d*1000)...
       +1i*omega/vp(j)*d*1000);
    sum_Er=Er(j)+sum_Er;
end


fy=@(yy)atan(theta_dx*yy).^2.*exp(-(yy.^2)/2);
D_delta_phi=1/(sqrt(2*pi))*integral(fy,-inf,inf);
sigma_delta_phi=sqrt(D_delta_phi)*1e6/omega;   % us
SigmaDeltaPhi=sigma_delta_phi;
    
end

