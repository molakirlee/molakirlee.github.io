clear;
clc;
%%%%%%%%%%%%    设置常数
P_alpha=1500000;    P_beta=1500000;
k_alpha=1;    k_beta=1;
L0_alpha=0.00001;   L0_beta=0.00001;

step=1;    %迭代步长
N=600;         %迭代终止时间
%====================================
t=0:step:N;
num=N/step+1;
C=zeros(size(t));
mu0_alpha=zeros(size(t));mu1_alpha=zeros(size(t));
mu2_alpha=zeros(size(t));mu3_alpha=zeros(size(t));
%=======================================
C(1)=0.2092;    %设置常数
%=======================================
mu0_alpha(1)=0;mu1_alpha(1)=0;mu2_alpha(1)=0;mu3_alpha(1)=0;
delta_T_alpha=zeros(size(t));
G_alpha=zeros(size(t));
B1_alpha=zeros(size(t));
B2_alpha=zeros(size(t));
f_alpha=zeros(size(t));

f_beta=zeros(size(t));
mu0_beta=zeros(size(t));mu1_beta=zeros(size(t));
mu2_beta=zeros(size(t));mu3_beta=zeros(size(t));
mu0_beta(1)=0;mu1_beta(1)=0;mu2_beta(1)=0;mu3_beta(1)=0;
delta_T_beta=zeros(size(t));
G_beta=zeros(size(t));
B1_beta=zeros(size(t));
B2_beta=zeros(size(t));

for i=1:num
%     x=T_sat_function(C(i));
%     y=T_function(t(i));
    delta_T_alpha(i)=T_sat_alpha_function(C(i))-T_function(t(i));
    delta_T_beta(i)=T_sat_beta_function(C(i))-T_function(t(i));
    f_alpha(i)=f_alpha_function(delta_T_alpha(i),mu3_alpha(i),mu3_alpha(140));
    f_beta(i)=f_beta_function(delta_T_beta(i),mu3_beta(i),mu3_beta(140));
    
    G_alpha(i)=G_alpha_function(delta_T_alpha(i));
    G_beta(i)=G_beta_function(delta_T_beta(i));
    
    B1_alpha(i)=B1_alpha_function(delta_T_alpha(i));
    B2_alpha(i)=B2_alpha_function(delta_T_alpha(i),mu3_alpha(i));
    B1_beta(i)=B1_beta_function(delta_T_beta(i));
    B2_beta(i)=B2_beta_function(delta_T_beta(i),mu3_beta(i));
    
    C(i+1) =C(i)+step*((-P_alpha*k_alpha*(3*f_alpha(i)*G_alpha(i)* ...
        mu2_alpha(i)+(B1_alpha(i)+B2_alpha(i))*power(L0_alpha,3)))-(P_beta* ...
        k_beta*(3*f_beta(i)*G_beta(i)*mu2_beta(i)+(B1_beta(i)+B2_beta(i)) ...
        *power(L0_beta,3))));
    mu0_alpha(i+1)=mu0_alpha(i)+step*(B1_alpha(i)+B2_alpha(i));
    mu1_alpha(i+1)=mu1_alpha(i)+step*(f_alpha(i)*G_alpha(i)*mu0_alpha(i) ...
        +(B1_alpha(i)+B2_alpha(i))*L0_alpha);
    mu2_alpha(i+1)=mu2_alpha(i)+step*(2*f_alpha(i)*G_alpha(i)*mu1_alpha(i) ...
        +(B1_alpha(i)+B2_alpha(i))*L0_alpha^2);
    mu3_alpha(i+1)=mu3_alpha(i)+step*(3*f_alpha(i)*G_alpha(i)*mu2_alpha(i) ...
        +(B1_alpha(i)+B2_alpha(i))*L0_alpha^3);
    
    mu0_beta(i+1)=mu0_beta(i)+step*(B1_beta(i)+B2_beta(i));
    mu1_beta(i+1)=mu1_beta(i)+step*(f_beta(i)*G_beta(i)*mu0_beta(i) ...
        +(B1_beta(i)+B2_beta(i))*L0_beta);
    mu2_beta(i+1)=mu2_beta(i)+step*(2*f_beta(i)*G_beta(i)*mu1_beta(i) ...
        +(B1_beta(i)+B2_beta(i))*L0_beta^2);
    mu3_beta(i+1)=mu3_beta(i)+step*(3*f_beta(i)*G_beta(i)*mu2_beta(i) ...
        +(B1_beta(i)+B2_beta(i))*L0_beta^3);

end
