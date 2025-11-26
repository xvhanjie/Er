x=[0 2 4 6 8 10];
y1=[0.65 0.645 0.64 0.586 0.626 0.615];
y2=[82 84 88 95 73 67];
hold on;
[AX,H1,H2] =plotyy(x,y1,x,y2,@plot);% 获取坐标轴、图像句柄
set(get(AX(1),'ylabel'),'string', '峰值透过率','fontsize',16);
set(get(AX(2),'ylabel'),'string', '半高宽/nm','fontsize',16);
xlabel('倾斜角度/°','fontsize',16);
set(H1,'Linestyle','--');
set(H2,'Linestyle',':');
set(gcf,'color','white')
set(gca,'linewidth',1.5) %设置边框宽度  