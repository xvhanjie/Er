% Search along edge 1,2,3,4 of contour rectangle

% SEARCH ALONG LEFT EDGE OF RECTANGLE FOR
% SIGN CHANGES IN IMAG(F).
disp('START SEARCH EDGE')

if KEDGE==1
while KI~=JBOT
     conti=0;
     KI=KI-1;
     disp(['KR=' num2str(KR) ' KI=' num2str(KI)])
     F=Find_F(KR,KI);
     if ((imag(Prev_F)>0)&&(imag(F)>0))||...
        ((imag(Prev_F)<0)&&(imag(F)<0))
        Prev_F=F;  %20
        continue
     end
     if NR_E1~=0
     for K=1:NR_E1
     if (KI==K_EDGE1(K))
         conti=1;
         Prev_F=F;  %20
     end
     end
     if conti==1
        continue
     end
     end
        F01=Prev_F;
        F00=F;
        LI=KI;
        LR=JLT;
        % 43 Enter from left edge
        F11=Find_F(LR+1,LI+1);
        F10=Find_F(LR+1,LI);   
        LEDGE=1;
        ENTER_R=0;
        ENTER_I=-imag(F00)/(imag(F01)-imag(F00));
        rt=60;      % go to 60
        while rt~=10
              Compute_ZT;   % 60
              Test_for_Exit_Edge; % 70
        end
        if NR_ZL~=0      % 10
           NR_ZLS(NR_Z)=NR_ZL;
           %NR_ZL=0;
        end
        Prev_F=F;  %20
        if NR_ZL>0
        disp([num2str(NR_ZL) ' MODES FOUND ON SAME PHASE LINE'])
        end
        NR_ZL=0;
end
KEDGE=2;
end

    
% SEARCH ALONG BOTTOM EDGE OF RECTANGLE FOR
% SIGN CHANGES IN IMAG(F).
if KEDGE==2
while KR~=JRT
     conti=0;
     KR=KR+1;
     disp(['KR=' num2str(KR) ' KI=' num2str(KI)])
     F=Find_F(KR,KI);
     if ((imag(Prev_F)>0)&&(imag(F)>0))||...
        ((imag(Prev_F)<0)&&(imag(F)<0))
        Prev_F=F;  %20
        continue
     end
     if NR_E2~=0
     for K=1:NR_E2
     if (KR==K_EDGE2(K))
         conti=1;
         Prev_F=F;  %20
     end
     end
     if conti==1
        continue
     end
     end
        F00=Prev_F;
        F10=F;
        LI=JBOT;
        LR=KR-1;
        % 48 Enter from BOTTOM edge
        F01=Find_F(LR,LI+1);
        F11=Find_F(LR+1,LI+1);   
        LEDGE=2;
        ENTER_R=-imag(F00)/(imag(F10)-imag(F00));
        ENTER_I=0;
        rt=60;      % go to 60
        while rt~=10
              Compute_ZT;   % 60
              Test_for_Exit_Edge; % 70
        end
        if NR_ZL~=0      % 10
           NR_ZLS(NR_Z)=NR_ZL;
           %NR_ZL=0;
        end
        Prev_F=F;  %20
        if NR_ZL>0
        disp([num2str(NR_ZL) ' MODES FOUND ON SAME PHASE LINE'])
        end
        NR_ZL=0;
end
KEDGE=3;
end

    
% SEARCH ALONG RIGHT EDGE OF RECTANGLE FOR
% SIGN CHANGES IN IMAG(F).
if KEDGE==3
while KI~=JTOP
     conti=0;
     KI=KI+1;
     disp(['KR=' num2str(KR) ' KI=' num2str(KI)])
     F=Find_F(KR,KI);
     if ((imag(Prev_F)>0)&&(imag(F)>0))||...
        ((imag(Prev_F)<0)&&(imag(F)<0))
        Prev_F=F;  %20
        continue
     end
     if NR_E3~=0
     for K=1:NR_E3
     if (KI==K_EDGE3(K))
         conti=1;
         Prev_F=F;  %20
     end
     end
     if conti==1
        continue
     end
     end
        F10=Prev_F;
        F11=F;
        LI=KI-1;
        LR=JRT-1;
        % 53 Enter from RIGHT edge
        F01=Find_F(LR,LI+1);
        F00=Find_F(LR,LI);   
        LEDGE=3;
        ENTER_R=1;
        ENTER_I=-imag(F10)/(imag(F11)-imag(F10));
        rt=60;      % go to 60
        while rt~=10
              Compute_ZT;   % 60
              Test_for_Exit_Edge; % 70
        end
        if NR_ZL~=0      % 10
           NR_ZLS(NR_Z)=NR_ZL;
           %NR_ZL=0;
        end
        Prev_F=F;  %20
        if NR_ZL>0
        disp([num2str(NR_ZL) ' MODES FOUND ON SAME PHASE LINE'])
        end
        NR_ZL=0;
end
KEDGE=4;
end

% SEARCH ALONG TOP EDGE OF RECTANGLE FOR
% SIGN CHANGES IN IMAG(F).
if KEDGE==4
while KR~=JLT
     conti=0;
     KR=KR-1;
     disp(['KR=' num2str(KR) ' KI=' num2str(KI)])
     F=Find_F(KR,KI);
     if ((imag(Prev_F)>0)&&(imag(F)>0))||...
        ((imag(Prev_F)<0)&&(imag(F)<0))
        Prev_F=F;  %20
        continue
     end
     if NR_E4~=0
     for K=1:NR_E4
     if (KR==K_EDGE4(K))
         conti=1;
         Prev_F=F;  %20
     end
     end
     if conti==1
        continue
     end
     end
        F11=Prev_F;
        F01=F;
        LI=JTOP-1;
        LR=KR;
        % 58 Enter from BOTTOM edge
        F00=Find_F(LR,LI);
        F10=Find_F(LR+1,LI);   
        LEDGE=4;
        ENTER_R=-imag(F01)/(imag(F11)-imag(F01));
        ENTER_I=1;
        rt=60;      % go to 60
        while rt~=10
              Compute_ZT;   % 60
              Test_for_Exit_Edge; % 70
        end
        if NR_ZL~=0      % 10
           NR_ZLS(NR_Z)=NR_ZL;
           %NR_ZL=0;
        end
        Prev_F=F;  %20
        if NR_ZL>0
        disp([num2str(NR_ZL) ' MODES FOUND ON SAME PHASE LINE'])
        end
        NR_ZL=0;
end
end

disp('Search Edge Completed')
disp([num2str(NR_ZT) ' ZEROS FOUND'])
disp([num2str(NR_Z) ' PHASE LINE FOUND'])

