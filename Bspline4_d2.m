function zhi = Bspline4_d2(P,t)
% Ūһ�������������ߵĶ���΢�ֵġ���΢רҵһ�㡣��ΪҪ����õ��������
ns = 4 ; 
[hang lie] = size(P) ; 
dianshu = size(t) ; 
B = cell(5,1) ; 
B{1} = 12*(1-t).^2/24 ; 
B{2} = (-48*t.^2 + 72*t-12)/24 ; 
B{3} = (72*t.^2 - 72*t - 12)/24 ;
B{4} = (-48*t.^2 + 24*t + 12)/24 ;
B{5} = 12*t.^2/24 ; 
%�������������tӦ�ò���ʵ�ʵ������ֻ��ĳ�ֲ�����ʵ�ʵ��������궼Ӧ�����ڷ���ֵ����ġ�
zhi = zeros(dianshu(1),lie);
for n = 1:ns+1
    zhi = zhi + [P(n,1)*B{n}' P(n,2)*B{n}'] ; 
end 

%���һ�¿��׳̶���Ρ�
% figure()
% hold on 
% plot(P(:,1),P(:,2),'o') ;
% hold on 
% plot(zhi(:,1),zhi(:,2),'-r') ; 
% axis('equal')
% hold off 
end