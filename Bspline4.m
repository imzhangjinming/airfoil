function zhi = Bspline4(P,t)
% Ūһ�������������ߵġ���΢רҵһ�㡣��ΪҪ����õ��������
ns = 4 ; 
[hang lie] = size(P) ; 
dianshu = size(t) ; 
B = cell(5,1) ; 
B{1} = (1-t).^4/24 ; 
B{2} = (-4*t.^4 + 12*t.^3 - 6*t.^2 - 12*t+11)/24 ; 
B{3} = (6*t.^4 - 12*t.^3 - 6*t.^2 + 12*t + 11)/24 ;
B{4} = (-4*t.^4 + 4*t.^3 + 6*t.^2 + 4*t + 1)/24 ;
B{5} = t.^4/24 ; 
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