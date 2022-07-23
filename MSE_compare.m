function zhi = MSE_compare(original,optimized)
% 这个是用来强行计算两个点列的最小二乘误差的。但是讲道理还是挺粗糙的。输入是两个翼型。
[original_shang,original_xia] = get_shangxia(original) ; 
[optimized_shang,optimized_xia] = get_shangxia(optimized) ; 
chazhi_shang = chazhi_jisuan(original_shang,optimized_shang) ;
chazhi_xia = chazhi_jisuan(original_xia,optimized_xia) ;
% 计算一个用于缩放的比例。
P_max = original(original(:,1)==max(original(:,1)),:) ; 
P_min = original(original(:,1)==min(original(:,1)),:) ;
bili = norm((P_max-P_min),2) ; 
% 然后把算出来的差值的序列弄成每个点平均的MSE
%（这个就是概念不清了，什么几把每个点平均的MSE，就直接是方差sigma^2就行了）
N_shang = size(chazhi_shang) ;
N_xia = size(chazhi_xia) ; 
zhi = (sum((chazhi_shang(:,2)./bili).^2) + sum((chazhi_xia(:,2)./bili).^2))/(N_shang(1)+N_xia(1)) ;
fprintf('MXairfoil: tested airfoil gives a sigma^2:  ')
fprintf(num2str(zhi))

end

function zhi = chazhi_jisuan(original,optimized)
% 这个是抽象的两个点列
x_original = original(:,1) ; 
x_shangjie = max(x_original)-0.1 ; 
x_xiajie = min(x_original)+0.1 ;

%从输入的序列里面截取中间的一段，用以充当下面步骤的输入。
original2 = original((x_original<x_shangjie)&(x_original>x_xiajie),:) ; 
optimized2 = optimized((optimized(:,1)<x_shangjie)&(optimized(:,1)>x_xiajie),:) ; 
zhi = subtract_2disparate(original2,optimized2) ; 
% 到这里是复用以前的，求出了一个差值序列，各种一阶插值弄出来的。
end