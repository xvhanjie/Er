% solve for D0 and De

b4=t*(t^2-h^2)-t^2+hL^2;
b3=2*S*cos(phi)*hL*hT;
b2=2*t*((1-S^2)*h^2-(t-1)*((1-S^2)*t-1))-...
    hT^2*(1-S^2*(cos(phi))^2)-hL^2*(2-S^2);
b1=-2*(1-S^2)*S*cos(phi)*hL*hT;
b0=(t-1)*(((1-S^2)*t-1)^2-(1-S^2)*hT^2*(cos(phi))^2)...
    -(1-S^2)*((1-S^2)*t-1)*(hT^2*sin(phi)^2+hL^2);

B=[b4 b3 b2 b1 b0];
Db=roots(B);
ld=0;
Doe=zeros(1,2);
for jj=1:size(Db,1)
    if real(Db(jj))>10 || imag(Db(jj))>10
        ld=ld+1;
        Doe(ld)=Db(jj);
    end
end

if imag(Doe(1))>imag(Doe(2))
   Do=Doe(1);
   De=Doe(2);
else
   Do=Doe(2);
   De=Doe(1);
end

D=[Do De];   % longitudinal wave number of 
             % ordinary wave and extraordinary wave
                   
                   