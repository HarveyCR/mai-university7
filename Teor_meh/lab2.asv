clc
clear
% Задаем вектора сил с известными значениями
T=[4*cos(pi/6) 0 4*sin(pi/6)]*10^3;
t=[2 0 0]*10^3;
Q=[-cos(pi/4) 0 sin(pi/4)]*10^3;
% Задаем переменные, значения которых требуется найти
syms RAx RAz RBx Rbz Pz
% Задаем вектора сил, значения которых неизвестны
P=[0 0 Pz];
RA=[RAx 0 RAz];
RB=[RBx 0 Rbz];
% Задаем координаты точек приложения сил относительно выбранной точки
% отсчета
a=[0 0.3 0];
b=[0 0.4 0];
%b=[0 0.8 0];
%c=[0 0.2 0];
c=[0 0.8 0];
rt=[0 0 0.1];
rT=[cos(-pi/3) 0 sin(-pi/3)]*0.1;
rQG=[-sin(pi/4) 0 cos(pi/4)]*0.1;
R=[0.2 0 0];
VA=[0 0 0];
VB=a+b+VA;
VG=VA+a+rQG;
VP=VA+a+R;
Vt=VA+a+b+c+rt;
VT=VA+a+b+c+rT;
mG=[0:0.5:6]*-10^3;
mRAx=mG;
mRAz=mG;
mRBx=mG;
mRBz=mG;
mPz=mG;
for i=1:length(mG)
 G=[0 0 mG(i)];
 % Составляем уравнения равновесия тела
 eqnP=RA+RB+T+t+G+P+Q==[0 0 0];
 
eqnM=cross(RA,VA)+cross(RB,VB)+cross(T,VT)+cross(t,Vt)+cross(G,VG)+cross(P,VP)+cross(Q,VG)==[0 0 0];
 %Решаем составленные уравнения
 [FRAx FRAz FRBx FRBz FPz]=solve([eqnP
eqnM],[RAx RAz RBx Rbz Pz]);
 mRAx(i)=eval(FRAx);
 mRAz(i)=eval(FRAz);
 mRBx(i)=eval(FRBx);
 mRBz(i)=eval(FRBz);
 mPz(i)=eval(FPz);
end
figure
hold on
xlabel('G');
ylabel('mRAx,...')
plot(mG,mRAx,'r');
plot(mG,mRAz,'b');
%plot(mG,mRBx,'g');
%plot(mG,mRBz,'m');
hold off;

figure
hold on
xlabel('G');
ylabel('mPz')
plot(mG,mPz,'k');

