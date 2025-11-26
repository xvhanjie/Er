function delta=sur_impe4(theta,Height)
% solve anistropic ionosphere surface impedance
% regarding variance of theta
parameters4;

H=Height*1000;
a=EarthRadius*1000;

% theta=input;  % incidence angle on ionosphere

% angle between earth magnetic field and x-axis 
phi=phi_b;    
% angle between earth magnetic field and z-axis
de=theta_b;     % theta_b   

S=sin(theta);
C=cos(theta);

%Cp=sqrt(C^2+2*H/a*S^2);    % modified C
%S=sqrt(1-Cnp^2);
%C=Cnp;

beta=0.0077*f/1000+0.31;   % beta 1/km 
Zmax=115;%100;       % deep inside ionosphere
Zmin=75;%50;

N=1.43*10^7*exp(-0.15*Height)...
    *exp((beta-0.15)*(Zmax-Height))*10^6;
v=1.816*10^11*exp(-0.15*Zmax);

omega_02=N*e^2/(epslion_0*me);   % plasma frequency
omega_T=e*B0/me;           

omega_r=omega_02/v;
omr_om=omega_r/omega;

X=omega_02/(omega^2);
Y=omega_T/omega;
Z=v/omega;
U=1+1i*v/omega;

t=(1+1i*Z)/X;
h=Y/X;
hL=h*cos(de);
hT=h*sin(de);

lx=sin(de)*cos(phi);
ly=sin(de)*sin(phi);
lz=cos(de);

solve_D;      % solve for Do and De

M=(1-S^2-((t^2-hL^2)/(t*(t^2-h^2))))*...
 ((hT^2*cos(phi)*sin(phi)-1i*hL*t)/(t*(t^2-h^2)))...
 -(S*D+((hL*hT*cos(phi)+1i*hT*t*sin(phi))...
 /(t*(t^2-h^2))))*((hL*hT*sin(phi)+...
 1i*hT*t*cos(phi))/(t*(t^2-h^2)));

% Ex/Ey
P=(1./M).*(((hL^2*hT^2*(sin(phi))^2+hT^2*t^2*...
  (cos(phi))^2)/(t^2*(t^2-h^2)^2))-(1-S^2-D.^2-...
  ((t^2-hT^2*(sin(phi))^2)/(t*(t^2-h^2))))*...
  (1-S^2-((t^2-hL^2)/(t*(t^2-h^2)))));

% Ez/Ey
Q=(1./M).*((1-S^2-D.^2-((t^2-hT^2*(sin(phi))^2)...
    /(t*(t^2-h^2)))).*(S*D+((hL*hT*cos(phi)...
    +1i*hT*t*sin(phi))/(t*(t^2-h^2))))-...
    ((hT^2*cos(phi)*sin(phi)-1i*hL*t)*...
    (hT*hL*sin(phi)-1i*hT*t*cos(phi))...
    /(t^2*(t^2-h^2)^2)));

R=S;            % g*Hz/Ey
L=-D;           % g*Hx/Ey
T=D.*P-S.*Q;    % g*Hy/Ey

Po=P(1);
Pe=P(2);
Qo=Q(1);
Qe=Q(2);
To=T(1);
Te=T(2);

% initial value for surface impedance
DT=Do*Te-De*To;
delta_initial_11=(Pe*Do-Po*De)/DT;
delta_initial_12=(Pe*To-Po*Te)/DT;
delta_initial_21=(Do-De)/DT;
delta_initial_22=(To-Te)/DT;

delta_initial=[delta_initial_11;
               delta_initial_12;
               delta_initial_21;
               delta_initial_22];
           
delta_initial_r=[delta_initial_11 delta_initial_12;
                 delta_initial_21 delta_initial_22];
R_initial=delta2R(delta_initial_r,C);

% homogenous sharp boundary
% reflection coefficients
delta_vv=(C+De)*(Po-C*To)-(C+Do)*(Pe-C*Te);
delta_vh=2*C*(Do-De);
delta_hv=2*C*(Pe*To-Po*Te);
delta_hh=(De-C)*(Po+C*To)-(Do-C)*(Pe+C*Te);
delta_VH=(C+Do)*(Pe+C*Te)-(C+De)*(Po+C*To);

R_vv=delta_vv/delta_VH;
R_vh=delta_vh/delta_VH;  
R_hv=delta_hv/delta_VH;  
R_hh=delta_hh/delta_VH;

R_hsb=[R_vv R_vh;R_hv R_hh];
delta_hsb=R2delta(R_hsb,C);

solve_delta_i_matrix;

delta=delta_h0_ode;

end


















