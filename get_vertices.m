function zhi = get_vertices(blocks)
%就生成一个vertices用于输出点。
%然后处理一下顶点vertices
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
        %           %所要查找的这个点在vvertice里面的编号
        %           %浮点数直接用等号还是离谱，弄点阈值是有好处的。
                    if( isempty(panju2) )
                    % 这个的说法是如果扫到的这一点之前没加进去，那就现在加进去
                        vertices = [vertices ; blocks{i,j}(k,:)] ; 
                    end
                end
            end
        end
    end
end 
zhi = vertices ; 

%增加一个画点的功能，这样能够容易看一些。不用每次都自己数。
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