function zhi = weifen_uv(uv_camber)
%�ӹ�һ��ֱ�����ڵ��еġ��ȽϺ��õ�΢�֡�
    v_camberp = weifen(uv_camber(:,2) , uv_camber(:,1)) ; 
    [hang,~] = size(v_camberp) ;
    v_camberp = [2*v_camberp(1)-v_camberp(2);...
        v_camberp ;...
        2*v_camberp(hang)-v_camberp(hang-1)];%�ֶ��ĸĵ�һ�������һ����
    zhi = [uv_camber(:,1) , v_camberp] ;
end