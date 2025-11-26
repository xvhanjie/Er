%parameters
clc;clear
f=10e3;  % f=12.5kHz%10.2e3
dH=0.001*1000;
h=87*10^3;
omega=2*pi*f;
epslion_rg=6;         % parameters of ground/sea water        
sigma_g=0.001;
epslion_0=8.854*10^-12;  % 空气中的介电常数
mur_0=4*pi*10^-7;        % parameters of air
epslion_g=(epslion_0*epslion_rg+1i*(sigma_g*100/omega));
phi=60/180*pi;
k0=omega*sqrt(mur_0*epslion_0)/100;    % wave numbers
kg=omega*sqrt(mur_0*epslion_g)/100;
deta_gs=k0/kg;
% landa=2*pi/k0;
c=1/(sqrt(mur_0*epslion_0));

d1=10:20:4000;
d3=d1;
d5=d1;
d2=8000-d1;
d4=d2;
d6=d2;
d=[d1 d2;
   d3 d4;
   d5 d6];
%%%%%%%%%%
theta1=[1.533410232409750 + 0.741859454944438i    1.518877440983322 + 0.951111510393440i];%H
theta2=[1.533414798877859 + 0.741847563404646i    1.518871024674196 + 0.951068670767732i];%H+dH
theta3=[1.533405667401961 + 0.741871344989044i    1.518883854862082 + 0.951154389993516i];%H-dH
% theta3=[];theteab=30,phib=90,270,矩阵为(3,2)
theta_bf=[theta1;
          theta2;
          theta3;];
Cn=cos(theta_bf);
Sn=sin(theta_bf);
ef=(1-1i)*deta_gs*cos(phi)/(2*sqrt(pi))*1./(1+sin(2*k0*Cn*h)./(2*k0*Cn*h)).*Sn.^0.5;%(15)激励因子
alfa=8.6858*k0*imag(Sn);%(13)衰减率(3*2)
v=c./(real(Sn));%(14)相速度(3*2)

%%%%%%%%%%%%求幅度和相位,这里面1000
NB_path=size(theta_bf,2);%有几条路径
numb=size(d1*5,2);
for i=1:3
    F1(i,:)=abs(ef(i,1))*exp(-0.115*alfa(i,1)*d1*5000);
    F2(i,:)=abs(ef(i,2))*exp(-0.115*alfa(i,2)*d2*5000);
    phase_1(i,:)=omega*d1*50/v(i,1)+angle(ef(i,1));%(18)相位
    phase_2(i,:)=omega*d2*50/v(i,2)+angle(ef(i,2));%(18)相位
end
F=[F1 F2];
phase=[phase_1 phase_2];%%(2d,3)
%%%%%%%%%%%%%%%%%%%%%
M2=(F1.*cos(phase_1)+F2.*cos(phase_2)).^2+(F1.*sin(phase_1)+F2.*sin(phase_2)).^2;%%(3,d)
% M2=(1+F2./F1.*cos(phase_2-phase_1)).^2+(F2./F1.*sin(phase_2-phase_1)).^2;
%差分法求dalfa_dh和dv_dh-------1行n列
dalfa_dh=(alfa(2,:)-alfa(3,:))/(2*dH);
dv_dh=(v(2,:)-v(3,:))/(2*dH);
dalfa1=dalfa_dh(1,1);
dalfa2=dalfa_dh(1,2);
dv1=dv_dh(1,1);
dv2=dv_dh(1,2);
v1=v(1,1);
v2=v(1,2);

result=0.115*F1(1,:).*F2(1,:).*sin(phase_1(1,:)-phase_2(1,:))*(dalfa1-dalfa2)...
       +omega/100*(F1(1,:).*F2(1,:).*cos(phase_1(1,:)-phase_2(1,:))*(dv2/(v2^2)...
       +dv1/(v1^2))+F1(1,:).*F1(1,:)*...
       dv1/(v1^2)+F2(1,:).*F2(1,:)*dv2/(v2^2));

% result=0.115*F2./F1.*sin(phase_1-phase_2).*(dalfa_dh(1,1)-dalfa_dh(1,2))...
%        +2*pi*f*(F2./F1.*cos(phase_1-phase_2).*(dv_dh(:,2)./(v(:,2).^2)...
%        +dv_dh(:,1)./(v(:,1).^2))+dv_dh(:,1)./(v(:,1).^2)...
%        +F2.^2./(F1.^2).*dv_dh(:,2)./(v(:,2).^2));
K=1;%1 for daytime;2.4 for nighttime
theta_d=K*v1^2*(d1*5/1000).^(1/4)./(dv1*f*M2(1,:)).*result;
d1=4000-d1;
% fy=@(yy)atan(theta_d.*yy).^2.*exp(-(yy.^2)/2);
% D_delta_phi=1/(sqrt(2*pi))*integral(fy,-inf,inf);
% sigma_delta_phi=sqrt(D_delta_phi)*1e6/omega;   % us

syms y
D_delta_theta=1/sqrt(2*pi)*int((atan(theta_d*y)).^2.*exp(-(y.^2)/2),y,-inf,+inf);
final=sqrt(D_delta_theta)*300/omega;

plot(d1,20*log(final),'r-','LineWidth',2);
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;clear
f=10e3;  % f=12.5kHz%10.2e3
dH=0.001*1000;
h=70*10^3;
omega=2*pi*f;
epslion_rg=6;         % parameters of ground/sea water        
sigma_g=0.001;
epslion_0=8.854*10^-12;  % 空气中的介电常数
mur_0=4*pi*10^-7;        % parameters of air
epslion_g=(epslion_0*epslion_rg+1i*(sigma_g*100/omega));
phi=60/180*pi;
k0=omega*sqrt(mur_0*epslion_0)/100;    % wave numbers
kg=omega*sqrt(mur_0*epslion_g)/100;
deta_gs=k0/kg;
% landa=2*pi/k0;
c=1/(sqrt(mur_0*epslion_0));

d1=10:20:4000;
d3=d1;
d5=d1;
d2=8000-d1;
d4=d2;
d6=d2;
d=[d1 d2;
   d3 d4;
   d5 d6];
%%%%%%%%%%
theta1=[1.533585343460306 + 0.742657338590874i    1.509410771514669 + 1.039305058781040i];%H
theta2=[1.533589880584778 + 0.742645599625745i    1.509422094007427 + 1.039131051663556i];%H+dH
theta3=[1.533580807977486 + 0.742669076236330i    1.509399406317111 + 1.039479351198201i];%H-dH
% theta3=[];theteab=30,phib=90,270,矩阵为(3,2)
theta_bf=[theta1;
          theta2;
          theta3;];
Cn=cos(theta_bf);
Sn=sin(theta_bf);
ef=(1-1i)*deta_gs*cos(phi)/(2*sqrt(pi))*1./(1+sin(2*k0*Cn*h)./(2*k0*Cn*h)).*Sn.^0.5;%(15)激励因子
alfa=8.6858*k0*imag(Sn);%(13)衰减率(3*2)
v=c./(real(Sn));%(14)相速度(3*2)

%%%%%%%%%%%%求幅度和相位,这里面1000
NB_path=size(theta_bf,2);%有几条路径
numb=size(d1*5,2);
for i=1:3
    F1(i,:)=abs(ef(i,1))*exp(-0.115*alfa(i,1)*d1*5000);
    F2(i,:)=abs(ef(i,2))*exp(-0.115*alfa(i,2)*d2*5000);
    phase_1(i,:)=omega*d1*50/v(i,1)+angle(ef(i,1));%(18)相位
    phase_2(i,:)=omega*d2*50/v(i,2)+angle(ef(i,2));%(18)相位
end
F=[F1 F2];
phase=[phase_1 phase_2];%%(2d,3)
%%%%%%%%%%%%%%%%%%%%%
M2=(F1.*cos(phase_1)+F2.*cos(phase_2)).^2+(F1.*sin(phase_1)+F2.*sin(phase_2)).^2;%%(3,d)
% M2=(1+F2./F1.*cos(phase_2-phase_1)).^2+(F2./F1.*sin(phase_2-phase_1)).^2;
%差分法求dalfa_dh和dv_dh-------1行n列
dalfa_dh=(alfa(2,:)-alfa(3,:))/(2*dH);
dv_dh=(v(2,:)-v(3,:))/(2*dH);
dalfa1=dalfa_dh(1,1);
dalfa2=dalfa_dh(1,2);
dv1=dv_dh(1,1);
dv2=dv_dh(1,2);
v1=v(1,1);
v2=v(1,2);

result=0.115*F1(1,:).*F2(1,:).*sin(phase_1(1,:)-phase_2(1,:))*(dalfa1-dalfa2)...
       +omega/100*(F1(1,:).*F2(1,:).*cos(phase_1(1,:)-phase_2(1,:))*(dv2/(v2^2)...
       +dv1/(v1^2))+F1(1,:).*F1(1,:)*...
       dv1/(v1^2)+F2(1,:).*F2(1,:)*dv2/(v2^2));
K=2.4;%1 for daytime;2.4 for nighttime
theta_d=K*v1^2*(d1*5/1000).^(1/4)./(dv1*f*M2(1,:)).*result;
d1=4000-d1;
syms y
D_delta_theta=1/sqrt(2*pi)*int((atan(theta_d*y)).^2.*exp(-(y.^2)/2),y,-inf,+inf);
final=sqrt(D_delta_theta)*20/omega;

plot(d1,20*log(final),'b-','LineWidth',2);
hold on
xlabel('传播距离 (km)')
ylabel('电场E_r (dB)')




