clear all
clc
p1=[2.4864;2.7232;2.5456;2.4272];
p2=[1.776;1.0064;2.2496;1.3616];
p3=[0.9472;1.5984;1.5392;2.072;0.7104;2.072];
p4=[0.98213;1.46283;1.3024;2.368];
p5=[0.98094;0.81874;1.9536;0.6512;2.2496];
p6=[1.5984;1.4208;1.8352;0.7696;1.5984];
p7=[1.5984;1.0656;1.0656;1.0656];
p8=[1.2432;1.776;0.9472];
p9=[2.368;2.4864;2.6048];
p10=[3.0784;3.4336;3.0192];
p11=[1.184;1.2432;1.4208];
p12=[0.888;0.7696;1.3616];

%p={p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12};
p={p1 p2 p3 p4 p5 p6}
for i=1:6
    for j=(i+1):length(p)
%         i
%         p{i}
%         j
%         p{j}
        [H{i,j},P{i,j},CI{i,j}, STATS{i,j}]=ttest2(p{i},p{j}, 0.05);
    end
end