clear all
clc
A = '1.5x1+2x2+3x3+45x4+x5'
AA = strrep(A,'+x','+1x');
S = regexp(AA,'+','split');
R = zeros(length(S),2);
RR = cell(length(S),2);
for i=1:length(S)
    S(i);
    S2=cell2mat(S(i))
    k=1;
    for n=1:length(S2)
        j = str2num(S2(n));
        if (j<=9&j>=0)
            j;
            jj(k)=j;
            k=k+1;
        else
            S2(n:end)
            RR{i,2}=S2(n:end);
            w=length(jj);
            jjj=0;
            for j=1:w              
                jjj=jjj+jj(j)*10^(w-1);
                w=w-1;
            end
            jjj;
            R(i,1)=jjj;
            RR{i,1}=jjj;
            RR
            clear jj
            break
        end
        
        
    end      
end
% Result=sortrows(RR,-1)
% xlswrite('D:\Order',Result)
 