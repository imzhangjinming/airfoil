function [circleRadius,circleCenterCoordinates,tangencyPointsS1,tangencyPointsS2,KZRetc] = duqu_fuke(wenjianming)
%����ǴӲ�ͬ���ļ��������ȡ����һϵ������ֵֹĶ�����ԭʼ�ģ���ʱ����ӹ���
% nSurface = 1 ; 
wenjianjia =wenjianming;
circleRadius = load([wenjianjia , '\circleRadius.txt']);
circleCenterCoordinates = load([wenjianjia , '\circleCenterCoordinates.txt']);
tangencyPointsS1 = load([wenjianjia , '\tangencyPointsS1.txt']);
tangencyPointsS2 = load([wenjianjia , '\tangencyPointsS2.txt']);
KZRetc = load([wenjianjia , '\KZRetc.txt']);
end 