function zhi = chachong2(uv)
% 这个的说法在于把一个系列里面的重复的点去掉。
% 这个是改进版的查重。
[hang , lie ] = size(uv) ; 

    flag = sum(abs((uv(2:hang,:) - uv(1:hang-1 ,:))),2)>0.0001 ; 
    flag = [true;flag] ; 
    zhi = uv(flag , :) ; 
end