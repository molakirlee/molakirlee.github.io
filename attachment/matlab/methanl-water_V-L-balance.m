bb0=[1,1]
[bb,resnorm]=lsqnonlin('qiye',bb0)

�ӳ���
function F=qiye(bb)
x1=0.01*[40.6 44.7 53.4 76.2];   //Һ��״�Ũ��
x2=1-x1;
y1=0.01*[54.9 65.0 75.6 83.2];   //����״�Ũ��
y2=1-y1;
Pa0 =[1473.315 1250.395	1063.283 996.227];   //�״���������ѹ
Pb0 =[396.551 328.522 272.766 253.119];   //ˮ��������ѹ
for i=1:4
F(i)=y1(i)-Pa0(i)*x1(i)/760*exp(-log(x1(i)+bb(1)*x2(i))+x2(i)*(bb(1)/(x1(i)+bb(1)*x2(i))-bb(2)/(x2(i)+bb(2)*x1(i))))
End
for i=5:8
j=i-4
F(i)=y2(j)-Pb0(j)*x2(j)/760*exp(-log(x2(j)+bb(2)*x1(j))+x1(j)*(bb(2)/(x2(j)+bb(2)*x1(j))-bb(1)/(x1(j)+bb(1)*x2(j))))
end

