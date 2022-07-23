function zhi = weifen_uv(uv_camber)
%加工一个直接用于点列的、比较好用的微分。
    v_camberp = weifen(uv_camber(:,2) , uv_camber(:,1)) ; 
    [hang,~] = size(v_camberp) ;
    v_camberp = [2*v_camberp(1)-v_camberp(2);...
        v_camberp ;...
        2*v_camberp(hang)-v_camberp(hang-1)];%手动改改第一个和最后一个。
    zhi = [uv_camber(:,1) , v_camberp] ;
end