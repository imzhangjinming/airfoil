function zhi = chachong(uv)
% 这个的说法在于把一个系列里面的重复的点去掉。
% 这个在很多地方都用过，因此不要乱改。
% 该改的还是要改，反正有备份的，要加个循环弄到可以查出连续的重复的点。
hang2 = 0 ; 
[hang , lie ] = size(uv) ; 
uv2 = [] ; 

while(hang2 ~= hang )
    [hang , lie ] = size(uv) ; 
    uv2 = uv(1,:) ; 
    for i = 2:hang
        if(sum(abs((uv(i,:) - uv(i-1 ,:))))<0.001)
%             uv(i,:) = [] ; %手动把重复的点删了嗷。
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


