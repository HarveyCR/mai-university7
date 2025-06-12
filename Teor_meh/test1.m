clc
clear

% Задаем вектора сил с известными значениями
T=[-6 6*cos(pi/3) 0]*10^3;
t=[0 3 0]*10^3;
Q=[0 0 -4]*10^3;
% Задаем переменные, значения которых требуется найти
syms RAz RBx RBy Py
% Задаем вектора сил, значения которых неизвестны
P=[0 Py 0];
RA=[0 0 RAz];
RB=[RBx RBy 0];
% Задаем координаты точек приложения сил относительно выбранной точки отсчета
a=[0 0 0.2];
b=[0 0 0.4];
c=[0 0 0.15];

Rt=[cos(pi/3) 0 0]*0.2;
RT=[0 cos(pi/3) 0]*0.2;
RQ=[1 cos(pi/3) 0]*0.2;
rG=[0 1 0]*0.1;
r=[0.2 0 0];

VA=[0 0 0];
VB=a+b+VA;
VG=VA+a+rG;
VQ=VA+a+b+c+RQ;
VP=VA+a+r;
Vt=VA+a+b+c+Rt;
VT=VA+a+b+c+RT;

mG=0:0.5:6;
mRAz=mG;
mRBx=mG;
mRBy=mG;
mPy=mG;

for i=1:length(mG)
 G=[0 0 -mG(i)]*10^3;
 % Составляем уравнения равновесия тела
 eqnP=RA+RB+T+t+G+P+Q==[0 0 0];
 eqnM=cross(RA,VA)+cross(RB,VB)+cross(T,VT)+cross(t,Vt)+cross(G,VG)+cross(P,VP)+cross(Q,VQ)==[0 0 0];

 %Решаем составленные уравнения
 [FRAz FRBx FRBy FPy]=solve([eqnP eqnM],[RAz RBx RBy Py]);
 mRAz(i)=eval(FRAz);
 mRBx(i)=eval(FRBx);
 mRBy(i)=eval(FRBy);
 mPy(i)=eval(FPy);
end
figure
hold on
xlabel('G');
ylabel('mRAx,...')

plot(mG,mRAz,'b');
plot(mG,mRBx,'g');
plot(mG,mRBy,'m');
plot(mG,mPy,'k');