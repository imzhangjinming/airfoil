function [uv_top,uv_bot] = get_airfoil(v,vp,houdu,lethk,tethk)
%�����shishi_airfoil��д�ɺ�������ʽ���������Щ��
%֮ǰд�������ʱ���Ѿ���һ����Ҫ����д�����ˣ����Ի����һЩ��
%Ȼ�����ڿ�ʼ���ɶ�ά��Ҷ���ˡ�

%  plot(v(:,1),v(:,2),'-*') ; %��һ���л��ߡ�
 
 ang = [vp(:,1),atan(vp(:,2)) ] ; 
 %������CDA������治����ô����ˣ�Ӧ��ֱ�Ӹ���ȥ�����˵ġ�2021��3��21��20:29:10
%  plot(ang(:,1),ang(:,2)) ; %��һ�۽Ƕȷֲ���
 uv_top = yixing_top(v,houdu,ang,lethk,tethk) ; 
 %���ڲ�ѯ�Ǹ�������ʱ��֧�־������Ի���ѭ��һ�°ɡ�
 uv_bot = yixing_bot(v,houdu,ang,lethk,tethk) ; 
end 

 function zhi = yixing_top2(v,thk,ang,lethk,tethk)
 %����д������Ҫ��רҵһЩ��
%  v = v((v(:,1)<1) , :) ; %����һ�֣�������Ҫ���쵽����ȥ�ĵط���
 [hang , lie ] = size(v) ; 
 uv_top = zeros([hang lie+2]) ; 
 for i = 1:hang  
     uv_top(i,1) = v(i,1) - thk(i,2);
     uv_top(i,2) = v(i,2) + thk(i,2);
     uv_top(i,3) = (chaxun(thk , v(i,1))>lethk/2) ; %����Ƕ������������ǰ��Ե��
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
 %����д������Ҫ��רҵһЩ��
 %Ψһ��Ҫ�޸ĵľ��ǼӺŸĳɼ��ţ����ŸĳɼӺš�
%   v = v((v(:,1)<1) , :) ; %����һ�֣�������Ҫ���쵽����ȥ�ĵط���
 [hang ,lie ] = size(v) ; 
 uv_bot = zeros([hang lie+2]) ; 
 for i = 1:hang 
%      if(v(i,1)<1)
         %      uv_top(i,1) = v(i,1) -chaxun(thk , v(i,1))*sin(chaxun(ang,v(i,1)));
     %����������������ĵ���11��Ӧ�ģ�����ѯ���Ҳûʲô��ν������רҵ�㻹�Ǻõġ� 
     uv_bot(i,1) = v(i,1) + chaxun(thk , v(i,1))*sin(ang(i,2));
     uv_bot(i,2) = v(i,2) - chaxun(thk , v(i,1))*cos(ang(i,2)) ; 
     uv_bot(i,3) = (chaxun(thk , v(i,1))>lethk/2) ; %����Ƕ������������ǰ��Ե��
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
 %����д������Ҫ��רҵһЩ��
%  v = v((v(:,1)<1) , :) ; %����һ�֣�������Ҫ���쵽����ȥ�ĵط���
 [hang , lie ] = size(v) ; 
 uv_top = zeros([hang lie+2]) ; 
 for i = 1:hang 
%      if(v(i,1)<1)
 %      uv_top(i,1) = v(i,1) -chaxun(thk , v(i,1))*sin(chaxun(ang,v(i,1)));
     %����������������ĵ���11��Ӧ�ģ�����ѯ���Ҳûʲô��ν������רҵ�㻹�Ǻõġ� 
     uv_top(i,1) = v(i,1) - chaxun(thk , v(i,1))*sin(ang(i,2));
     uv_top(i,2) = v(i,2) + chaxun(thk , v(i,1))*cos(ang(i,2)) ; 
     uv_top(i,3) = (chaxun(thk , v(i,1))>lethk/2) ; %����Ƕ������������ǰ��Ե��
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
 