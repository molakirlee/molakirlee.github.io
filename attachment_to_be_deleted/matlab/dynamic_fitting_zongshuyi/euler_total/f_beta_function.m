function [ f ] = f_beta_function( delta_T,mu3_beta,mu3_beta140 )
%F_BETA_FUNCTION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if delta_T<0
    f=mu3_beta/mu3_beta140;
else
    f=1;
end

end

