function zhi = jifen(uv)
% Ūһ�����ֵģ������Ե�רҵһ�㡣������ʹ������ˣ��Ӽ���ʱ��������˵��
% һ��أ��������v��ʵ�������vpp֮��ġ�
[hang lie] = size(uv) ; 
u = uv(:,1) ; %������һЩ��Դ���������һЩ�����ⲻ��ġ����ο��������Ҳ����ô�м����� 
v = uv(:,2) ;
zhi = zeros(size(uv)) ; 
zhi(:,1) = u ; 
% zhongjie = 0 ; 
zhi(1,2) = 0 ; %����ǳ�ֵ�ˡ�
for i=2:hang     
%     zhi(i,2) = zhi(i-1,2) + (u(i) - u(i-1))*(v(i)) ; 
    zhi(i,2) = zhi(i-1,2) + (u(i) - u(i-1))*(v(i) + v(i-1))/2 ; 
end 

% figure()
% hold on 
% plot(zhi(:,1),zhi(:,2),'-r') ; 
% % axis('equal')
% hold off 
end