function [circleRadius,circleCenterCoordinates,tangencyPointsS1,tangencyPointsS2,KZRetc] = duqu_fuke(wenjianming)
%这个是从不同的文件夹里面读取出那一系列奇奇怪怪的东西。原始的，暂时不深加工。
% nSurface = 1 ; 
wenjianjia =wenjianming;
circleRadius = load([wenjianjia , '\circleRadius.txt']);
circleCenterCoordinates = load([wenjianjia , '\circleCenterCoordinates.txt']);
tangencyPointsS1 = load([wenjianjia , '\tangencyPointsS1.txt']);
tangencyPointsS2 = load([wenjianjia , '\tangencyPointsS2.txt']);
KZRetc = load([wenjianjia , '\KZRetc.txt']);
end 