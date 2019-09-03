%
function KeneticFitting
format long
clear all
clc
% -------------------------------------------
% -------------------------------------------
%如果修改数据的话直接改yexp里面的数据就行，第一行写的是ΓE，第二行是ΓI，第三行是E[bulk]。
%tspan里面是写的时间点，跟上面数据对应起来就好。
yexp = [34.85 39.03 38.29 49.11;
    18.12 22.3 80.82 89.17;
    50 50 50 50];
tspan = [300 600 1500 1800];
x0=[34.85 18.12 50];
k0 = [0 0 0];
lb = [0 0 0];
ub = [1 1 1]*1e5;
% -------------------------------------------
% -------------------------------------------
[k,resnorm,residual,exitflag,output,lambda,jacobian] =lsqnonlin(@ObjFunc,k0,lb,ub,[],tspan,x0,yexp);       
ts=0:max(tspan);
[ts ys]=ode45(@KineticsEqs,ts,x0,[],k);
[tsim ysim] = ode45(@KineticsEqs,tspan,x0,[],k);
yexpp=yexp';
Tysim=ysim(:,1)+ysim(:,2);
Tyexp=yexpp(:,1)+yexpp(:,2);
figure(1),plot(tspan,Tysim,'r',tspan,Tyexp,'or'),legend('总吸附量计算值','总吸附量实验值','Location','best');
figure(2),plot(tspan,yexpp(:,1),'og',tspan,yexpp(:,2),'ob',tspan,ysim(:,1),'--g',tspan,ysim(:,2),'--b'),...
    legend('可逆吸附量实验值','不可逆吸附量实验值','可逆吸附量计算值','不可逆吸附量计算值','Location','best');
figure(3),plot(tspan,Tysim,'r',tspan,Tyexp,'or',tspan,yexpp(:,1),'og',tspan,yexpp(:,2),'ob',tspan,ysim(:,1),'--g',tspan,ysim(:,2),'--b'),...
    legend('总吸附量计算值','总吸附量实验值','可逆吸附量实验值','不可逆吸附量实验值','可逆吸附量计算值','不可逆吸附量计算值','Location','best');
Compare=[tsim Tysim Tyexp abs(Tysim-Tyexp)./Tyexp*100];
colnames1 = {'时间','总吸附量计算值', '总吸附量实验值', '误差百分比/%'};
table=uitable(figure(4),'Data',Compare,'ColumnName', colnames1);
colnames2 = {'ka','kd','kI'};
table=uitable(figure(5),'Data',k,'ColumnName', colnames2);
function dCdt = KineticsEqs(t,C,k)    
QE=C(1);QI=C(2);Eb=C(3);
ka = k(1);
kd = k(2);
kI = k(3) ;
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

