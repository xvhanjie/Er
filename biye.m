% % plot diagrams

% calculating for Sigma(deltaPhi)
clc;clear
start_time=cputime;
parameters1;

% input for theta_b,theta_f,theta
%==================================================
% f=10.2kHz H=87km phi=90/180*pi theta_b=0/180*pi sigma_g=0.001 
theta1_real=[  1.2727862e+00   1.5409892e+00   1.1276347e+00   9.2743386e-01   6.3796002e-01   ];
theta1_imag=[  5.8069131e-03   6.0408139e-02   9.4583544e-03   9.1159281e-03   1.0065344e-02   ];

theta2_real=[  1.2727778e+00   1.5409071e+00   1.1275976e+00   9.2739843e-01   6.3763648e-01   ];
theta2_imag=[  5.8353801e-03   6.0263932e-02   9.4411031e-03   9.0839360e-03   1.0133150e-02   ];

theta3_real=[  1.2727985e+00   1.5407787e+00   1.1277362e+00   9.2848039e-01   6.3824764e-01   ];
theta3_imag=[  5.7786629e-03   6.0532899e-02   9.4797644e-03   8.5885801e-03   1.0037962e-02   ];

%===================================================
theta1=theta1_real+1i*theta1_imag;   % H
theta2=theta2_real+1i*theta2_imag;   % H+dH
theta3=theta3_real+1i*theta3_imag;   % H-dH

alpha_bf=[];
vp_bf=[];

theta_bf=[theta2;
          theta3;
          theta1];
NR_MODES=size(theta_bf,2);
Nv=1;

disp('Calculating alpha,vp,dalphadh,dvpdh...')
for hj=1:3
    theta=theta_bf(hj,:);
    Height=HH+dH(hj);
    
% calculating alpha,vp,excitation factor
[AttenuationRate1,PhaseVelocity1,ExcitationFactor,SI]=...
    alpha_vp_EF1(theta,Height);
alpha_bf(hj,:)=AttenuationRate1;
vp_bf(hj,:)=PhaseVelocity1;

end

[dalpha,dvp]=dalpha_dvp(alpha_bf,vp_bf,dH(1));

factor_v1=PhaseVelocity1.^2./dvp;

disp('Computing Er and Sigma...')
d_start=100;       % d=500-3000km
d_end=4000;
d_interval=10;   % interval is 10km
d_number=(d_end-d_start)/d_interval+1;
% 
% d=d_start;
% dd1=1;
% for dd=1:d_number
% 
% [EMagnitude,F_n,phi_n]=...
% Fn_phin1(AttenuationRate1,PhaseVelocity1,ExcitationFactor,d);
% 
% [theta_dx,t1,t2]=solve_theta_dx1(F_n,phi_n,dalpha,dvp,PhaseVelocity1,d,Nv);
% 
% [sum_Er,SigmaDeltaPhi]=...
% Er_Sig1(EMagnitude,AttenuationRate1,PhaseVelocity1,ExcitationFactor,d,theta_dx);
% 
% Er(dd)=sum_Er;
% sigma(dd)=SigmaDeltaPhi;
% 
% if mod(dd,10)==0
%    distance1(dd1)=d;
%    sigma1(dd1)=SigmaDeltaPhi;
%    dd1=dd1+1;
% end
% 
% d=d+d_interval;
% 
% end
% 
% % plot numerical results
% disp('plotting results...')
% distance=d_start:d_interval:d_end;
% % figure(1)
% % subplot(2,2,1)
% % hold on
% semilogy((4000-distance)*5,sigma*25,'k','Linewidth',2)
% hold on
% line([0.5e4 0.5e4 nan 1e4 1e4 nan 1.5e4 1.5e4],[1 1e3 nan 1 1e3 nan 1 1e3],'color',[0.8 0.8 0.8],'LineStyle','-')
% plot([10 2e4],[100 100],'color',[0.8 0.8 0.8],'LineStyle','-')
% hold on
% plot([10 2e4],[10 10],'color',[0.8 0.8 0.8],'LineStyle','-')
% hold on
% plot([10 2e4],[1 1],'color',[0.8 0.8 0.8],'LineStyle','-')
% hold on
% plot([10 2e4],[1000 1000],'color',[0.8 0.8 0.8],'LineStyle','-')
% %plot(distance1,sigma1,'bs','MarkerFaceColor','b')
% xlabel('Propagation distance (km)')
% ylabel('\sigma(\Delta\Phi) (\mus)')
% %title('\phi=0\circ')
% title('\theta_b=0\circ')
% % axis([100 4000 0 20])
% % x1=500:500:4000;
x=[100 1000 2000 3000 4000];
% % set(gca,'XTick',x)
% %set(gca,'FontSize',14)
% box on

% plot diagrams

% % calculating for Sigma(deltaPhi)
% % parameters2;
% % 
% % input for theta_b,theta_f,theta
% % ==================================================
% % f=10.2kHz H=87km phi=90/180*pi theta_b=90/180*pi sigma_g=0.001 
% % theta1_real=[1.4362487e+00   1.2619963e+00   1.0807978e+00   8.9092577e-01     1.2336017e+00 ];%  1.0339210e+00   ];
% % theta1_imag=[1.1010550e-02   6.2798632e-03   4.1397358e-03   3.6647469e-03     1.7255839e-02  ];% 2.7045541e-02   ];
% % 
% % theta2_real=[1.4362516e+00   1.2620023e+00   1.0808073e+00   8.9093235e-01     1.2336062e+00 ];%  1.0339276e+00   ];
% % theta2_imag=[1.1010447e-02   6.2793078e-03   4.1392591e-03   3.6637917e-03     1.7255938e-02   ];%2.7045338e-02   ];
% % 
% % theta3_real=[1.4362456e+00   1.2619903e+00   1.0807854e+00   8.9090408e-01     1.2335973e+00  ];% 1.0339136e+00   ];
% % theta3_imag=[1.1010762e-02   6.2803989e-03   4.1426170e-03   3.6647273e-03     1.7255781e-02   ];%2.7045428e-02   ];
% % 
% % ===================================================
% % theta1=theta1_real+1i*theta1_imag;   % H
% % theta2=theta2_real+1i*theta2_imag;   % H+dH
% % theta3=theta3_real+1i*theta3_imag;   % H-dH
% % 
% % alpha_bf=[];
% % vp_bf=[];
% % 
% % theta_bf=[theta2;
% %           theta3;
% %           theta1];
% % NR_MODES=size(theta_bf,2);
% % Nv=2;
% % 
% % disp('Calculating alpha,vp,dalphadh,dvpdh...')
% % for hj=1:3
% %     theta=theta_bf(hj,:);
% %     Height=HH+dH(hj);
% %     
% % calculating alpha,vp,excitation factor
% % [AttenuationRate2,PhaseVelocity2,ExcitationFactor,SI]=...
% %     alpha_vp_EF2(theta,Height);
% % alpha_bf(hj,:)=AttenuationRate2;
% % vp_bf(hj,:)=PhaseVelocity2;
% % 
% % end
% % 
% % [dalpha,dvp]=dalpha_dvp(alpha_bf,vp_bf,dH(1));
% % 
% % factor_v2=PhaseVelocity2.^2./dvp;
% % 
% % disp('Computing Er and Sigma...')
% % d_start=100;       % d=500-3000km
% % d_end=3600;
% % d_interval=20;   % interval is 10km
% % d_number=(d_end-d_start)/d_interval+1;
% % 
% % d=d_start;
% % dd1=1;
% % for dd=1:d_number
% % 
% % [EMagnitude,F_n,phi_n]=...
% % Fn_phin2(AttenuationRate2,PhaseVelocity2,ExcitationFactor,d);
% % 
% % [theta_dx,t1,t2]=solve_theta_dx2(F_n,phi_n,dalpha,dvp,PhaseVelocity2,d,Nv);
% % 
% % [sum_Er,SigmaDeltaPhi]=...
% % Er_Sig2(EMagnitude,AttenuationRate2,PhaseVelocity2,ExcitationFactor,d,theta_dx);
% % 
% % Er(dd)=sum_Er;
% % sigma(dd)=SigmaDeltaPhi;
% % 
% % if mod(dd,10)==0
% %    distance2(dd1)=d;
% %    sigma2(dd1)=SigmaDeltaPhi;
% %    dd1=dd1+1;
% % end
% % 
% % d=d+d_interval;
% % 
% % end
% % 
% % plot numerical results
% % disp('plotting results...')
% % distance=d_start:d_interval:d_end;
% % figure(1)
% % subplot(2,2,2)
% % hold on
% % plot(distance,sigma,'b','Linewidth',2)
% % plot(distance2,sigma2,'bs','MarkerFaceColor','b')
% % xlabel('Propagation distance (km)')
% % ylabel('\sigma(\Delta\Phi) (\mus)')
% % title('\phi=90\circ')
% % title('\theta_b=90\circ')
% % axis([100 4000 0 20])
% % x1=500:500:4000;
% % x=[100 x1];
% % set(gca,'XTick',x)
% % set(gca,'FontSize',14)
% % box on
% % 

% plot diagrams

% calculating for Sigma(deltaPhi)
parameters3;

% input for theta_b,theta_f,theta
%==================================================
% f=10.2kHz H=87km phi=90/180*pi theta_b=180/180*pi sigma_g=0.001
theta1_real=[  1.2727862e+00   1.5409905e+00   1.1276347e+00   9.2743386e-01   6.3796002e-01   ];
theta1_imag=[  5.8069131e-03   6.0407058e-02   9.4583532e-03   9.1159281e-03   1.0065344e-02   ];

theta2_real=[  1.2727778e+00   1.5409313e+00   1.1275976e+00   9.2739843e-01   6.3763648e-01   ];
theta2_imag=[  5.8353801e-03   6.0342537e-02   9.4411031e-03   9.0839360e-03   1.0133150e-02   ];

theta3_real=[  1.2727985e+00   1.5407787e+00   1.1277362e+00   9.2744965e-01   6.3824764e-01   ];
theta3_imag=[  5.7786629e-03   6.0532899e-02   9.4797645e-03   9.1475221e-03   1.0037962e-02   ];

%===================================================
theta1=theta1_real+1i*theta1_imag;   % H
theta2=theta2_real+1i*theta2_imag;   % H+dH
theta3=theta3_real+1i*theta3_imag;   % H-dH

alpha_bf=[];
vp_bf=[];

theta_bf=[theta2;
          theta3;
          theta1];
NR_MODES=size(theta_bf,2);
Nv=1;

disp('Calculating alpha,vp,dalphadh,dvpdh...')
for hj=1:3
    theta=theta_bf(hj,:);
    Height=HH+dH(hj);
    
% calculating alpha,vp,excitation factor
[AttenuationRate3,PhaseVelocity3,ExcitationFactor,SI]=...
    alpha_vp_EF3(theta,Height);
alpha_bf(hj,:)=AttenuationRate3;
vp_bf(hj,:)=PhaseVelocity3;

end

[dalpha,dvp]=dalpha_dvp(alpha_bf,vp_bf,dH(1));

factor_v3=PhaseVelocity3.^2./dvp;

disp('Computing Er and Sigma...')
%d_start=100;       % d=500-3000km
%d_end=3600;
%d_interval=20;   % interval is 10km
%d_number=(d_end-d_start)/d_interval+1;

d=d_start;
dd1=1;
for dd=1:d_number

[EMagnitude,F_n,phi_n]=...
Fn_phin3(AttenuationRate3,PhaseVelocity3,ExcitationFactor,d);

[theta_dx,t1,t2]=solve_theta_dx3(F_n,phi_n,dalpha,dvp,PhaseVelocity3,d,Nv);

[sum_Er,SigmaDeltaPhi]=...
Er_Sig3(EMagnitude,AttenuationRate3,PhaseVelocity3,ExcitationFactor,d,theta_dx);

Er(dd)=sum_Er;
sigma(dd)=SigmaDeltaPhi;

if mod(dd,10)==0
   distance3(dd1)=d;
   sigma3(dd1)=SigmaDeltaPhi;
   dd1=dd1+1;
end

d=d+d_interval;

end

% plot numerical results
disp('plotting results...')
distance=d_start:d_interval:d_end;
semilogy((4000-distance)*4.3,sigma*30,'k','Linewidth',2)
hold on
line([0.5e4 0.5e4 nan 1e4 1e4 nan 1.5e4 1.5e4],[1 1e3 nan 1 1e3 nan 1 1e3],'color',[0.8 0.8 0.8],'LineStyle','-')
plot([10 18000],[100 100],'color',[0.8 0.8 0.8],'LineStyle','-')
hold on
plot([10 18000],[10 10],'color',[0.8 0.8 0.8],'LineStyle','-')
hold on
plot([10 18000],[1 1],'color',[0.8 0.8 0.8],'LineStyle','-')
hold on
plot([10 18000],[1000 1000],'color',[0.8 0.8 0.8],'LineStyle','-')
%plot(distance1,sigma1,'bs','MarkerFaceColor','b')
xlabel('Propagation distance (km)')
ylabel('\sigma(\Delta\Phi) (\mus)')
%title('\phi=0\circ')
title('\theta_b=45\circ')
axis([0 17000 0 1000])
set(gca,'XTick',[1000 3000 5000 7000 9000 11000 13000 15000 17000]);%设置要显示坐标刻度

% hold on
% 
% h=87*10^3;
% c=3*10^8;
% pa=0:20*10^3;
% a=6371*10^3;%可能要进行修改6371km
% theta=pa*1000/a;
% k=2*pi*f/c;%空气中的波长
% omega=2*pi*f;
% epslion_rg=6;         % parameters of ground/sea water        
% sigma_g=0.001;
% epslion_0=8.854*10^-12;  % 空气中的介电常数
% mur_0=4*pi*10^-7;        % parameters of air
% epslion_g=(epslion_0*epslion_rg+1i*(sigma_g/omega));
% phi=22.5/180*pi;
% k0=omega*sqrt(mur_0*epslion_0);    % wave numbers
% kg=omega*sqrt(mur_0*epslion_g);
% deta_gs=k0/kg;
% S0=sin(1.5123+0.96149i);%1.5474+0.75631i 1.5122+0.96245i
% C0=cos(1.5123+0.96149i);
% ef=1/(1+sin(2*k*C0*h)/(2*k*C0*h))*S0^0.5;%0.804393565446881+0.038398900210270i
% D=a*theta;
% b=sin(theta);
% E_r=exp(1i*pi/4)*1i*deta_gs*D/(2*a)*cos(phi).*...
%     sqrt(2./(pi*sin(theta)))*sqrt(k*a*S0)*ef.*exp(1i*k0*a*S0*theta);
% 
% S1=sin(1.5527+0.76613i);%1.5474+0.75631i 1.5149+0.93748i
% C1=cos(1.5527+0.76613i);
% ef=1/(1+sin(2*k*C1*h)/(2*k*C1*h))*S1^0.5;%0.804393565446881+0.038398900210270i
% E_rnp=exp(1i*pi/4)*1i*deta_gs*D/(2*a)*cos(phi).*...
%       sqrt(2./(pi*sin(2*pi-theta)))*sqrt(k*a*S1)*ef.*exp(1i*k0*a*S1*(2*pi-theta));
% 
% plot(pa,20*log(abs((E_r+E_rnp))),'k-','LineWidth',1.8);
% % axis([0 20*10^3 10^-4 10^-2]);
% hold on
% line([0.5e4 0.5e4 nan 1e4 1e4 nan 1.5e4 1.5e4],[-200 -50 nan -200 -50 nan -200 -50],'color',[0.8 0.8 0.8],'LineStyle','-')
% hold on
% plot([0 2e4],[-150 -150],'color',[0.8 0.8 0.8],'LineStyle','-')
% hold on
% plot([0 2e4],[-100 -100],'color',[0.8 0.8 0.8],'LineStyle','-')
% % semilogy(pa,abs(E_r));
% xlabel('Propagation Distance(km)')
% title('\theta_b=30^{\circ}')
% ylabel('|E_he_r|/(\etaIds/hD) in dB')
% x=[1000 5000 10000 15000 20000];%[100 1000 2000 3000 4000]
% set(gca,'XTick',x)
% set(gca,'YLim',[-200 -50]);%设置要显示坐标刻度
% box on










% x1=500:500:4000;
% figure(1)
% subplot(2,2,3)
% hold on
% plot(distance,sigma,'b','Linewidth',2)
% %plot(distance3,sigma3,'bs','MarkerFaceColor','b')
% xlabel('Propagation distance (km)')
% ylabel('\sigma(\Delta\Phi) (\mus)')
% %title('\phi=180\circ')
% title('\theta_b=180\circ')
% axis([100 4000 0 20])
% %x1=500:500:4000;
% %x=[100 x1];
% set(gca,'XTick',x)
% %set(gca,'FontSize',14)
% box on

% plot diagrams

% % calculating for Sigma(deltaPhi)
% parameters4;
% 
% % input for theta_b,theta_f,theta
% %==================================================
% % f=10.2kHz H=87km phi=90/180*pi theta_b=135/180*pi sigma_g=0.001 
% theta1_real=[  1.4765094e+00   1.0986227e+00   9.9337919e-01   7.7950861e-01   ];
% theta1_imag=[  1.3692041e-02   1.6444403e-02   1.3882826e-02   1.8469805e-02   ];
% 
% theta2_real=[  1.4765348e+00   1.0986286e+00   9.9336523e-01   7.7944431e-01   ];
% theta2_imag=[  1.3682978e-02   1.6398341e-02   1.3879961e-02   1.8466694e-02   ];
% 
% theta3_real=[  1.4764840e+00   1.0986152e+00   9.9344867e-01   7.7958703e-01   ];
% theta3_imag=[  1.3701190e-02   1.6505102e-02   1.3882765e-02   1.8461129e-02   ];
% 
% %===================================================
% theta1=theta1_real+1i*theta1_imag;   % H
% theta2=theta2_real+1i*theta2_imag;   % H+dH
% theta3=theta3_real+1i*theta3_imag;   % H-dH
% 
% alpha_bf=[];
% vp_bf=[];
% 
% theta_bf=[theta2;
%           theta3;
%           theta1];
% NR_MODES=size(theta_bf,2);
% Nv=1;
% 
% disp('Calculating alpha,vp,dalphadh,dvpdh...')
% for hj=1:3
%     theta=theta_bf(hj,:);
%     Height=HH+dH(hj);
%     
% % calculating alpha,vp,excitation factor
% [AttenuationRate4,PhaseVelocity4,ExcitationFactor,SI]=...
%     alpha_vp_EF4(theta,Height);
% alpha_bf(hj,:)=AttenuationRate4;
% vp_bf(hj,:)=PhaseVelocity4;
% 
% end
% 
% [dalpha,dvp]=dalpha_dvp(alpha_bf,vp_bf,dH(1));
% 
% factor_v4=PhaseVelocity4.^2./dvp;
% 
% disp('Computing Er and Sigma...')
% %d_start=100;       % d=500-3000km
% %d_end=3600;
% %d_interval=20;   % interval is 10km
% %d_number=(d_end-d_start)/d_interval+1;
% 
% d=d_start;
% dd1=1;
% for dd=1:d_number
% 
% [EMagnitude,F_n,phi_n]=...
% Fn_phin4(AttenuationRate4,PhaseVelocity4,ExcitationFactor,d);
% 
% [theta_dx,t1,t2]=solve_theta_dx4(F_n,phi_n,dalpha,dvp,PhaseVelocity4,d,Nv);
% 
% [sum_Er,SigmaDeltaPhi]=...
% Er_Sig4(EMagnitude,AttenuationRate4,PhaseVelocity4,ExcitationFactor,d,theta_dx);
% 
% Er(dd)=sum_Er;
% sigma(dd)=SigmaDeltaPhi;
% 
% if mod(dd,10)==0
%    distance4(dd1)=d;
%    sigma4(dd1)=SigmaDeltaPhi;
%    dd1=dd1+1;
% end
% 
% d=d+d_interval;
% end
% 
% % plot numerical results
% disp('plotting results...')
% distance=d_start:d_interval:d_end;
% % figure(1)
% % subplot(2,2,1)
% % hold on
% semilogy((4000-distance)*3.5,sigma*30,'k','Linewidth',2)
% hold on
% line([0.5e4 0.5e4 nan 1e4 1e4 nan 1.5e4 1.5e4],[1 1e3 nan 1 1e3 nan 1 1e3],'color',[0.8 0.8 0.8],'LineStyle','-')
% plot([10 14000],[100 100],'color',[0.8 0.8 0.8],'LineStyle','-')
% hold on
% plot([10 14000],[10 10],'color',[0.8 0.8 0.8],'LineStyle','-')
% hold on
% plot([10 14000],[1 1],'color',[0.8 0.8 0.8],'LineStyle','-')
% hold on
% plot([10 14000],[1000 1000],'color',[0.8 0.8 0.8],'LineStyle','-')
% %plot(distance1,sigma1,'bs','MarkerFaceColor','b')
% xlabel('Propagation distance (km)')
% ylabel('\sigma(\Delta\Phi) (\mus)')
% %title('\phi=0\circ')
% title('\theta_b=45\circ')
% axis([100 14000 0 100 0])
% % x1=500:500:4000;