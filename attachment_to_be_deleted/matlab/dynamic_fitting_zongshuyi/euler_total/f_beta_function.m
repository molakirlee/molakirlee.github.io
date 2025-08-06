function [ f ] = f_beta_function( delta_T,mu3_beta,mu3_beta140 )
%F_BETA_FUNCTION 此处显示有关此函数的摘要
%   此处显示详细说明
if delta_T<0
    f=mu3_beta/mu3_beta140;
else
    f=1;
end

end

