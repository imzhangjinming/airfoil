function zhi = weifen2(ZR)
%���·�װһ��΢���ˣ�ͻ��һ�����þ��У����߹�����һ�׵ľ��ȿ�Ҳ��
%Ҫ���ྫ�ȵĻ��ȵ��������ʱ������д��Ҳ��
drdz1 = ZR(2,:)-ZR(1,:) ;
drdz1 = drdz1(2)/drdz1(1) ; 
drdzEnd = ZR(end,:)-ZR(end-1,:) ;
drdzEnd = drdzEnd(2)/drdzEnd(1) ; 
drdz = [drdz1 ; ...
    weifen(ZR(:,2),ZR(:,1)) ; ...
    drdzEnd]  ; 

zhi = drdz ; 
end 