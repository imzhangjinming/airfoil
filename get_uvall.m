function zhi = get_uvall(uv_bot3,uv_top3)
%������������������ı�Ե��Ū��һ�������ģ�Ҫ��ֹ�����ظ�����Щ��
uv_bot = flipud(chachong(uv_bot3)) ;
uv_top = chachong(uv_top3) ; 
[hang,~] = size(uv_bot) ; 
jiexian = uv_bot(hang ,:) ; 
uv_top = uv_top(uv_top(:,1)<jiexian(:,1),:) ; 
%��������һ���жϵĻ���Ե����������е��ظ����Ͳ�̫�С�
zhi = [uv_bot ; uv_top] ; 
end