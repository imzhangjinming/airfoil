function zhi = shishi_main4(lujing)
%重新，搞一个专业一点的、对那个CDA叶形的复刻。
% clear ; clc ; 
% use this to test: 
% system('shishi_main4.exe C:\Users\y\Desktop\自动生成几何二维CDA')
% get_vm(); get_houdu_m() ; 
if nargin==0
    lujing = '..' ; 
end
input_location = [lujing '\input\CDA1'] ; 
[zhi,index] = fuke_yixing2(input_location) ; 

% huatu2(zhi) ; 

% outputfolder = 'C:\Users\y\Desktop\EnglishMulu\testCDA1_debug';
% outputfolder_backup = '..\output\CDA1' ; 
outputfolder = [lujing '\output\CDA1'] ; 
% 这个存一个版本就应该要改一次的，防止出问题
% get_igg(outputfolder,zhi);
get_igg(outputfolder,zhi);

% wenjianming = '../input/test3';
% [chi_in,chi_out,xi,vpp,vp,bili,...
% lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
% beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi] = dataInput1(wenjianming) ;
end
