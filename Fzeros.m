% SUBROUTINE FZEROS (TLEFT,TRIGHT,TBOT,TTOP,
% TMESH,TOL,MPRINT,ZEROS,NR_Z)

% SIDES OF RECTANGLE IN TMESH UNITS

JLT=TLEFT/TMESH;
JLT=round(JLT);
if TLEFT >= 0 
    JLT=JLT-1;
else
    JLT=JLT-2;
end

JRT=TRIGHT/TMESH;
JRT=round(JRT);
if TRIGHT > 0
    JRT=JRT+2;
else
    JRT=JRT+1;
end

JBOT=TBOT/TMESH;
JBOT=round(JBOT);
if TBOT >= 0
    JBOT=JBOT-1;
else
    JBOT=JBOT-2;
end

JTOP=TTOP/TMESH;
JTOP=round(JTOP);
if TTOP > 0
    JTOP=JTOP+2;
else
    JTOP=JTOP+1;
end

disp(['JLT=' num2str(JLT) ', JRT=' num2str(JRT)])
disp(['JTOP=' num2str(JTOP) ', JBOT=' num2str(JBOT)])
disp(['TMESH=' num2str(TMESH)])

% INITIALIZATION OF PARAMETERS.
MPRINT=1;

KI=JTOP;    % search starts from left-top corner
KR=JLT;
KEDGE=1;
disp(['START: KR=' num2str(KR) ' KI=' num2str(KI)])

F=Find_F(KR,KI);   % compute the value at (KR,KI)

NR_E1=0;           % inilization of NR-EDGE
NR_E2=0;           % number of exit on each edge
NR_E3=0;
NR_E4=0;

NR_ZT=0;           % number of theta
NR_ZL=0;           % number of modes on same line
NR_Z=0;            % Number of line with Zeros
NO_EXIT=0;

Prev_F=F;          % 20, initialize Prev_F

% search edge 1,2,3,4 of contour rectangle
% include compute theta/zeros and test for exit
Search_Edge; 

NR_EDGE=[NR_E1;NR_E2;NR_E3;NR_E4];

disp('READY FOR NO MESH')
       
        













