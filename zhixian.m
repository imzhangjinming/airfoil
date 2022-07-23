classdef zhixian<handle
    properties
        a=1;
        b=1;
        c=-1;
        xielv = 1;
        jieju = 1;
        kind = 'line' ; 
        % ax+by+c=0，二维的直线。
    end
    methods
        function obj = zhixian(qidian,chuizhi,flag)
            if nargin==3
                if strcmp(flag,'PtoLine')
                    %这个从一个点到一条线，然后求垂线。chuizhi是个线了现在
                    obj.a = -chuizhi.b;
                    obj.b = chuizhi.a;
                    obj.c = [obj.a,obj.b]*qidian'*(-1) ;  
                else
                    %这个就是最简单的两个点来求出来的
                    if(norm(qidian,2)<eps)
                        obj.c = 0 ; 
                        obj.b = 1 ; 
                        obj.a = -1*chuizhi(2)*obj.b/chuizhi(1) ; 
                    elseif(norm(chuizhi,2)<eps)
                        obj.c = 0 ; 
                        obj.b = 1 ; 
                        obj.a = -1*qidian(2)*obj.b/qidian(1) ; 
                    else
                        xishu = [qidian  ; chuizhi] ; 
                        youbian = [-1*obj.c ; -1*obj.c ] ; 
                        jieguo = mldivide(xishu,youbian) ; 
                        obj.a = jieguo(1) ; 
                        obj.b = jieguo(2) ; 
                    end
                end 
                 
            elseif nargin==2
                %qidian是直线上的一点，chuizhi是用来构成垂线的点。
                obj.xielv = (chuizhi(1)-qidian(1))/(qidian(2)-chuizhi(2)) ; 
                %这个是待求直线的斜率
                %然后一个简单的线性方程组解出a和b
                if(norm(qidian,2)<eps)
    %                 fprintf('MXairfoil: cross the (0,0), there must be something wrong.\n');
                    obj.c = 0 ; 
                    obj.b = 1 ; 
                    obj.a = -1*obj.xielv*obj.b ; 
                else 
                    xishu = [qidian(1),qidian(2)  ; 1,obj.xielv] ; 
                    youbian = [-1*obj.c ; 0 ] ; 
                    jieguo = mldivide(xishu,youbian) ; 
                    obj.a = jieguo(1) ; 
                    obj.b = jieguo(2) ; 
                end 
            end
             obj.jieju = -obj.c/obj.b;
             obj.xielv = -obj.a/obj.b ; 
%             fprintf('MXairfoil: finish initalize a line\n');
        end
        
        
        function uv = visual(obj,x_xiao ,x_da)
            if nargin==3
                
            else
                x_xiao =[-1,-1] ; 
                x_da = [1,1];
            end
            N = 30 ; 
            dx = (x_da -x_xiao)/N ; 
            obj.jieju = -obj.c/obj.b;
            obj.xielv = -obj.a/obj.b ; 
            u = x_xiao:dx:x_da ; 
            v = obj.xielv .* u + obj.jieju ; 
            uv = [u',v'] ; 
        end
        
        function jiaodian = get_jiaodian(obj,obj2)
            %这个是用来求两个直线的交点的，返回交点的值。
            if(strcmp(obj.kind,'line')&&strcmp(obj.kind,'line'))
                xishu =  [obj.a, obj.b ;...
                      obj2.a,obj2.b] ; 
                youbian = [-1*obj.c ; -1*obj2.c ] ; 
                jieguo = mldivide(xishu,youbian) ; 
                jiaodian = jieguo' ; 
            end
        end
        
        function jvli = get_jvli(obj,dian)
            % 这个是要求出一个点到现在这条直线的距离。直线已经是ax+by+c了
            jvli = abs((obj.a*dian(1) + obj.b*dian(2)+obj.c)/(sqrt(obj.a^2 + obj.b^2)));
        end
    
        function zhi = get_line_2point(obj,P1,P2)
            %这个是最简单的两点确定一条直线。
            xishu = [P1(1),P1(2) ; P2(1),P2(2)] ; 
            youbian = [1,1] ; 
            try
                jieguo = mldivide(xishu,youbian) ; 
                obj.a = jieguo(1) ; 
                obj.b = jieguo(2) ; 
                obj.c = -1;
            catch
                if (norm(P1,2)<eps )
                    obj.c = 0 ; 
                    obj.a = 1 ; 
                    obj.b = -obj.a * P2(1) / P2(2) ; 
                elseif norm(P2,2)<eps
                    obj.c = 0 ; 
                    obj.a = 1 ; 
                    obj.b = -obj.a * P1(1) / P1(2) ; 
                end 
            end
            obj.jieju = -obj.c/obj.b;
            obj.xielv = -obj.a/obj.b ; 
                
        end 
    end
end

% shishi = zhixian([0,0],[1,1]);shishi2 = zhixian([0,1],[1,0]);jiaodian = shishi.get_jiaodian(shishi2);
% huatu2(shishi.visual(-1,1));huatu2(shishi2.visual(-1,1));huatu2(jiaodian);