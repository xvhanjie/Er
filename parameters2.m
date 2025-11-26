% setting background parameters

f=10e3;                  % f=12.5kHz
omega=2*pi*f;
TMESH=sqrt(3.75/f);

%Height=87-0.001;      % km equivalent reflection height  

EarthRadius=6370;     % radius of earth 6370km
Height_D=0;           % height of dipole 0km
Height_O=0;           % height of observation 0km
HH=87;                % reference height of ionosphere 70km
dH=[0.001 -0.001 0];         % unit is m
% difference of h_iono

me=9.3*10^(-31);        % eletron mass
e=1.6*10^(-19);         % eletron charge
B0=0.5*10^(-4);         % earth magnetic field T

theta_b=45/180*pi;      % azimuth angle of B0
phi_b=90/180*pi;

mur_0=4*pi*10^-7;        % parameters of air
epslion_0=8.854*10^-12;
LightSpeed=1/(sqrt(mur_0*epslion_0));

epslion_rg=80;         % parameters of ground/sea water        
sigma_g=4;

epslion_g=(epslion_0*epslion_rg+1i*(sigma_g/omega));

k0=omega*sqrt(mur_0*epslion_0);    % wave numbers
kg=omega*sqrt(mur_0*epslion_g);

delta_g=k0/kg;   
% normalized surface impedance of earth






