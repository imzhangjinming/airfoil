function zhi = get_vertices(blocks)
%������һ��vertices��������㡣
%Ȼ����һ�¶���vertices
vertices = [] ; 
for i=1:2
    for j = 1:7
        if(~isempty(blocks{i,j}))
            for k=1:4
                if(isempty(vertices))
                    vertices = blocks{i,j}(k,:) ; 
                else
                    [panju1 , ~] = find(abs(vertices(:,1)-blocks{i,j}(k,1))<0.001) ; 
                    [panju2 , ~] = find(abs(vertices(panju1,2)-blocks{i,j}(k,2))<0.001) ;
        %             bianhao = panju1(panju2,:) ; 
        %           %��Ҫ���ҵ��������vvertice����ı��
        %           %������ֱ���õȺŻ������ף�Ū����ֵ���кô��ġ�
                    if( isempty(panju2) )
                    % �����˵�������ɨ������һ��֮ǰû�ӽ�ȥ���Ǿ����ڼӽ�ȥ
                        vertices = [vertices ; blocks{i,j}(k,:)] ; 
                    end
                end
            end
        end
    end
end 
zhi = vertices ; 

%����һ������Ĺ��ܣ������ܹ����׿�һЩ������ÿ�ζ��Լ�����
if(1)
    [hang,~] = size(vertices) ; 
    figure(1) ; 
    hold on ;
    
    for i=1:hang 
        plot(vertices(i,1),vertices(i,2),'o') ; 
        text(vertices(i,1),vertices(i,2),num2str(i-1)) ; 
    end
end
end