function zhi = Bspline3(P,t)
% Ūһ�������������ߵġ���΢רҵһ�㡣��ΪҪ����õ��������
ns = 3 ; 
[hang lie] = size(P) ; 
dianshu = size(t) ; 
B = cell(4,1) ; 
B{1} = (1-t).^3/6 ; 
B{2} = (3*t.^3 - 6*t.^2 + 4)/6 ; 
B{3} = (-3*t.^3 + 3*t.^2 + 3*t + 1)/6 ;
B{4} = t.^3/6 ;
% B{5} = t.^4/24 ; 
%�������������tӦ�ò���ʵ�ʵ������ֻ��ĳ�ֲ�����ʵ�ʵ��������궼Ӧ�����ڷ���ֵ����ġ�
zhi = zeros(dianshu(1),lie);
for(n = 1:ns+1)
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