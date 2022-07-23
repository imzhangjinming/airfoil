function [y_top,y_bot] = get_shangxia(yixing)
%搞一个通用的工具，用来把一个完整的翼型拆分成阳间的上下两部分。
index_min = find(yixing(:,1)==min(yixing(:,1)));
index_min = index_min(1) ; 
% 去研会的屁事了，估计一去就是明天再回来写了。2021年3月20日19:04:18
% 2021年3月21日12:52:09接着写。
index_max = find(yixing(:,1)==max(yixing(:,1)));
index_max = index_max(1) ; 
y_top =  [] ; 
y_bot = [] ; 
if(yixing(index_min,2)>yixing(index_min+1,2))
    %x最小的那个点，的下一个点，y比它小,说明前沿顺着是延伸到下表面去了
    if(index_min<index_max)
        %最正常的，直接连接到后面了。
        y_bot = [y_bot ; yixing(index_min:index_max,:)] ;
        y_top = [y_top ; flipud(yixing(1:index_min,:))  ;flipud(yixing(index_max:end,:)) ] ; 
        %这个写法会有点重复。
    elseif(index_min>index_max)
        %后面的点索引在前面
        y_top = [y_top ; flipud(yixing(index_max:index_min,:))];
        y_bot = [y_bot ; yixing(index_min:end,:) ; yixing(1:index_max,:)] ;
    else
        fprintf('MXairfoil: 这个情况还没写，用到了现场写一下吧. \n get_shangxia \n')
        mydebug(index_min);
    end
elseif(yixing(index_min,2)<yixing(index_min+1,2))
    %x最小的那个点，的下一个点，y比它大,说明前沿顺着是延伸到上表面去了
    y_top = [y_top ; yixing(index_min:index_max,:)] ; 
    y_bot = [y_bot ; flipud(yixing(1:index_min,:)) ; flipud(yixing(index_max:end,:))] ; 
%     mydebug(yixing);
%     fprintf('MXairfoil: 这个情况还没写，用到了现场写一下吧. \n get_shangxia \n')
else
    mydebug(yixing);
    fprintf('MXairfoil: 这个情况还没写，用到了现场写一下吧. 不过多半数据有问题 \n get_shangxia \n')
end

end