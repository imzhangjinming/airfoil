function zhi = subtract_2disparate(v1,v2)
% 两个范围一样但是size不一样的两个序列，让它们强行相减，减出一个序列来。比如两条中弧线。
% 然后结果应该是v2-v1，出来是v2的尺寸。
% 应该是点多的被插值讲道理，或者最好是两个都拟合起来互相插值。但是那样的话要你有毛用？

[hang2,lie2] = size(v2) ;
[hang1,lie1] = size(v1) ;

jieguo = v2  ;
jieguo(:,2) = 0 ; 

for i = 1:hang2
    for j = 1:hang1-1
        if((v2(i,1)>v1(j,1))&&(v2(i,1)<v1(j+1,1)))
            %说明是到了该插值的地方了。然后一阶的也就罢了
            bili = (v2(i,1) - v1(j,1))/(v1(j+1,1) - v1(j,1)) ; 
            v1_bijiao = (v1(j+1,:) - v1(j,:)) .* bili + v1(j,:) ;
            jieguo(i,2) = v2(i,2) - v1_bijiao(1,2) ;
            break ;
        elseif(v2(i,1)>v1(hang1,1))
            %说明是减到外面了,v2比v1长。
            bili = (v2(i,1) - v1(hang1-1,1))/(v1(hang1,1) - v1(hang1-1,1)) ; 
            v1_bijiao = (v1(hang1,:) - v1(hang1-1,:)) .* bili + v1(hang1-1,:) ;
            jieguo(i,2) = v2(i,2) - v1_bijiao(1,2) ;
            break;
        elseif(v2(i,1)<v1(1,1))
            %说明是减到外面了，前面出头了。
            bili = (v2(i,1) - v1(1,1))/(v1(2,1) - v1(1,1)) ; 
            v1_bijiao = (v1(2,:) - v1(1,:)) .* bili + v1(1,:) ;
            jieguo(i,2) = v2(i,2) - v1_bijiao(1,2) ;
        end
    end
end
zhi = jieguo ;
end