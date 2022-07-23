function zhi = shishi_main4_compare(lujing)
    % arifoi_CDA
    if nargin==0
        lujing = '..' ; 
    end
    zhi = arifoi_CDA(lujing,2) ; % 2D ��ʱ�����2D�Ľ����4D��ʱ�����4D�Ľ��
end
function zhi = arifoi_CDA(lujing,flag) 
    %��һ���ķ�װ��������������
    %���£���һ��רҵһ��ġ����Ǹ�CDAҶ�εĸ��̡�
    % clear ; clc ; 
    % use this to test: 
    % system('shishi_main4.exe C:\Users\y\Desktop\�Զ����ɼ��ζ�άCDA')
    if nargin==0
        lujing = '..' ; 
    end
    input_location = [lujing '\input\CDA1'] ; 
    [zhi,index] = fuke_yixing2(input_location) ; 
    % state_debug = [ 0.3564,-0.350176,0.46152,5.828] ;
    
%     % 2D ��ʱ�����2D�Ľ��
%     optimization2D= [ 0.25000393 -0.22044585  0.4435      6.231357  ] ; 
%     constrained_optimization2D = [ 0.2537525  -0.28772384  0.4435 6.231357  ];
%     [zhi_compare_optimization, index] = fuke_yixing2_compare(input_location,optimization2D) ; 
%     [zhi_constrained_optimization, index] = fuke_yixing2_compare(input_location,constrained_optimization2D) ;
%     
    % 4D��ʱ�����4D�Ľ��
    optimization4D =[ 0.250164 , -0.222096  , 0.3501624 , 6.20336  ];
    constrained_optimization4D = [0.26300387,-0.33962763,0.35037102,5.54833229];
    [zhi_compare_optimization, index] = fuke_yixing2_compare(input_location,optimization4D) ; 
    [zhi_constrained_optimization, index] = fuke_yixing2_compare(input_location,constrained_optimization4D) ; 

    % huatu2(zhi_compare) ; 

    % �����������ġ�ƽ�ƵĲ��������Ե����ʸĵĲ���ܶࣿ
    zhongxin_original = mean(zhi) ;
    zhongxin_compare = mean(zhi_compare_optimization) ; 
    jvli = zhongxin_original - zhongxin_compare ;
    zhi_compare_optimization = zhi_compare_optimization + jvli ;

    zhongxin_compare = mean(zhi_constrained_optimization) ; 
    jvli = zhongxin_original - zhongxin_compare ;
    zhi_constrained_optimization = zhi_constrained_optimization + jvli ;

    % huatu2_compare(zhi,zhi_compare);
    % input_cell = {zhi,zhi_compare_optimization} ;
    % label_cell = {'Original','Unconstrained'} ; 
    % huatu2_compare_mul(input_cell,label_cell)

    if flag ==1
        % huatu2_compare(zhi,zhi_compare);
        input_cell = {zhi,zhi_compare_optimization} ;
        label_cell = {'Original','Unconstrained'} ; 
        huatu2_compare_mul(input_cell,label_cell)
    elseif flag ==2
        input_cell = {zhi,zhi_compare_optimization,zhi_constrained_optimization} ;
        label_cell = {'Original','Unconstrained','Constrained'} ; 
        huatu2_compare_mul(input_cell,label_cell)
    end 
        

end 
