function [ y ] = B2_alpha_function( delta_T,mu3 )
%B1_FUNCTION 此处显示有关此函数的摘要
%   此处显示详细说明
%=========================设置常数
k_b2_alpha=650000;
b2_alpha=5;
%==========================
if delta_T>=0
    y=k_b2_alpha*power(delta_T,b2_alpha)*mu3;
else
    y=0;
end

end

