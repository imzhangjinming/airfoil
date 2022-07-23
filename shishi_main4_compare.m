function zhi = shishi_main4_compare(lujing)
    % arifoi_CDA
    if nargin==0
        lujing = '..' ; 
    end
    zhi = arifoi_CDA(lujing,2) ; % 2D 的时候就用2D的结果，4D的时候就用4D的结果
end
function zhi = arifoi_CDA(lujing,flag) 
    %进一步的封装，方便冷启动。
    %重新，搞一个专业一点的、对那个CDA叶形的复刻。
    % clear ; clc ; 
    % use this to test: 
    % system('shishi_main4.exe C:\Users\y\Desktop\自动生成几何二维CDA')
    if nargin==0
        lujing = '..' ; 
    end
    input_location = [lujing '\input\CDA1'] ; 
    [zhi,index] = fuke_yixing2(input_location) ; 
    % state_debug = [ 0.3564,-0.350176,0.46152,5.828] ;
    
%     % 2D 的时候就用2D的结果
%     optimization2D= [ 0.25000393 -0.22044585  0.4435      6.231357  ] ; 
%     constrained_optimization2D = [ 0.2537525  -0.28772384  0.4435 6.231357  ];
%     [zhi_compare_optimization, index] = fuke_yixing2_compare(input_location,optimization2D) ; 
%     [zhi_constrained_optimization, index] = fuke_yixing2_compare(input_location,constrained_optimization2D) ;
%     
    % 4D的时候就用4D的结果
    optimization4D =[ 0.250164 , -0.222096  , 0.3501624 , 6.20336  ];
    constrained_optimization4D = [0.26300387,-0.33962763,0.35037102,5.54833229];
    [zhi_compare_optimization, index] = fuke_yixing2_compare(input_location,optimization4D) ; 
    [zhi_constrained_optimization, index] = fuke_yixing2_compare(input_location,constrained_optimization4D) ; 

    % huatu2(zhi_compare) ; 

    % 整个类似重心、平移的操作，来显得劳资改的不算很多？
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
