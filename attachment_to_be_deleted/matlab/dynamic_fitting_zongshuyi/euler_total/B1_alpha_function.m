function [ y ] = B1_alpha_function( delta_T )
%B1_FUNCTION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%====================���ó���
k_b1_alpha=0.000001;
b1_alpha=6.4;
%====================
if delta_T>=0
    y=k_b1_alpha*power(delta_T,b1_alpha);
else
    y=0;
end

end

