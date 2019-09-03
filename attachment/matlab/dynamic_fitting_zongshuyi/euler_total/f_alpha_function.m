function [ f ] = f_alpha_function( delta_T,mu3_alpha,mu3_alpha140 )
%F_ALPHA_FUNCTION 此处显示有关此函数的摘要
%   此处显示详细说明
if delta_T<0
    f=mu3_alpha/mu3_alpha140;
else
    f=1;
end

end

