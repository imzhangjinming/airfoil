function zhi = huatu2_compare(original,optimized,name)
%�����Ϊ�˱Ƚ��Ż�ǰ���Ҷ�ζ�Ū�ġ�
if nargin==2
    shijian = datestr(datetime('today','Format','yyyy-MM-dd')) ; 
    wenjianming = ['..\airfoil-compare\',shijian,'.png'] ;  
else 
    wenjianming = name;
end
fig=figure(1);
chang = 15.05 ; 
kuan = chang *1.3 ;
set(fig,'unit','centimeters','position',[5,5,kuan, chang])
hold on 
Grey = [190 190 190]./255 ;
DimGrey = [105 105 105]./255 ; 
Firebrick = [178 34 34] ./ 255 ; 
plot(original(:,1),original(:,2),'Color',DimGrey,...
    'LineStyle','-','LineWidth',1);
plot(optimized(:,1),optimized(:,2),'Color',Firebrick,...
    'LineStyle','-.','LineWidth',1);
% '.' ����Чֵ����ʹ������ĳ��ֵ: '-' | '--' | ':' | '-.' | 'none'��
legend({'Original','Optimized'},'Location','northeast','TextColor',[0,0,0],...
    'FontSize',15,'FontName','Times New Roman') ;
title('Compareing Original and Optimized airfoil',...
    'FontSize',20,'FontName','Times New Roman')
grid on ; 
axis('equal') ; 


print(fig,wenjianming,'-dpng','-r600')

hold off 
close(fig)
zhi = 0 ;
end