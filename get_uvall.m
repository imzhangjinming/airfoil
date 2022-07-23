function zhi = get_uvall(uv_bot3,uv_top3)
%这个属于用上下两个的边缘来弄出一个完整的，要防止各种重复啊那些。
uv_bot = flipud(chachong(uv_bot3)) ;
uv_top = chachong(uv_top3) ; 
[hang,~] = size(uv_bot) ; 
jiexian = uv_bot(hang ,:) ; 
uv_top = uv_top(uv_top(:,1)<jiexian(:,1),:) ; 
%不安排这一手判断的话后缘上面那里会有点重复，就不太行。
zhi = [uv_bot ; uv_top] ; 
end