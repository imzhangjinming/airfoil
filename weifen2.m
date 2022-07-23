function zhi = weifen2(ZR)
%重新封装一下微分了，突出一个能用就行，两边姑且是一阶的精度可也。
%要更多精度的话等到有心情的时候再来写可也。
drdz1 = ZR(2,:)-ZR(1,:) ;
drdz1 = drdz1(2)/drdz1(1) ; 
drdzEnd = ZR(end,:)-ZR(end-1,:) ;
drdzEnd = drdzEnd(2)/drdzEnd(1) ; 
drdz = [drdz1 ; ...
    weifen(ZR(:,2),ZR(:,1)) ; ...
    drdzEnd]  ; 

zhi = drdz ; 
end 