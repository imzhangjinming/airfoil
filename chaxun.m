function zhi = chaxun(houdu,u)
%Ūһ���Ӻ�ȷֲ������ѯ��ȵĶ���������u�����v.
%�򵥵�ŪһŪ�ɣ��Ͳ�ȥ��ʲô�ĸ߽׵Ĳ�ֵ��ʲôjb����Щ�ˡ�
% Ҳ������Щ����ֵֹ����������ˡ�
[hang lie] = size(houdu) ; 
for i=1:hang-1
    if((u>=houdu(i,1))&&(u<=houdu(i+1,1)))
        zhi = (houdu(i+1,2) - houdu(i,2))*(u - houdu(i,1))/...
            (houdu(i+1,1) - houdu(i,1))+houdu(i,2);
        zhi = abs(zhi) ; 
        return ;
    end
    if((u>=houdu(i+1,1))&&(u<=houdu(i,1)))%��Ūһ���������������Ҳ�ܲ�
        zhi = (houdu(i+1,2) - houdu(i,2))*(u - houdu(i,1))/...
            (houdu(i+1,1) - houdu(i,1))+houdu(i,2);
        zhi = abs(zhi) ; 
        return ;
    end
    if(u==1)%����һ����Զ�˵ĵ�
        zhi = abs(houdu(end))*0.7 ; 
        %���0.7���Բ��ģ�ûʲô���ݡ�
        return ; 
    end
end 
fprintf('���ˣ��������ܲ�ֵ�ķ�Χ��\n ');
zhi = 0 ;  
end 