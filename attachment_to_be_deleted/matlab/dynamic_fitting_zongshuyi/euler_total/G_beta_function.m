function [ y ] = G_beta_function( delta_T )
%G_ALPHA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%============================���ó���
k_g_beta=0.00000001;
k_d_beta=1;
g_beta=1;
d_beta=1;
%==============================

if delta_T<0
    y=-k_d_beta*power(-delta_T,d_beta);
else
    y=k_g_beta*power(delta_T,g_beta);
end

end

