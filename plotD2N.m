function plot_Er_sig(dq,ZO1,ER1,SIGMA1,ZO2,ER2,SIGMA2)
disp('plotting results...')


%%%%%%%%%%%%%%%%%%%%%%%%%%白天下的电场空间分布%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DBER=20*log10(abs(1000*ER1));
% imagesc(dq,ZO1,DBER)
% colorbar
% % h3=colorbar('Position',[0.474 0.116 0.02 0.32],'Ytick',[-10 10 30 50 70]);
% % set(get(h3,'title'),'string','(dB)');
% % caxis([-10 70])
% colormap(jet)
% xlabel('传播距离 (km)')
% ylabel('高度 (km)')
% title('电场强度 (白天)')
% X=[100 500 1000 1500 2000];
% Y=[0 10 20 30 40 50 60 70];
% set(gca,'Xtick',X)
% set(gca,'Ytick',Y)
% set(gca,'YDir','normal')
% set(gca,'FontName','Times New Roman')
% set(gca,'ticklength',[0 0])
% %box off


%%%%%%%%%%%%%%%%%%%%%%%%%%夜晚下的电场空间分布%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('plotting results...')

DBER=20*log10(abs(1000*ER2));
plot(dq,DBER(:,1))
% h=colorbar('Position',[0.915 0.116 0.02 0.32],'Ytick',[0 10 30 50 70]);%,'title','dB')
% set(get(h,'title'),'string','(dB)');
% caxis([0 70])
% colorbar
% colormap(jet)
xlabel('传播距离 (km)')
ylabel('高度 (km)')
title('电场强度 (夜晚)')
% X=[100 500 1000 1500 2000];
% Y=[0 10 20 30 40 50 60 70 80 87];
set(gca,'Xtick',X)
set(gca,'Ytick',Y)
set(gca,'YDir','normal')
set(gca,'FontName','Times New Roman')
set(gca,'ticklength',[0 0])
%box off


end



