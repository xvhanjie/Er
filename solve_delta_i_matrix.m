syms delta_i_11 delta_i_12 delta_i_21 delta_i_22 zi
%r=a+zi;

delta_i_matrix=[delta_i_11 delta_i_12;
                delta_i_21 delta_i_22];
h0=Height*1000;   % m equivalent height of ionosphere
N_matrix=1.43*10^7*exp(-0.15*(h0/1000))...
    *exp((beta-0.15)*((zi-h0)/1000))*10^6;
v_matrix=1.816*10^11*exp(-0.15*(zi/1000));

% plasma frequency         
omega_02_matrix=N_matrix*e^2/(epslion_0*me);   

X_i=omega_02_matrix/(omega^2);
U_i=1+1i*v_matrix/omega;

% electrical polarization rate matrix
M_i=-X_i/(U_i*(U_i^2-Y^2))*...
    [U_i^2-lx^2*Y^2 1i*lz*Y*U_i-lx*ly*Y^2 ...
     -1i*ly*Y*U_i-lx*lz*Y^2;
     -1i*lz*Y*U_i-lx*ly*Y^2 U_i^2-ly^2*Y^2 ...
     1i*lx*Y*U_i-lz*ly*Y^2;
     1i*ly*Y*U_i-lx*lz*Y^2 -1i*lx*Y*U_i-ly*lz*Y^2 ...
     U_i^2-lz^2*Y^2];

%S0=S;

T_i=[-S*M_i(3,1)/(1+M_i(3,3)) ...
    S*M_i(3,2)/(1+M_i(3,3)) 0 ...
    (C^2+M_i(3,3))/(1+M_i(3,3));
    0 0 1 0;
    M_i(2,3)*M_i(3,1)/(1+M_i(3,3))-M_i(2,1) ...
    C^2+M_i(2,2)-M_i(2,3)*M_i(3,2)/(1+M_i(3,3)) ...
    0 S*M_i(2,3)/(1+M_i(3,3));
    1+M_i(1,1)-M_i(1,3)*M_i(3,1)/(1+M_i(3,3)) ...
    M_i(1,3)*M_i(3,2)/(1+M_i(3,3))-M_i(1,2) ...
    0 -S*M_i(1,3)/(1+M_i(3,3))];

T_delta_1=[T_i(4,1) -T_i(4,2);T_i(3,1) -T_i(3,2)];
T_delta_2=[T_i(4,4) 0;T_i(3,4) 0];
T_delta_3=[T_i(1,1) -T_i(1,2);0 0];
T_delta_4=[T_i(1,4) 0;0 -1];

d_delta_i_matrix_dz=k0*...
  (-1i*delta_i_matrix*T_delta_1*delta_i_matrix-...
   1i*delta_i_matrix*T_delta_2+...
   1i*T_delta_3*delta_i_matrix+1i*T_delta_4);

d_delta_dz=[d_delta_i_matrix_dz(1,1);
            d_delta_i_matrix_dz(1,2);
            d_delta_i_matrix_dz(2,1);
            d_delta_i_matrix_dz(2,2)];
d_delta_dz_f=matlabFunction(d_delta_dz,...
    'vars',{zi,[delta_i_11;delta_i_12;...
    delta_i_21;delta_i_22;]});

zmax=Zmax*1000;
zmin=Zmin*1000;
% Zmin--actual low boundary of ionosphere
[zzi,delta_final]=ode45(d_delta_dz_f,[zmax zmin],delta_initial);
delta_z0_result=delta_final(size(delta_final,1),:);
delta_z0_ode=[delta_z0_result(1) delta_z0_result(2);
              delta_z0_result(3) delta_z0_result(4)];
%Cpz0=sqrt(C^2+2*zmin/a*S^2);
R_z0_ode=delta2R(delta_z0_ode,C);
    
% h0--equivalent low boundary of ionoshpere
%Cm=sqrt(C^2+2*((h0+zmin)/2)/a*S^2);
R_h0_ode=R_z0_ode*exp(-2*1i*k0*C*(h0-zmin));
%Cp=sqrt(C^2+2*H/a*S^2);
delta_h0_ode=R2delta(R_h0_ode,C);

 
        
        
        
        
        
