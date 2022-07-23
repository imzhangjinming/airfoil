function zhi = MSE_compare(original,optimized)
% ���������ǿ�м����������е���С�������ġ����ǽ�������ͦ�ֲڵġ��������������͡�
[original_shang,original_xia] = get_shangxia(original) ; 
[optimized_shang,optimized_xia] = get_shangxia(optimized) ; 
chazhi_shang = chazhi_jisuan(original_shang,optimized_shang) ;
chazhi_xia = chazhi_jisuan(original_xia,optimized_xia) ;
% ����һ���������ŵı�����
P_max = original(original(:,1)==max(original(:,1)),:) ; 
P_min = original(original(:,1)==min(original(:,1)),:) ;
bili = norm((P_max-P_min),2) ; 
% Ȼ���������Ĳ�ֵ������Ū��ÿ����ƽ����MSE
%��������Ǹ�����ˣ�ʲô����ÿ����ƽ����MSE����ֱ���Ƿ���sigma^2�����ˣ�
N_shang = size(chazhi_shang) ;
N_xia = size(chazhi_xia) ; 
zhi = (sum((chazhi_shang(:,2)./bili).^2) + sum((chazhi_xia(:,2)./bili).^2))/(N_shang(1)+N_xia(1)) ;
fprintf('MXairfoil: tested airfoil gives a sigma^2:  ')
fprintf(num2str(zhi))

end

function zhi = chazhi_jisuan(original,optimized)
% ����ǳ������������
x_original = original(:,1) ; 
x_shangjie = max(x_original)-0.1 ; 
x_xiajie = min(x_original)+0.1 ;

%����������������ȡ�м��һ�Σ����Գ䵱���沽������롣
original2 = original((x_original<x_shangjie)&(x_original>x_xiajie),:) ; 
optimized2 = optimized((optimized(:,1)<x_shangjie)&(optimized(:,1)>x_xiajie),:) ; 
zhi = subtract_2disparate(original2,optimized2) ; 
% �������Ǹ�����ǰ�ģ������һ����ֵ���У�����һ�ײ�ֵŪ�����ġ�
end