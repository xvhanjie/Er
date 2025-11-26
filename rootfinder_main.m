clear;clc
% main function multi-modes interference variance
% modal equation expressed with airy functions
% modal equation solved by ROOTFINDER
disp('ROOTFINDER STARTS...')
start_t=cputime;

parameters;   % setting parameters

% Setting MESH rectangle
TLEFT=0;
TRIGHT=pi/2;
TTOP=pi/20;
TBOT=0;

%=========== for test only =================
tn_intl=[1.6681+1.3086i;
       -0.5346+3.1711i;
       -7.1171+3.1844i;
       -19.9290+2.8394i;
       -38.0435+2.7334i];
   a=EarthRadius*1000;
cni=sqrt(-tn_intl)*(2/(k0*a))^(1/3);
thetan=acos(cni);
THETAN=thetan/TMESH;
%=========================================

Fzeros;    % SEARCH MESH RECTANGLE AND FIND ROOTS

if NR_Z~=0   % Compare and process roots
 
   ZEROSN=Newton_iteration(ZEROS); 
   final_ZEROS=Compare_ZEROS(ZEROSN);
   SINZEROS=sin(final_ZEROS);
   sinzeros=filter_sin(SINZEROS);
   final_sin=Compare_ZEROSin(sinzeros);
   final_theta=asin(final_sin);
   realtheta=real(final_theta);
   imagtheta=imag(final_theta);
   save('realtheta.txt','realtheta','-ascii')
   save('imagtheta.txt','imagtheta','-ascii')
   
end

end_t=cputime;
ct=end_t-start_t;
disp(['Time consumed for finding zeros is ' num2str(ct) ' seconds'])


