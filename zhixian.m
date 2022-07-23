classdef zhixian<handle
    properties
        a=1;
        b=1;
        c=-1;
        xielv = 1;
        jieju = 1;
        kind = 'line' ; 
        % ax+by+c=0����ά��ֱ�ߡ�
    end
    methods
        function obj = zhixian(qidian,chuizhi,flag)
            if nargin==3
                if strcmp(flag,'PtoLine')
                    %�����һ���㵽һ���ߣ�Ȼ�����ߡ�chuizhi�Ǹ���������
                    obj.a = -chuizhi.b;
                    obj.b = chuizhi.a;
                    obj.c = [obj.a,obj.b]*qidian'*(-1) ;  
                else
                    %���������򵥵����������������
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
                %qidian��ֱ���ϵ�һ�㣬chuizhi���������ɴ��ߵĵ㡣
                obj.xielv = (chuizhi(1)-qidian(1))/(qidian(2)-chuizhi(2)) ; 
                %����Ǵ���ֱ�ߵ�б��
                %Ȼ��һ���򵥵����Է�������a��b
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
            %���������������ֱ�ߵĽ���ģ����ؽ����ֵ��
            if(strcmp(obj.kind,'line')&&strcmp(obj.kind,'line'))
                xishu =  [obj.a, obj.b ;...
                      obj2.a,obj2.b] ; 
                youbian = [-1*obj.c ; -1*obj2.c ] ; 
                jieguo = mldivide(xishu,youbian) ; 
                jiaodian = jieguo' ; 
            end
        end
        
        function jvli = get_jvli(obj,dian)
            % �����Ҫ���һ���㵽��������ֱ�ߵľ��롣ֱ���Ѿ���ax+by+c��
            jvli = abs((obj.a*dian(1) + obj.b*dian(2)+obj.c)/(sqrt(obj.a^2 + obj.b^2)));
        end
    
        function zhi = get_line_2point(obj,P1,P2)
            %�������򵥵�����ȷ��һ��ֱ�ߡ�
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