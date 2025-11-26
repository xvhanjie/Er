function [dalpha,dvp]=dalpha_dvp(alpha_bf,vp_bf,dH)
dH=dH*1000;
alpha_b=alpha_bf(2,:);
alpha_f=alpha_bf(1,:);
dalpha=(alpha_f-alpha_b)/(2*dH);

vp_b=vp_bf(2,:);
vp_f=vp_bf(1,:);
dvp=(vp_f-vp_b)/(2*dH);

end