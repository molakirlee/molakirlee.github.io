function KeneticFitting22
format long
clear all
clc
% -------------------------------------------
% -------------------------------------------
%����޸����ݵĻ�ֱ�Ӹ�yexp��������ݾ��У���һ��д���Ǧ�E���ڶ����Ǧ�I����������E[bulk]��
%tspan������д��ʱ��㣬���������ݶ�Ӧ�����ͺá�
yexp = [0 30.60 34.85 39.03 43.29 49.11;
    0 14.23 18.12 22.3 80.82 89.17;
    50 50 50 50 50 50];
tspan = [0 150 300 600 1500 1800];
x0=[0 0 50];
% k0 = [2.079e-5 0 0];
% lb = [0 0 0];
% ub = [1 1 1]*1e5;
k0 = [0 0];
lb = [0 0];
ub = [1 1]*1e5;
% -------------------------------------------
% -------------------------------------------
[k,resnorm,residual,exitflag,output,lambda,jacobian] =lsqnonlin(@ObjFunc,k0,lb,ub,[],tspan,x0,yexp);       
ts=0:1:max(tspan);
[ts ys]=ode45(@KineticsEqs,ts,x0,[],k);
[tsim ysim] = ode45(@KineticsEqs,tspan,x0,[],k);
yexpp=yexp';
Tysim=ysim(:,1)+ysim(:,2);
Tyexp=yexpp(:,1)+yexpp(:,2);
figure(1),plot(tspan,Tysim,'r',tspan,Tyexp,'or'),legend('������������ֵ','��������ʵ��ֵ','Location','best');
figure(2),plot(tspan,yexpp(:,1),'og',tspan,yexpp(:,2),'ob',tspan,ysim(:,1),'--g',tspan,ysim(:,2),'--b'),...
    legend('����������ʵ��ֵ','������������ʵ��ֵ','��������������ֵ','����������������ֵ','Location','best');
figure(3),plot(tspan,Tysim,'r',tspan,Tyexp,'or',tspan,yexpp(:,1),'og',tspan,yexpp(:,2),'ob',tspan,ysim(:,1),'--g',tspan,ysim(:,2),'--b'),...
    legend('������������ֵ','��������ʵ��ֵ','����������ʵ��ֵ','������������ʵ��ֵ','��������������ֵ','����������������ֵ','Location','best');
Compare=[tsim Tysim Tyexp abs(Tysim-Tyexp)./Tyexp*100];
colnames1 = {'ʱ��','������������ֵ', '��������ʵ��ֵ', '���ٷֱ�/%'};
table=uitable(figure(4),'Data',Compare,'ColumnName', colnames1);
colnames2 = {'ka','kd','kI'};
ka = 2.079e-5;
kk = [ka k];
table=uitable(figure(5),'Data',kk,'ColumnName', colnames2);
TTsim = ts;
YYsim = ys(:,1)+ys(:,2);
TTYYsim = [TTsim YYsim];
xlswrite('D:\simulationdate',TTYYsim);


function dCdt = KineticsEqs(t,C,k)    
QE=C(1);QI=C(2);Eb=C(3);
% ka = k(1);
% kd = k(2);
% kI = k(3);
ka =2.079e-5;
kd = k(1);
kI = k(2);
dQEdt=ka*Eb*(138.28-QE-QI)-kd*QE-kI*QE;
dQIdt=kI*QE;
Eb=50;
dCdt=[dQEdt;dQIdt;Eb];
function f = ObjFunc(k,tspan,x0,yexp)           
[t Ysim] = ode45(@KineticsEqs,tspan,x0,[],k);
Ysim1=Ysim(:,1);
Ysim2=Ysim(:,2);
Ysim1;
ysim(:,1) = Ysim1(1:end);
ysim(:,2) = Ysim2(1:end);
size(ysim(:,1));
yexpp=yexp';
size(yexpp(:,1));
f = [(ysim(:,1)-yexpp(:,1));(ysim(:,2)-yexpp(:,2))];

