function zhi = huatu2_compare_mul(input_cell ,label_cell,name)
    %这个是为了比较优化前后的叶形而弄的。
    if nargin==2
        shijian = datestr(datetime('today','Format','yyyy-MM-dd')) ; 
%         wenjianming = ['..\airfoil-compare\',shijian,'.png'] ;  
        wenjianming = ['..\airfoil-compare\',shijian] ; 
    else 
        wenjianming = name;
    end
    [~,N_airfoil] = size(input_cell) ; 
    [~,N_label] = size(label_cell) ; 
    if N_airfoil ~= N_label
        fprintf('MXairfoil: wrong data, G !');
        return
    end
    fig=figure(1);
    set(fig,'Paperunits','centimeters','Paperposition',[14 19 9 6.4],'PaperpositionMode','manual')
    hold on 
    Grey = [190 190 190]./255 ;
    DimGrey = [105 105 105]./255 ; 
    Firebrick = [178 34 34] ./ 255 ; 
    Red = [255 0 0] ./ 255 ; 
    Green = [0 255 0] ./ 255 ; 
    yanse = {Grey,Firebrick,DimGrey,Red,Green} ; 
    xianxing = { '-' ,  '-.' ,'--' , ':' , 'none'} ; 
    for i = 1:N_airfoil
        yixing = input_cell{i} ; 
        plot(yixing(:,1),yixing(:,2),'Color',yanse{mod(i,4)},...
        'LineStyle',xianxing{mod(i,4)},'LineWidth',1);
    end
    
    % '.' 是无效值。请使用以下某个值: '-' | '--' | ':' | '-.' | 'none'。
    
    legend(label_cell,'Location','southeast','TextColor',[0,0,0],...
        'FontSize',8,'FontName','Times New Roman') ;
    % title('Comparing Original and Redesigned airfoil','FontSize',8,'FontName','Times New Roman')
    grid off ; 
    
    axis('equal') ; 
    ylim([-3 3]) % this is for CDA,not for R67_7
    xlim([0 13])
    
    xlabel('{\it u/cm}','FontSize',9,'FontWeight','bold','Color','k','Interpreter','tex','FontName','Times New Roman') ;
    ylabel('{\it v/cm}','FontSize',9,'FontWeight','bold','Color','k','Interpreter','tex','FontName','Times New Roman'); % 'Fontangle','italic'
    set(gca,'FontSize',8)
    set(gca,'FontName','Times New Roman')

    print(fig,wenjianming,'-dpng','-r1200')
%     print(fig,wenjianming,'-dtiff','-r1200')
%     print(fig,[wenjianming '.tiff'],'-dtiff','-r1200')
%     print(fig,[wenjianming '.eps'],'-depsc','-r1200')
%     print(fig,[wenjianming '.pdf'],'-dpdf','-r1200')
    
    hold off 
%     close(fig)
    zhi = 0 ;
end