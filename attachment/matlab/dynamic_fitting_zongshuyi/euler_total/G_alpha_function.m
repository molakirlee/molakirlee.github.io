function [ y ] = G_alpha_function( delta_T )
%G_ALPHA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%================================���ó���
k_g_alpha=0.0000001;
k_d_alpha=0.000001;
g_alpha=1;
d_alpha=1;
%=================================
if delta_T<0
    y=-k_d_alpha*power(-delta_T,d_alpha);
else
    y=k_g_alpha*power(delta_T,g_alpha);
end

end

