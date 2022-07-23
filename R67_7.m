% this is for R67_7，以前的没整理或者是找不着了。
clear;clc;
% load('C:\Users\y\Desktop\自动生成几何二维CDA\airfoil-compare\R67_7.mat');
load('E:\常用-现役\比四上还更往后了烦的一笔\从桌面整理过来的\自动生成几何二维CDA\airfoil-compare\R67_7.mat');
input_cell = {R67_7_original,R67_7_calculated} ;
label_cell = {'Original','Regenerate'} ; 
huatu2_compare_mul(input_cell,label_cell)
% 标题记得要改一下。
% 坐标轴范围可能需要改改。