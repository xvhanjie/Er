function ZEROSN=Newton_iteration(ZEROSS)
% Newton's iteration method

NR_ZS=size(ZEROSS,2);
ZEROSN=zeros(1,NR_ZS);
number_it=zeros(1,NR_ZS);
TOL=0.01;
nan=0;
for j=1:NR_ZS
    disp(['Start iteration of ZEROS(' num2str(j) ')...'])
    xvalid=1;
    kcount=0;
    xprevs=0;
    xtheta=ZEROSS(j);
    while (abs(real(xtheta-xprevs))>TOL)...
            ||(abs(imag(xtheta-xprevs))>0.1*TOL)
    xprevs=xtheta;
  
    [gx,gprimex]=F_DFDT(xtheta);
    xtheta=xtheta-gx/gprimex;
   
    if (isnan(real(xtheta)))||(isnan(imag(xtheta)))...
            ||(abs(real(xtheta))>10)||(abs(imag(xtheta))>1)
        nan=nan+1;
        xvalid=0;
        disp('root is NaN or Inf, continue next...')
        kcount=kcount+1;
        break
    end
    kcount=kcount+1;
    end
    
    if xvalid==0
        ZEROSN(j)=100;
    else
        ZEROSN(j)=xtheta;
    end
    
    number_it(j)=kcount;
    disp(['iteration number is ' num2str(kcount)])
end

disp(['Number of NaN is ' num2str(nan)])
disp('Newton iteration completed')
end


    
    
    
    
    
    
    
    
    
    