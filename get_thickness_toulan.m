function zhi = get_thickness_toulan(p_houdu)
%如名字所述，就是偷懒。
x = 0:0.025:1 ; 
x = x' ; 
[hang,lie] = size(p_houdu) ; 
if(lie ~= 4)
    fprintf('MXairfoil: invalid input parameter for get_thickness_toulan \n');
end 
y = polyval(p_houdu,x) ; 
houdu = [x,y] ; 
zhi = houdu ; 
end