function zhi = chachong2(uv)
% �����˵�����ڰ�һ��ϵ��������ظ��ĵ�ȥ����
% ����ǸĽ���Ĳ��ء�
[hang , lie ] = size(uv) ; 

    flag = sum(abs((uv(2:hang,:) - uv(1:hang-1 ,:))),2)>0.0001 ; 
    flag = [true;flag] ; 
    zhi = uv(flag , :) ; 
end