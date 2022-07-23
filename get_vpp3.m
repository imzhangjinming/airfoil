function zhi = get_vpp3(wenjianming)
% 搞一个阳间的读取用于CDA算例。
%通过读取出来的输入文件的那些角度啥的来求解出vpp。
% 2021年3月2日09:37:38，真的开始实用化地继续改了。

x = 0:0.025:1 ; 
x = x' ; 
parameter = load(wenjianming) ;
[hang,lie] = size(parameter) ; 
if(lie ~= 4)
    fprintf('MXairfoil: invalid input parameter for get_vpp3');
end 

y = polyval(parameter,x) ; 
vpp = [x,y] ; 
% huatu2(vpp);
%上面姑且认为是初始化吧，整一点阳间的活。2020年10月21日16:30:09不对，不是整活了，要讲道理了。
zhi = vpp;
fprintf('测试，get_vpp3,CDA \n') ;
% huatu2(zhi) ; 
end 