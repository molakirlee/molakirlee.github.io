function [ f ] = f_alpha_function( delta_T,mu3_alpha,mu3_alpha140 )
%F_ALPHA_FUNCTION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if delta_T<0
    f=mu3_alpha/mu3_alpha140;
else
    f=1;
end

end

