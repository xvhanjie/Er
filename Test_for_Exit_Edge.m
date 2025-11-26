% TEST FOR EXIT FROM EDGE 1,2,3,4

% 70 TEST FOR EXIT FROM LEFT EDGE OF MESH SQUARE.
if LEDGE~=1    
if ~(((imag(F00)>0)&&(imag(F01)>0))||...
   ((imag(F00)<0)&&(imag(F01)<0))) % different sign     
if LTWO==0
    % 51 exit at left or enter at right
LR=LR-1;
if LR>=JLT
    F11=F01;
    F10=F00; % move 1 mesh square toward left side
    F01=Find_F(LR,LI+1);
    F00=Find_F(LR,LI);
    LEDGE=3;
    ENTER_R=1;
    ENTER_I=-imag(F10)/(imag(F11)-(F10));
    return       % go to 60
else
NR_E1=NR_E1+1;
K_EDGE1(NR_E1)=LI;
rt=10;
return     % go to 10
end
end

EXIT_R=0;
EXIT_I=-imag(F00)/(imag(F01)-imag(F00));
if ((ENTER_R-CENTER_R)*(EXIT_R-CENTER_R)>0)&&...
   ((ENTER_I-CENTER_I)*(EXIT_I-CENTER_I)>0)
% 51 exit at left or enter at right
LR=LR-1;
if LR>=JLT
    F11=F01;
    F10=F00; % move 1 mesh square toward left side
    F01=Find_F(LR,LI+1);
    F00=Find_F(LR,LI);
    LEDGE=3;
    ENTER_R=1;
    ENTER_I=-imag(F10)/(imag(F11)-imag(F10));
    return   % to 60
else
NR_E1=NR_E1+1;
K_EDGE1(NR_E1)=LI;
rt=10;
return     % go to 10
end
end
end
end

% 72 TEST FOR EXIT FROM BOTTOM EDGE OF MESH SQUARE.
if LEDGE~=2   
if ~(((imag(F00)>0)&&(imag(F10)>0))||...
   ((imag(F00)<0)&&(imag(F10)<0)))        
if LTWO==0
    % 56 exit at BOT or enter at TOP
LI=LI-1;
if LI>=JBOT
    F01=F00;
    F11=F10; % move 1 mesh square toward BOT side
    F00=Find_F(LR,LI);
    F10=Find_F(LR+1,LI);
    LEDGE=4;
    ENTER_R=-imag(F01)/(imag(F11)-imag(F01));
    ENTER_I=1;
    return % to 60
else
NR_E2=NR_E2+1;
K_EDGE2(NR_E2)=LR+1;
rt=10;
return     % go to 10
end
end

EXIT_R=-imag(F00)/(imag(F10)-imag(F00));
EXIT_I=0;
if ((ENTER_R-CENTER_R)*(EXIT_R-CENTER_R)>0)&&...
   ((ENTER_I-CENTER_I)*(EXIT_I-CENTER_I)>0)
 % 56 exit at BOT or enter at TOP
LI=LI-1;
if LI>=JBOT
    F01=F00;
    F11=F10; % move 1 mesh square toward BOT side
    F00=Find_F(LR,LI);
    F10=Find_F(LR+1,LI);
    LEDGE=4;
    ENTER_R=-imag(F01)/(imag(F11)-imag(F01));
    ENTER_I=1;
    return  % to 60
else
NR_E2=NR_E2+1;
K_EDGE2(NR_E2)=LR+1;
rt=10;
return     % to 10
end
end
end
end

% 73 TEST FOR EXIT FROM RIGHT EDGE OF MESH SQUARE.
if LEDGE~=3  
if ~(((imag(F10)>0)&&(imag(F11)>0))||...
   ((imag(F10)<0)&&(imag(F11)<0)))        
if LTWO==0
    % 41 exit at RIGHT or enter at LEFT
LR=LR+1;
if LR<=JRT-1
    F01=F11;
    F00=F10; % move 1 mesh square toward RIGHT side
    F11=Find_F(LR+1,LI+1);
    F10=Find_F(LR+1,LI);
    LEDGE=1;
    ENTER_R=0;
    ENTER_I=-imag(F00)/(imag(F01)-imag(F00));
    return   % to 60
else
NR_E3=NR_E3+1;
K_EDGE3(NR_E3)=LI+1;
rt=10;
return     % go to 10
end
end

EXIT_R=1;
EXIT_I=-imag(F10)/(imag(F11)-imag(F10));
if ((ENTER_R-CENTER_R)*(EXIT_R-CENTER_R)>0)&&...
   ((ENTER_I-CENTER_I)*(EXIT_I-CENTER_I)>0)
  % 41 exit at RIGHT or enter at LEFT
LR=LR+1;
if LR<=JRT-1
    F01=F11;
    F00=F10; % move 1 mesh square toward RIGHT side
    F11=Find_F(LR+1,LI+1);
    F10=Find_F(LR+1,LI);
    LEDGE=1;
    ENTER_R=0;
    ENTER_I=-imag(F00)/(imag(F01)-imag(F00));
    return     % 60
else
NR_E3=NR_E3+1;
K_EDGE3(NR_E3)=LI+1;
rt=10;
return     % go to 10
end
end
end
end

% 74 TEST FOR EXIT FROM TOP EDGE OF MESH SQUARE.
if LEDGE~=4
if ~(((imag(F01)>0)&&(imag(F11)>0))||...
   ((imag(F01)<0)&&(imag(F11)<0)))        
if LTWO==0
    % 46 exit at TOP or enter at BOT
LI=LI+1;
if LI<=JTOP-1
    F00=F01;
    F10=F11; % move 1 mesh square toward TOP side
    F01=Find_F(LR,LI+1);
    F11=Find_F(LR+1,LI+1);
    LEDGE=2;
    ENTER_R=-imag(F00)/imag((F10)-imag(F00));
    ENTER_I=0;
    return   % to 60
else
NR_E4=NR_E4+1;
K_EDGE4(NR_E4)=LR;
rt=10;
return     % go to 10
end
end

EXIT_R=-imag(F01)/(imag(F11)-imag(F01));
EXIT_I=1;
if ((ENTER_R-CENTER_R)*(EXIT_R-CENTER_R)>0)&&...
   ((ENTER_I-CENTER_I)*(EXIT_I-CENTER_I)>0)
    % 46 exit at TOP or enter at BOT
LI=LI+1;
if LI<=JTOP-1
    F00=F01;
    F10=F11; % move 1 mesh square toward TOP side
    F01=Find_F(LR,LI+1);
    F11=Find_F(LR+1,LI+1);
    LEDGE=2;
    ENTER_R=-imag(F00)/imag((F10)-imag(F00));
    ENTER_I=0;
    return   % to 60
else
NR_E4=NR_E4+1;
K_EDGE4(NR_E4)=LR;
rt=10;
return    % go to 10
end
end
end
end

disp('NO EXIT FROM MESH SQUARE')
rt=10;
NO_EXIT=NO_EXIT+1;
return     % go to 10




