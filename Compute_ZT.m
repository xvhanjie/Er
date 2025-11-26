% COMPUTE ZT

% FOR DEBUGGING ONLY, PRINT CO-ORDINATE OF LOWER 
% LEFT CORNER
% OF CURRENT MESH SQUARE. RESULTING SET OF PRINTED
% CO-ORDINATES GIVES TRACE OF EACH LINE ALONG WHICH
% IMAG(F)=0.0 FROM ITS ENTRY ON THE EDGE OF THE
% RECTANGLE TO ITS EXIT AT ANOTHER POINT ON THE
% RECTANGLE.
if MPRINT~=0      % 60
disp(['LR=' num2str(LR) ' LI=' num2str(LI)])
end

% TEST FOR THERE BEING TWO (HYPERBOLIC) LINES 
% ENTERING AND LEAVING
% THE MESH SQUARE ALONG EACH OF WHICH IMAG(F)=0.0
% IF SO, SET 'LTWO' NON-ZERO.
LTWO=0;
if (((imag(F00)>0)&&(imag(F11)>0))&&...
   ((imag(F10)<0)&&(imag(F01)<0)))||...
   (((imag(F00)<0)&&(imag(F11)<0))&&...
   ((imag(F10)>0)&&(imag(F01)>0)))
   LTWO=1;
end 
    
% TEST FOR THERE BEING AT LEAST 
% ONE (HYPERBOLIC) LINE ENTERING AND
% LEAVING THE MESH SQUARE ALONG WHICH REAL(F)=0.0
% IF NOT, SET 'I90' TO ZERO.
I90=1;
if ((real(F00)>0)&&(real(F10)>0)&&...
   (real(F01)>0)&&(real(F11)>0))||...
   ((real(F00)<0)&&(real(F10)<0)&&...
   (real(F01)<0)&&(real(F11)<0))
   I90=0;
end

if (LTWO==0)&&(I90==0) 
    return
end
% COMPUTATION OF COEFFICIENTS TO BE USED IN 
% DESCRIBING THE VARIATION
% OF THE FUNCTION WITHIN A MESH SQUARE GIVEN THE
% VALUES AT THE CORNERS OF THE SQUARE AND LINEAR
% VARIATION ALONG ITS EDGES. ALSO, THE POSITION OF
% CROSSING OF THE HYPERBOLIC ASYMPTOTES (WHICH ARE
% PARALLEL TO THE SIDES OF THE SQUARE) FOR THE LINES 
% IMAG(F)=0.0 ARE COMPUTED IF BOTH LINES (BRANCHES)
% ENTER AND LEAVE THE SQUARE.

% Computation of theta/zeros
PARTS=F00;
AR=real(PARTS);
AI=imag(PARTS);
PARTS=F01-F00;
BR=real(PARTS);
BI=imag(PARTS);
PARTS=F10-F00;
CR=real(PARTS);
CI=imag(PARTS);
PARTS=F00+F11-F01-F10;
DR=real(PARTS);
DI=imag(PARTS);

% computation for CENTER
if LTWO~=0
    CENTER_R=-BI/DI;
    CENTER_I=-CI/DI;
if I90==0
    return;   % 70
end
end
P1=BR*DI-BI*DR;
P2=CR*DI-CI*DR;
Q1=AR*DI+BR*CI-AI*DR-BI*CR;
Q2=AR*DI+CR*BI-AI*DR-CI*BR;
W1=AR*CI-AI*CR;
W2=AR*BI-AI*BR;

% SOLUTION FOR TWO POSSIBLE POINTS AT WHICH THERE 
% MAY BE CROSSINGS
% OF THE (HYPERBOLIC) LINES REAL(F)=0.0 AND
% IMAG(F)=0.0.
% A CROSSING POINT IS CHOSEN TO BE A ZERO OF THE
% FUNCTION IF IT LIES WITHIN THE CURRENT MESH SQUARE
% AND IF IT LIES ON THE BRANCH OF IMAG(F)=0.0 CURRENTLY
% BEING FOLLOWED. MULTIPLE CROSSING ALONG THIS BRANCH 
% (ACTUALLY A SERIES OF CONNECTING HYPERBOLIC BRANCHES)
% IN THE SAME OR IN DIFFERENT SQUARES ARE NOTED SINCE
% THESE MUST LATER BE RESOLVED.
if abs(P1)<abs(P2) 
    PQW=[P1 Q1 W1];
    SOL1=roots(PQW);
    NR_SOL1=size(SOL1,1);
    SOL=[];
    J=1;
    for I=1:NR_SOL1
        if imag(SOL1(I))==0
            SOL(J)=SOL1(I);
            J=J+1;
        end
    end
    NR_SOL=size(SOL,2);
if NR_SOL==0 
   return
else if SOL(1)==SOL(2)
        NR_SOL=1;
     end
end
for N=1:NR_SOL
    UIMAG=SOL(N);
if (UIMAG<0)||(UIMAG>1) 
    continue
end
D1=CR+DR*UIMAG;
D2=CI+DI*UIMAG;
if abs(D1)>=abs(D2) 
    UREAL=-(AR+BR*UIMAG)/D1;
else 
    UREAL=-(AI+BI*UIMAG)/D2;
end
if (UREAL<0)||(UREAL>1)
    continue
end
if LTWO~=0
if ((ENTER_R-CENTER_R)*(UREAL-CENTER_R)<0)||...
   ((ENTER_I-CENTER_I)*(UIMAG-CENTER_I)<0) 
    continue
end
end
THETA_R=(LR+UREAL)*TMESH;
THETA_I=(LI+UIMAG)*TMESH;
%if THETA_R<0||THETA_I<0
 %   continue
%end
THETA=THETA_R+1i*THETA_I;
if MPRINT~=0
disp(['LR=' num2str(LR) ' LI=' num2str(LI) ' THETA=' num2str(THETA)])
end
NR_ZT=NR_ZT+1;
ZEROS(NR_ZT)=THETA;
if NR_ZL==0 
    NR_Z=NR_Z+1;
end
NR_ZL=NR_ZL+1;
end

else          % abs(P1)>abs(P2)
    PQW2=[P2 Q2 W2];
    SOL1=roots(PQW2);
    NR_SOL1=size(SOL1,1);
    SOL=[];
    J=1;
    for I=1:NR_SOL1
        if imag(SOL1(I))==0
            SOL(J)=SOL1(I);
            J=J+1;
        end
    end
    NR_SOL=size(SOL,2);
if NR_SOL==0 
    return
else if SOL(1)==SOL(2)
        NR_SOL=1;
    end
end
for N=1:NR_SOL
    UREAL=SOL(N);      % U--solution of theta    
if (UREAL<0)||(UREAL>1) 
    continue
end
D1=BR+DR*UREAL;
D2=BI+DI*UREAL;
if (abs(D1)>=abs(D2))
    UIMAG=-(AR+CR*UREAL)/D1;
else
    UIMAG=-(AI+CI*UREAL)/D2;
end
if (UIMAG<0)||(UIMAG>1)
    continue
end
if LTWO~=0
if ((ENTER_R-CENTER_R)*(UREAL-CENTER_R)<0)||...
   ((ENTER_I-CENTER_I)*(UIMAG-CENTER_I)<0) 
   continue
end
end
THETA_R=(LR+UREAL)*TMESH;
THETA_I=(LI+UIMAG)*TMESH;
%if THETA_R<0||THETA_I<0
 %   continue
%end
THETA=THETA_R+1i*THETA_I;
if MPRINT~=0
disp(['LR=' num2str(LR) ' LI=' num2str(LI) ' THETA=' num2str(THETA)])
end
NR_ZT=NR_ZT+1;
ZEROS(NR_ZT)=THETA;
if NR_ZL==0 
    NR_Z=NR_Z+1;
end
NR_ZL=NR_ZL+1;
end
end

return


