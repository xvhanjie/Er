% calculating for Sigma(deltaPhi)
clc;clear
start_time=cputime;
parameters1;

% input for theta_b,theta_f,theta
%==================================================
% f=10.2kHz H=70km phi=90/180*pi theta_b=45/180*pi sigma_g=0.001
theta1_real=[  1.3652600e+00   1.1182345e+00   1.2174559e+00   8.7268213e-01   8.3940062e-01   5.4476760e-01   4.9263289e-01];
theta1_imag=[  2.2843240e-02   4.4539533e-02   6.7974152e-02   7.0797080e-02   1.1097873e-01   1.0210369e-01   1.7222250e-01];

theta2_real=[  1.3652650e+00   1.1182406e+00   1.2174597e+00   8.7269803e-01   8.3942731e-01   5.4479564e-01   4.9270142e-01];
theta2_imag=[  2.2843603e-02   4.4538697e-02   6.7975687e-02   7.0789792e-02   1.1098270e-01   1.0209203e-01   1.7222306e-01];

theta3_real=[  1.3652551e+00   1.1182285e+00   1.2174518e+00   8.7268017e-01   8.3937436e-01   5.4473928e-01   4.9256460e-01];
theta3_imag=[  2.2842886e-02   4.4539814e-02   6.7972688e-02   7.0807811e-02   1.1097605e-01   1.0211541e-01   1.7222111e-01];

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
    [AttenuationRate,PhaseVelocity,ExcitationFactor,SI]=...
        alpha_vp_EF1(theta,Height);
    alpha_bf(hj,:)=AttenuationRate;
    vp_bf(hj,:)=PhaseVelocity;
    
end
[dalpha,dvp]=dalpha_dvp(alpha_bf,vp_bf,dH(1));

factor_v1=PhaseVelocity.^2./dvp;

disp('Computing Er and Sigma...')
d_start=100;       % d=500-3000km
d_end=2000;
dq=linspace(d_start,d_end,100);
%d_interval=39;   % interval is 10km
%d_number=(d_end-d_start)/d_interval+1;
d_number=length(dq);
%d=d_start;

ZO1=linspace(0,HH,100);
for jz=1:length(ZO1)
    disp(['jz=' num2str(jz)])
    zo=ZO1(jz);
    exfac=EF1(theta,HH,zo);
    EXFAC1(jz,:)=exfac;
    
    for dd=1:d_number
        %disp(['dd=' num2str(dd)])
        d=dq(dd);
        [EMagnitude,F_n,phi_n]=...
            Fn_phin1(AttenuationRate,PhaseVelocity,exfac,d);
        
        [theta_dx,t1,t2]=solve_theta_dx1(F_n,phi_n,dalpha,dvp,PhaseVelocity,d,Nv);
        
        [sum_Er,SigmaDeltaPhi]=...
            Er_Sig1(EMagnitude,AttenuationRate,PhaseVelocity,exfac,d,theta_dx);
        
        Er(dd)=sum_Er;
        sigma(dd)=SigmaDeltaPhi;
    end
    ER1(jz,:)=Er;
    SIGMA1(jz,:)=sigma;
    %d=d+d_interval;
    
end

% plot numerical results



% calculating for Sigma(deltaPhi)
parameters2;

% input for theta_b,theta_f,theta
%==================================================
% f=10.2kHz H=87km phi=90/180*pi theta_b=45/180*pi sigma_g=0.001
theta1_real=[   1.4765094e+00   1.0986227e+00   9.9337919e-01 ];%  7.7950861e-01  ];% 3.7418226e-01   5.0449427e-01];
theta1_imag=[   1.3692041e-02   1.6444403e-02   1.3882826e-02 ]; % 1.8469805e-02   ];%1.4319092e-02   3.1769858e-02];

theta2_real=[   1.4765348e+00   1.0986286e+00   9.9336523e-01  ];% 7.7944431e-01  ];% 3.7399452e-01   5.0435179e-01];
theta2_imag=[   1.3682978e-02   1.6398341e-02   1.3879959e-02  ];% 1.8466694e-02  ];% 1.4297143e-02   3.0882086e-02];

theta3_real=[  1.4764840e+00   1.0986152e+00   9.9344867e-01  ];% 7.7958703e-01  ];% 3.7425706e-01   5.0466773e-01];
theta3_imag=[  1.3701190e-02   1.6505102e-02   1.3882765e-02  ];% 1.8461129e-02  ];% 1.4389710e-02   3.0847974e-02];

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
    [AttenuationRate,PhaseVelocity,ExcitationFactor,SI]=...
        alpha_vp_EF2(theta,Height);
    alpha_bf(hj,:)=AttenuationRate;
    vp_bf(hj,:)=PhaseVelocity;
    
end
[dalpha,dvp]=dalpha_dvp(alpha_bf,vp_bf,dH(1));

factor_v2=PhaseVelocity.^2./dvp;

disp('Computing Er and Sigma...')
d_start=100;       % d=500-3000km
d_end=2000;
dq=linspace(d_start,d_end,100);
%d_interval=39;   % interval is 10km
%d_number=(d_end-d_start)/d_interval+1;
d_number=length(dq);
%d=d_start;
EXFAC=[];
ZO2=linspace(0,HH,100);
for jz=1:length(ZO2)
    disp(['jz=' num2str(jz)])
    zo=ZO2(jz);
    exfac=EF2(theta,HH,zo);
    EXFAC2(jz,:)=exfac;
    
    for dd=1:d_number
        %disp(['dd=' num2str(dd)])
        d=dq(dd);
        [EMagnitude,F_n,phi_n]=...
            Fn_phin2(AttenuationRate,PhaseVelocity,exfac,d);
        
        [theta_dx,t1,t2]=solve_theta_dx2(F_n,phi_n,dalpha,dvp,PhaseVelocity,d,Nv);
        
        [sum_Er,SigmaDeltaPhi]=...
            Er_Sig2(EMagnitude,AttenuationRate,PhaseVelocity,exfac,d,theta_dx);
        
        Er(dd)=sum_Er;
        sigma(dd)=SigmaDeltaPhi;
    end
    ER2(jz,:)=Er;
    SIGMA2(jz,:)=sigma;
    %d=d+d_interval;
    
end

% plot numerical results
plot_Er_sig(dq,ZO1,ER1,SIGMA1,ZO2,ER2,SIGMA2);

end_time=cputime;
time=end_time-start_time;
disp(['Duration for processing is ' num2str(time) 's'])

