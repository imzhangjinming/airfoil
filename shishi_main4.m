function zhi = shishi_main4(lujing)
%���£���һ��רҵһ��ġ����Ǹ�CDAҶ�εĸ��̡�
% clear ; clc ; 
% use this to test: 
% system('shishi_main4.exe C:\Users\y\Desktop\�Զ����ɼ��ζ�άCDA')
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
% �����һ���汾��Ӧ��Ҫ��һ�εģ���ֹ������
% get_igg(outputfolder,zhi);
get_igg(outputfolder,zhi);

% wenjianming = '../input/test3';
% [chi_in,chi_out,xi,vpp,vp,bili,...
% lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
% beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi] = dataInput1(wenjianming) ;
end
