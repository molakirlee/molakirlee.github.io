function [ y ] = B2_beta_function( delta_T,mu3 )
%B1_FUNCTION 此处显示有关此函数的摘要
%   此处显示详细说明
%========================设置常数
k_b2_beta=650000;
b2_beta=5;
%========================
if delta_T>=0
    y=k_b2_beta*power(delta_T,b2_beta)*mu3;
else
    y=0;
end

end

