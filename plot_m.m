% calculating for Sigma(deltaPhi)
clc;clear
start_time=cputime;
parameters;
% input for theta_b,theta_f,theta
%=============================================
% H=70 B=0.5e-4 a=6370 zd=0 theta_b=0
theta1_real=[1.2807661e+00   1.4848173e+00   8.4281167e-01   8.1949632e-01   5.4373506e-01   5.1968476e-01];
theta1_imag=[3.1215644e-03   7.7446356e-02   1.8427522e-02   3.2409754e-02   4.3058523e-02   1.3070955e-01];

% H=70+0.001
theta2_real=[1.2807721e+00   1.4848179e+00   8.4278740e-01   8.1944105e-01   5.4378024e-01   5.1940630e-01];
theta2_imag=[3.1208367e-03   7.7446141e-02   1.8373651e-02   3.2488272e-02   4.3041735e-02   1.3059736e-01];

% H=70-0.001
theta3_real=[1.2807601e+00   1.4848167e+00   8.4283594e-01   8.1955119e-01   5.4368979e-01   5.1996368e-01];
theta3_imag=[3.1222854e-03   7.7446571e-02   1.8481715e-02   3.2331363e-02   4.3075204e-02   1.3082203e-01];

%============================================
theta1=theta1_real+1i*theta1_imag;   % H
theta2=theta2_real+1i*theta2_imag;   % H+dH
theta3=theta3_real+1i*theta3_imag;   % H-dH
theta_b=0;
theta_bf=[theta2;
          theta3;
          theta1];
NR_MODES=size(theta_bf,2);
Nv=NR_MODES;
alpha_bf=[];
vp_bf=[];
disp('Calculating alpha,vp,dalphadh,dvpdh...')
for hj=1:3
    theta=theta_bf(hj,:);
    Height=HH+dH(hj);
    
% calculating alpha,vp,excitation factor
[AttenuationRate,PhaseVelocity,ExcitationFactor]=...
    alpha_vp_EF(theta,Height,theta_b);
alpha_bf(hj,:)=AttenuationRate;
vp_bf(hj,:)=PhaseVelocity;

end

[dalpha,dvp]=dalpha_dvp(alpha_bf,vp_bf,dH(1));

disp('Computing Er and Sigma...')
d_start=0;       % d=500-3000km
d_end=3500;
d_interval=10;   % interval is 10km
d_number=(d_end-d_start)/d_interval+1;

d=d_start;
for dd=1:d_number

[EMagnitude,F_n,phi_n]=...
Fn_phin(AttenuationRate,PhaseVelocity,ExcitationFactor,d);

theta_dx=solve_theta_dx(F_n,phi_n,dalpha,dvp,PhaseVelocity,d,Nv);

[sum_Er,SigmaDeltaPhi]=...
Er_Sig(EMagnitude,AttenuationRate,PhaseVelocity,ExcitationFactor,d,theta_dx);

Er(dd)=sum_Er;
sigma(dd)=SigmaDeltaPhi;

d=d+d_interval;

end

% plot numerical results
disp('plotting results...')
distance=d_start:d_interval:d_end;
figure(1)
subplot(2,1,1)
hold on
plot(distance,sigma,'b','Linewidth',2)

subplot(2,1,2)
hold on
plot(distance,10*log10(abs(1000*Er)),'b','Linewidth',2)

figure(2)
subplot(2,1,1)
hold on
plot(distance,sigma,'b','Linewidth',2)
subplot(2,1,2)
hold on
plot(distance,sigma,'b','Linewidth',2)
%plot(distance,10*log10(abs(1000*Er)),'b','Linewidth',2)

% input for theta_b,theta_f,theta
%=============================================
% H=70 B=0.5e-4 a=6370 zd=0 theta_b=pi/6
theta1_real=[1.2815907e+00   1.4847779e+00   8.3281183e-01   8.1387800e-01   5.4081625e-01   4.4134865e-01];
theta1_imag=[2.4566676e-03   7.7526971e-02   2.4935641e-02   5.0120322e-02   4.0585614e-02   1.4958883e-01];

% H=70+0.001
theta2_real=[1.2816079e+00   1.4846013e+00   8.3279706e-01   8.1402242e-01   5.4082725e-01   4.4116984e-01];
theta2_imag=[2.4682047e-03   7.7465475e-02   2.4959936e-02   5.0181874e-02   4.0580427e-02   1.4973150e-01];

% H=70-0.001
theta3_real=[1.2815780e+00   1.4847781e+00   8.3282651e-01   8.1373274e-01   5.4080402e-01   4.4152731e-01];
theta3_imag=[2.4555075e-03   7.7508710e-02   2.4911391e-02   5.0057593e-02   4.0562241e-02   1.4944667e-01];

%============================================
theta1=theta1_real+1i*theta1_imag;   % H
theta2=theta2_real+1i*theta2_imag;   % H+dH
theta3=theta3_real+1i*theta3_imag;   % H-dH
theta_b=pi/6;
theta_bf=[theta2;
          theta3;
          theta1];
NR_MODES=size(theta_bf,2);
Nv=NR_MODES;
alpha_bf=[];
vp_bf=[];
disp('Calculating alpha,vp,dalphadh,dvpdh...')
for hj=1:3
    theta=theta_bf(hj,:);
    Height=HH+dH(hj);
    
% calculating alpha,vp,excitation factor
[AttenuationRate,PhaseVelocity,ExcitationFactor]=...
    alpha_vp_EF(theta,Height,theta_b);
alpha_bf(hj,:)=AttenuationRate;
vp_bf(hj,:)=PhaseVelocity;

end

[dalpha,dvp]=dalpha_dvp(alpha_bf,vp_bf,dH(1));

disp('Computing Er and Sigma...')
d_start=0;       % d=500-3000km
d_end=3500;
d_interval=10;   % interval is 10km
d_number=(d_end-d_start)/d_interval+1;

d=d_start;
for dd=1:d_number

[EMagnitude,F_n,phi_n]=...
Fn_phin(AttenuationRate,PhaseVelocity,ExcitationFactor,d);

theta_dx=solve_theta_dx(F_n,phi_n,dalpha,dvp,PhaseVelocity,d,Nv);

[sum_Er,SigmaDeltaPhi]=...
Er_Sig(EMagnitude,AttenuationRate,PhaseVelocity,ExcitationFactor,d,theta_dx);

Er(dd)=sum_Er;
sigma(dd)=SigmaDeltaPhi;

d=d+d_interval;

end

% plot numerical results
disp('plotting results...')
distance=d_start:d_interval:d_end;
figure(1)
subplot(2,1,1)
plot(distance,sigma,'r-.','Linewidth',2)

subplot(2,1,2)
plot(distance,10*log10(abs(1000*Er)),'r-.','Linewidth',2)

% input for theta_b,theta_f,theta
%=============================================
parameters2;
% H=70 f=10kHz theta_b=0 B=0.5e-4
theta1_real=[1.1937225e+00   1.4673353e+00   8.9306073e-01   6.6858319e-01];
theta1_imag=[5.7285318e-03   6.7385060e-02   1.6539824e-02   1.0277645e-01];

% H=70+0.001
theta2_real=[1.1937227e+00   1.4673359e+00   8.9305735e-01   6.6826760e-01];
theta2_imag=[5.7261971e-03   6.7384637e-02   1.6458011e-02   1.0266877e-01];

% H=70-0.001
theta3_real=[1.1937224e+00   1.4673347e+00   8.9305761e-01   6.6889879e-01];
theta3_imag=[5.7308890e-03   6.7385484e-02   1.6621249e-02   1.0288374e-01];

%============================================
theta1=theta1_real+1i*theta1_imag;   % H
theta2=theta2_real+1i*theta2_imag;   % H+dH
theta3=theta3_real+1i*theta3_imag;   % H-dH
theta_b=0;
theta_bf=[theta2;
          theta3;
          theta1];
NR_MODES=size(theta_bf,2);
Nv=NR_MODES;
alpha_bf=[];
vp_bf=[];
disp('Calculating alpha,vp,dalphadh,dvpdh...')
for hj=1:3
    theta=theta_bf(hj,:);
    Height=HH+dH(hj);
    
% calculating alpha,vp,excitation factor
[AttenuationRate,PhaseVelocity,ExcitationFactor]=...
    alpha_vp_EF2(theta,Height,theta_b);
alpha_bf(hj,:)=AttenuationRate;
vp_bf(hj,:)=PhaseVelocity;

end

[dalpha,dvp]=dalpha_dvp(alpha_bf,vp_bf,dH(1));

disp('Computing Er and Sigma...')
d_start=0;       % d=500-3000km
d_end=3500;
d_interval=10;   % interval is 10km
d_number=(d_end-d_start)/d_interval+1;

d=d_start;
for dd=1:d_number

[EMagnitude,F_n,phi_n]=...
Fn_phin2(AttenuationRate,PhaseVelocity,ExcitationFactor,d);

theta_dx=solve_theta_dx2(F_n,phi_n,dalpha,dvp,PhaseVelocity,d,Nv);

[sum_Er,SigmaDeltaPhi]=...
Er_Sig2(EMagnitude,AttenuationRate,PhaseVelocity,ExcitationFactor,d,theta_dx);

Er(dd)=sum_Er;
sigma(dd)=SigmaDeltaPhi;

d=d+d_interval;

end

% plot numerical results
disp('plotting results...')
distance=d_start:d_interval:d_end;
figure(2)
subplot(2,1,1)
plot(distance,sigma,'r-.','Linewidth',2)

%subplot(2,1,2)
%plot(distance,10*log10(abs(1000*Er)),'r-.','Linewidth',2)


% input for theta_b,theta_f,theta
%=============================================
parameters1;
% H=70 f=12.5kHz thete_b=0 B=0.4e-4T
theta1_real=[1.2811546e+00   1.4847634e+00   8.1483006e-01   5.3251261e-01   9.9088355e-01   7.3588002e-01   4.2418827e-01];
theta1_imag=[2.3000033e-03   7.7485384e-02   3.7748059e-02   4.4754743e-02   1.2924526e-01   1.7354722e-01   1.5994612e-01];

% H=70+0.001
theta2_real=[1.2811586e+00   1.4847639e+00   8.1488796e-01   5.3252661e-01   9.9114483e-01   7.3562524e-01   4.2403873e-01];
theta2_imag=[2.2968714e-03   7.7485145e-02   3.7681153e-02   4.4755335e-02   1.2822637e-01   1.7343736e-01   1.6011472e-01];

% H=70-0.001
theta3_real=[1.2811506e+00   1.4847629e+00   8.1477091e-01   5.3249862e-01   9.9048203e-01   7.3613435e-01   4.2433792e-01];
theta3_imag=[2.3032538e-03   7.7485622e-02   3.7815084e-02   4.4754212e-02   1.3047245e-01   1.7365835e-01   1.5977848e-01];

%============================================
theta1=theta1_real+1i*theta1_imag;   % H
theta2=theta2_real+1i*theta2_imag;   % H+dH
theta3=theta3_real+1i*theta3_imag;   % H-dH
theta_b=0;
theta_bf=[theta2;
          theta3;
          theta1];
NR_MODES=size(theta_bf,2);
Nv=NR_MODES;
alpha_bf=[];
vp_bf=[];
disp('Calculating alpha,vp,dalphadh,dvpdh...')
for hj=1:3
    theta=theta_bf(hj,:);
    Height=HH+dH(hj);
    
% calculating alpha,vp,excitation factor
[AttenuationRate,PhaseVelocity,ExcitationFactor]=...
    alpha_vp_EF1(theta,Height,theta_b);
alpha_bf(hj,:)=AttenuationRate;
vp_bf(hj,:)=PhaseVelocity;

end

[dalpha,dvp]=dalpha_dvp(alpha_bf,vp_bf,dH(1));

disp('Computing Er and Sigma...')
d_start=0;       % d=500-3000km
d_end=3500;
d_interval=10;   % interval is 10km
d_number=(d_end-d_start)/d_interval+1;

d=d_start;
for dd=1:d_number

[EMagnitude,F_n,phi_n]=...
Fn_phin1(AttenuationRate,PhaseVelocity,ExcitationFactor,d);

theta_dx=solve_theta_dx1(F_n,phi_n,dalpha,dvp,PhaseVelocity,d,Nv);

[sum_Er,SigmaDeltaPhi]=...
Er_Sig1(EMagnitude,AttenuationRate,PhaseVelocity,ExcitationFactor,d,theta_dx);

Er(dd)=sum_Er;
sigma(dd)=SigmaDeltaPhi;

d=d+d_interval;

end

% plot numerical results
disp('plotting results...')
distance=d_start:d_interval:d_end;
figure(2)
subplot(2,1,2)
plot(distance,sigma,'r-.','Linewidth',2)

%figure(2)
%plot(distance,10*log10(abs(1000*Er)),'k--','Linewidth',2)


figure(1)
subplot(2,1,1)
hold off
box on
xlabel('Propagation distance (km)')
ylabel('\sigma(\Delta\Phi) (\mus)')
legend('\theta_b=0\circ',...
       '\theta_b=30\circ')
set(gca,'FontSize',14)

figure(1)
subplot(2,1,2)
hold off
box on
xlabel('Propagation distance (km)')
ylabel('|E_r| in dB(\muV/m)')
legend('\theta_b=0\circ',...
       '\theta_b=30\circ')
set(gca,'FontSize',14)

figure(2)
subplot(2,1,1)
hold off
box on
xlabel('Propagation distance (km)')
ylabel('\sigma(\Delta\Phi) (\mus)')
legend('f=12.5kHz','f=10kHz')
%title('Phase standard deviation with different frequency')
set(gca,'FontSize',14)
subplot(2,1,2)
hold off
box on
xlabel('Propagation distance (km)')
ylabel('\sigma(\Delta\Phi) (\mus)')
legend('B_0=0.5\times10^{-4}T','B_0=0.4\times10^{-4}T')
%title('Phase standard deviation with different B_0')
set(gca,'FontSize',14)


end_time=cputime;
time=end_time-start_time;
disp(['Duration for processing is ' num2str(time) 's'])



