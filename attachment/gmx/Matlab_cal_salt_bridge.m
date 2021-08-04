clear
clear all
%load file
FN=dir(['*.dat']);
%Creat a matrix with serial number
%读取dat文件，取其横坐标写入C0
C00=load(FN(1).name);
C0=C00(:,1);
%给不同条件下的C横坐标赋值
Cs=C0;%相同链,same
Cd=C0;%不同链,different
Ct=C0;%所有链,total
%----------------------------------------------------------
%iteration
%
for n=1:length(FN) %迭代所有.dat文件
% Check if same chain
    Aname=FN(n).name;
    AAname = strsplit(Aname,'-');
    A4n=1;
    A4={};
    for i=1:length(AAname)
        char(AAname(i));
        AAAname = strsplit(char(AAname(i)),'_');
        for j=1:length(AAAname)
            A4(A4n)={char(AAAname(j))};
            A4n=A4n+1;
        end
    end
    A5 = strsplit(char(A4(5)),'.');
    A4(5)={char(A5(1))};
    A4(6)={char(A5(2))};
    A4;
    %分别处理同链盐桥、异链盐桥、总盐桥
     if char(A4(3))==char(A4(5)) %若同一条链则进行如下处理
        B=load(FN(n).name);%读取第n个dat文件的内容
        B(:,[1])=[];%删除第一列数据，及删除横坐标
        Cs=[Cs,B];%将该组数据写入Cs之中,same
        else
        B=load(FN(n).name);%读取第n个dat文件的内容
        B(:,[1])=[];%删除第一列数据，及删除横坐标
        Cd=[Cd,B];%将该组数据写入Cd之中,different
     end
     B=load(FN(n).name);%读取第n个dat文件的内容
     B(:,[1])=[];%删除第一列数据，及删除横坐标
     Ct=[Ct,B];%将该组数据写入Cd之中,total
end
%----------------------------------------------------
%Calculate salt bridge between same chain
%
[Rnum,Cnum]=size(Cs);%读取Cs的行/列数
k=0;
for i=1:Rnum
    for j=2:Cnum
        if Cs(i,j)<4
            k=k+1;
        end
    end
    Cs(i,j+1)=k;
    k=0;
end
%Calculate salt bridge between different chain
%
[Rnum,Cnum]=size(Cd);%读取Cd的行/列数
k=0;
for i=1:Rnum
    for j=2:Cnum
        if Cd(i,j)<4
            k=k+1;
        end
    end
    Cd(i,j+1)=k;
    k=0;
end
%Calculate salt bridge totally
%
[Rnum,Cnum]=size(Ct);%读取Cd的行/列数
k=0;
for i=1:Rnum
    for j=2:Cnum
        if Ct(i,j)<4
            k=k+1;
        end
    end
    Ct(i,j+1)=k;
    k=0;
end
%----------------------------------------------------------
%Write to xls
% xlswrite('Salt_bridge_chain_s.xls',Cs)
% xlswrite('Salt_bridge_chain_d.xls',Cd)
% xlswrite('Salt_bridge_chain_t.xls',Ct)%如果数量太多的话可能写出会报错
%Write to txt
CA=[Cs(:,end),Cd(:,end),Ct(:,end)];%统计盐桥情况，用于analyze
xlswrite('Salt_bridge_chain_a.xls',CA)
dlmwrite('Salt_bridge_chain_s.txt',Cs)
dlmwrite('Salt_bridge_chain_d.txt',Cd)
dlmwrite('Salt_bridge_chain_t.txt',Ct)
%---------------------
%---------------------
%---------------------
%Code Writen Before
%
%
%Combine Data
% for i=1:length(FN)
%     if i==1
%         A=load(FN(i).name);    
%     else
%         B=load(FN(i).name);
%         B(:,[1])=[];
%     end
%     if i==2
%         C=[A,B];
%     elseif i>2
%         CC=C;
%         C=[CC,B];
%     end
% end
% % salt bridge detective
% [Rnum,Cnum]=size(C);
% k=0;
% for i=1:Rnum
%     for j=2:Cnum
%         if C(i,j)<4
%             k=k+1;
%         end
%     end
%     C(i,j+1)=k;
%     k=0;
% end