function zhi = get_vpp2(wenjianming)
%这个属于是处理之前的遗留问题。2020年10月21日13:48:32
%通过读取出来的输入文件的那些角度啥的来求解出vpp。
% 2021年3月2日09:37:38，真的开始实用化地继续改了。

dianshu = 35 ; %因为从人家那里面读出来就是这么些点。
% Nmax=14 ;
%认为从0开始吧，还是尽量搞得专业点。
dt = 1/(dianshu-1) ; 
t=0:dt:1 ;  %参数方程的参数还是要安排起来的。
% changshu = -1*log(N)/log(Nmax) ; %0变化到-1
x=t ; 

% parameter = load('../input/test3/vpp/vpp_parameter.txt') ;
parameter = load(wenjianming) ;
[hang,lie] = size(parameter) ; 
changshu = parameter(1) ; 
if(lie ~= 8)
    fprintf('MXairfoil: invalid input parameter for get_vpp2');
end 
y=(1./(parameter(2)-sin(x*pi+pi*parameter(3)))-...
    1/(parameter(4)-sin(0*pi+pi*parameter(5))))*(parameter(6)+changshu)...
    +(- parameter(7) -changshu+changshu*parameter(8)*x + 0.2);
%2020年10月21日15:46:04，姑且就这样吧，拟合的东西大致差不多就行了嗷。
%2020年10月21日15:50:16，然而并不行嗷，弄出来的翼型和原来差的还挺远的。
%2020年10月21日16:46:39，讲道理，这里面的系数都是以后的可选的优化参数。
%2020年10月21日16:47:08，可能安排一些最小二乘拟合能够比较好地学习出这个分布，但是感觉意义不大了。
%沉迷在这种误差巨大且唯象的东西里面找规律讲道理是弱智行为，达到基础的能用可也。


huatu2([x',y']);

%上面姑且认为是初始化吧，整一点阳间的活。2020年10月21日16:30:09不对，不是整活了，要讲道理了。



zhi = [x',y'] ; 
fprintf('测试，get_vpp,第%d个截面\n',7)
% huatu2(zhi) ; 
end 