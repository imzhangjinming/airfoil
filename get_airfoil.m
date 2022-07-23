function [uv_top,uv_bot] = get_airfoil(v,vp,houdu,lethk,tethk)
%这个是shishi_airfoil的写成函数的形式。这样舒服些。
%之前写到这里的时候已经又一次悟到要尽量写函数了，所以会舒服一些。
%然后终于开始生成二维的叶形了。

%  plot(v(:,1),v(:,2),'-*') ; %看一眼中弧线。
 
 ang = [vp(:,1),atan(vp(:,2)) ] ; 
 %讲道理，CDA这个里面不是这么玩的了，应该直接搞上去就行了的。2021年3月21日20:29:10
%  plot(ang(:,1),ang(:,2)) ; %看一眼角度分布。
 uv_top = yixing_top(v,houdu,ang,lethk,tethk) ; 
 %由于查询那个函数暂时不支持矩阵，所以还是循环一下吧。
 uv_bot = yixing_bot(v,houdu,ang,lethk,tethk) ; 
end 

 function zhi = yixing_top2(v,thk,ang,lethk,tethk)
 %这种写法好像要更专业一些。
%  v = v((v(:,1)<1) , :) ; %安排一手，让它不要延伸到不该去的地方。
 [hang , lie ] = size(v) ; 
 uv_top = zeros([hang lie+2]) ; 
 for i = 1:hang  
     uv_top(i,1) = v(i,1) - thk(i,2);
     uv_top(i,2) = v(i,2) + thk(i,2);
     uv_top(i,3) = (chaxun(thk , v(i,1))>lethk/2) ; %这个是额外加了来操作前后缘的
     uv_top(i,4) = (chaxun(thk , v(i,1))>tethk/2) ; 
%      end

 end 

 if(0)
     figure(1)
     hold on ;
     plot(uv_top(:,1),uv_top(:,2),'.') ; 
     grid on ;
     axis('equal') ; 
 end
 
 zhi = uv_top ;
 end
 
  function zhi = yixing_bot(v,thk,ang,lethk,tethk)
 %这种写法好像要更专业一些。
 %唯一需要修改的就是加号改成减号，减号改成加号。
%   v = v((v(:,1)<1) , :) ; %安排一手，让它不要延伸到不该去的地方。
 [hang ,lie ] = size(v) ; 
 uv_bot = zeros([hang lie+2]) ; 
 for i = 1:hang 
%      if(v(i,1)<1)
         %      uv_top(i,1) = v(i,1) -chaxun(thk , v(i,1))*sin(chaxun(ang,v(i,1)));
     %讲道理本来后面这个的点是11对应的，不查询多半也没什么所谓，但是专业点还是好的。 
     uv_bot(i,1) = v(i,1) + chaxun(thk , v(i,1))*sin(ang(i,2));
     uv_bot(i,2) = v(i,2) - chaxun(thk , v(i,1))*cos(ang(i,2)) ; 
     uv_bot(i,3) = (chaxun(thk , v(i,1))>lethk/2) ; %这个是额外加了来操作前后缘的
     uv_bot(i,4) = (chaxun(thk , v(i,1))>tethk/2) ; 
%      end
 end 

 if(0)
     figure(1)
     hold on ;
     plot(uv_bot(:,1),uv_bot(:,2),'.') ; 
     grid on ;
     axis('equal') ; 
 end
 
 zhi = uv_bot ;
 end
 
  function zhi = yixing_top(v,thk,ang,lethk,tethk)
 %这种写法好像要更专业一些。
%  v = v((v(:,1)<1) , :) ; %安排一手，让它不要延伸到不该去的地方。
 [hang , lie ] = size(v) ; 
 uv_top = zeros([hang lie+2]) ; 
 for i = 1:hang 
%      if(v(i,1)<1)
 %      uv_top(i,1) = v(i,1) -chaxun(thk , v(i,1))*sin(chaxun(ang,v(i,1)));
     %讲道理本来后面这个的点是11对应的，不查询多半也没什么所谓，但是专业点还是好的。 
     uv_top(i,1) = v(i,1) - chaxun(thk , v(i,1))*sin(ang(i,2));
     uv_top(i,2) = v(i,2) + chaxun(thk , v(i,1))*cos(ang(i,2)) ; 
     uv_top(i,3) = (chaxun(thk , v(i,1))>lethk/2) ; %这个是额外加了来操作前后缘的
     uv_top(i,4) = (chaxun(thk , v(i,1))>tethk/2) ; 
%      end

 end 

 if(0)
     figure(1)
     hold on ;
     plot(uv_top(:,1),uv_top(:,2),'.') ; 
     grid on ;
     axis('equal') ; 
 end
 
 zhi = uv_top ;
 end
 