function delta=R2delta(R,C)

% transform R to delta
RVH=(1+R(1,1))*(1-R(2,2))+R(2,1)*R(1,2);

delta_11=C*((1-R(1,1))*(1-R(2,2))...
    -R(1,2)*R(2,1))/RVH;
delta_12=2*R(2,1)/RVH;
delta_21=2*R(1,2)/RVH;
delta_22=-1/C*((1+R(1,1))*(1+R(2,2))...
    -R(2,1)*R(1,2))/RVH;

delta=[delta_11 delta_12;delta_21 delta_22];

end



