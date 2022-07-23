function [uv_top3,uv_bot3] = get_qianhouyuan(uv_top,uv_bot,lethk ,tethk,chi_in,chi_out)
%这个是把shishi_qianhouyuan改成函数形式方便用一些。
% % %前后缘还是要处理一下的，不应该就直接放弃治疗了。哪怕简化方法也好，说法要有的。
% % %弄好以后就全部搬到函数里面去了。就比较舒服了嗷。
% [uv_top2 , uv_bot2] = get_qianyuan(uv_top,uv_top(:,3) ,uv_bot,uv_bot(:,3),lethk ,chi_in ,...
%     12,0.01,0.4,0.4,0.8,1.6) ; %这个是样条的
% 2021年3月22日20:04:25，注意到了，样条的好像还是不是很对，再操作一下。
% [uv_top2 , uv_bot2] = get_qianyuan2(uv_top,uv_top(:,3) ,uv_bot,uv_bot(:,3),...
%     lethk ,chi_in ,0,0,0,0,0,0) ; %这个是圆前缘的。
[uv_top2 , uv_bot2] = get_qianyuan22(uv_top,uv_top(:,3) ,uv_bot,uv_bot(:,3),...
    lethk ,chi_in ,0,0,0,0,0,0) ; %这个是圆前缘的。改进了一下，还了当初偷懒的欠债。
% [uv_top2 , uv_bot2] = get_qianyuan3(uv_top,uv_top(:,3) ,uv_bot,uv_bot(:,3),lethk ,chi_in ,0) ;
% % 2020年6月20日17:08:54这个是新的样条的，初步测试是没毛病的。后续：用起来还是不行
% [uv_top22 , uv_bot22] = get_qianyuan4(uv_top,uv_top(:,3) ,uv_bot,uv_bot(:,3),lethk ,chi_in ,0) ;
% 2020年6月20日19:43:21这个是新的两段的样条的，可以控制前缘的位置了。
% % 这个也是初步测试了一下是能用的了。所以之前为什么要花时间精力去纠结他给出的那个不明觉厉的？
% [uv_top2 , uv_bot2] = get_qianyuan5(uv_top,uv_bot,lethk,chi_in);
% 这个也并不行。虽然理论上算是大致知道了为什么不行，但是仍然没有解决为什么不行。

% mydebug(uv_top2) ; 
% plot(uv_top2(:,1) , uv_top2(: ,2)) ; 
% hold on
% plot(uv_bot2(:,1) , uv_bot2(:,2)) ; 
% axis('equal') ; 

uv_top2(:,1) = 1 - uv_top2(:,1) ; 
uv_bot2(:,1) = 1 - uv_bot2(:,1) ; 
% 对称过去，以复用前面的各种处理。是时候把前面的那一堆封装一下了。

% plot(uv_top2(:,1) , uv_top2(: ,2)) ; 
% hold on
% plot(uv_bot2(:,1) , uv_bot2(:,2)) ; 
% axis('equal') ; 

% [uv_top3 , uv_bot3] = get_qianyuan(flipud(uv_top2),flipud(uv_top(:,4)),...
%     flipud(uv_bot2),flipud(uv_bot(:,4)),tethk ,-chi_out ,...
%     25,0.004,0.3,0,0.8,0.3) ; 
% [uv_top3 , uv_bot3] = get_qianyuan2(flipud(uv_top2),flipud(uv_top(:,4)),...
%     flipud(uv_bot2),flipud(uv_bot(:,4)),tethk ,-chi_out ,...
%     0,0,0,0,0,0) ; 
% 这里面的一串串翻转主要是为了兼容之前的查询厚度那一系列的东西。

[uv_top3 , uv_bot3] = get_qianyuan22(flipud(uv_top2),flipud(uv_top(:,4)),...
    flipud(uv_bot2),flipud(uv_bot(:,4)),tethk ,-chi_out ,...
    0,0,0,0,0,0) ; 

%在这里尝试布署样条曲线版本的后缘
% [uv_top3 , uv_bot3] = get_qianyuan5(flipud(uv_top2),flipud(uv_bot2),tethk,-chi_out);


% 好，算完了然后再翻转回去。
uv_top3(:,1) = 1 - uv_top3(:,1) ; 
uv_bot3(:,1) = 1 - uv_bot3(:,1) ; 

% plot(uv_top3(:,1) , uv_top3(: ,2)) ; 
% hold on
% plot(uv_bot3(:,1) , uv_bot3(:,2)) ; 
% axis('equal') ; 

end 