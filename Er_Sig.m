function [sum_Er,SigmaDeltaPhi]=Er_Sig(EMagnitude,alpha,vp,ef,d,theta_dx)
parameters;

sum_Er=0;
for j=1:length(alpha)
    Er(j)=EMagnitude*...
        ef(j)*exp(-0.115*alpha(j)*(d*1000)...
        +1i*omega/vp(j)*d*1000);
    sum_Er=Er(j)+sum_Er;
end

%for ii=1:size(EXFAC,1)
 %   exfac=EXFAC(ii,:);
  %  ESUM=0;
   % for jj=1:length(exfac)
    %    E_temp=EMagnitude*...
     %       exfac(j)*exp(-0.115*alpha(j)*(d*1000)...
      %      +1i*omega/vp(j)*d*1000);
       % ESUM=E_temp+ESUM;
    %end
   % SUM_Er(ii)=ESUM;   
%end

fy=@(yy)atan(theta_dx*yy).^2.*exp(-(yy.^2)/2);
D_delta_phi=1/(sqrt(2*pi))*integral(fy,-inf,inf);
sigma_delta_phi=sqrt(D_delta_phi)*1e6/omega;   % us
SigmaDeltaPhi=sigma_delta_phi;

end

