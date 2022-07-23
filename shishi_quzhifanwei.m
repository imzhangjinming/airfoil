function zhi = shishi_quzhifanwei()
% this is to test quzhifanewi 
constraind_optimization_4D = [0.38464018,-0.29709295,0.28179729,3.71777542] ;
% zhi = bijiao(constraind_optimization_4D) ; 
% real_obs_space_h = [0.4,-0.1,0.8,8] ; 
% real_obs_space_l = [0.3,-0.5,0.2,3] ; 
% real_obs_space_h = [0.4,-0.22,0.55,8] ; 
% real_obs_space_l = [0.3,-0.38,0.35,5] ; 
real_obs_space_h = [0.35,-0.22,0.55,8] ; 
real_obs_space_l = [0.25,-0.38,0.35,5] ; 
state_original = [0.302447,-0.303741,0.4435,6.231357];

% get the index 
index = [0,0,0,0] ;
index_all = [0,0,0,0] ; 
for i =1:2^4-1
    i2 = i ; 
    for j=1:4
        index(5-j) = mod(i2,2) ; 
        i2 = floor(i2/2);
    end
    index_all = [index_all ; index] ; 
end

% then uses the index to calculate every corner.
for i = 1:2^4-1
    %assemble a package.
    state_input = real_obs_space_h .* index_all(i,:) + ...
       real_obs_space_l.*(ones(1,4)-index_all(i,:)) ; 
    name = ['..\airfoil-compare\' num2str(i) '.png'];
    bijiao(state_input,name);
end
zhi = index_all ; 
end 

function zhi = bijiao(state,name)
% this is copy from shishi_main4_compare.m
lujing = '..' ; 
input_location = [lujing '\input\CDA1'] ; 
[zhi,index] = fuke_yixing2(input_location) ; 
[zhi_compare, index] = fuke_yixing2_compare(input_location,state) ; 

% huatu2(zhi) ; 

% 整个类似重心、平移的操作，来显得劳资改的不算很多？
zhongxin_original = mean(zhi) ;
zhongxin_compare = mean(zhi_compare) ; 
jvli = zhongxin_original - zhongxin_compare ;
zhi_compare = zhi_compare + jvli ;

% huatu and save the figure.
huatu2_compare(zhi,zhi_compare,name);

end 