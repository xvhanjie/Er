TOL=0.01;
nan=0;
kcount=0;
    xprevs=0;
    xtheta=ZEROS(8);
    disp(['theta= ' num2str(xtheta)])
    while (abs(real(xtheta-xprevs))>TOL)...
            ||(abs(imag(xtheta-xprevs))>0.1*TOL)
    xprevs=xtheta;
  
    [gx,gprimex]=F_DFDT(xtheta);
    xtheta=xtheta-gx/gprimex;
    disp(['theta= ' num2str(xtheta)])
    if (isnan(real(xtheta)))||(isnan(imag(xtheta)))...
            ||(abs(real(xtheta))>10)||(abs(imag(xtheta))>1)
        nan=nan+1;
        disp('root is NaN or Inf, continue next...')
        break
    end
    kcount=kcount+1;
    disp(['kcount= ' num2str(kcount)])
    end