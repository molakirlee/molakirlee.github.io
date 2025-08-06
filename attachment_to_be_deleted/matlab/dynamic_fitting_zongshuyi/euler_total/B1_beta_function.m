function [ y ] = B1_beta_function( delta_T )
%B1_FUNCTION 此处显示有关此函数的摘要
%   此处显示详细说明
%=====================设置常数
k_b1_beta=0.000001;
b1_beta=6.4;
%=====================
if delta_T>=0
    y=k_b1_beta*power(delta_T,b1_beta);
else
    y=0;
end

end

