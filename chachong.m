function zhi = chachong(uv)
% �����˵�����ڰ�һ��ϵ��������ظ��ĵ�ȥ����
% ����ںܶ�ط����ù�����˲�Ҫ�Ҹġ�
% �øĵĻ���Ҫ�ģ������б��ݵģ�Ҫ�Ӹ�ѭ��Ū�����Բ���������ظ��ĵ㡣
hang2 = 0 ; 
[hang , lie ] = size(uv) ; 
uv2 = [] ; 

while(hang2 ~= hang )
    [hang , lie ] = size(uv) ; 
    uv2 = uv(1,:) ; 
    for i = 2:hang
        if(sum(abs((uv(i,:) - uv(i-1 ,:))))<0.001)
%             uv(i,:) = [] ; %�ֶ����ظ��ĵ�ɾ��໡�
%             [hang , lie ] = size(uv) ; 
        else
            uv2 = [uv2 ; uv(i,:)]  ; 
        end
    end
    uv = uv2 ; 
    uv2 = [] ; 
    [hang2 , ~] = size(uv) ; 
end 

zhi = uv ; 
end


