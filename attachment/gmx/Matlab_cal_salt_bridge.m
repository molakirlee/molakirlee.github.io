clear
clear all
%load file
FN=dir(['*.dat']);
%Creat a matrix with serial number
C00=load(FN(1).name);
C0=C00(:,1);
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
    %What to do if in the same chain
    %Remove first column and combine data
    if char(A4(3))==char(A4(5)) %若同一条链则进行如下处理
        [rC0,cC0]=size(C0);
        B=load(FN(n).name);
        B(:,[1])=[];
        C0=[C0,B];
    end

end
%Calculate salt bridge
%
[Rnum,Cnum]=size(C0);
k=0;
for i=1:Rnum
    for j=2:Cnum
        if C0(i,j)<4
            k=k+1;
        end
    end
    C0(i,j+1)=k;
    k=0;
end
%Write to xls
xlswrite('Salt_bridge_same_chain.xls',C0)
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