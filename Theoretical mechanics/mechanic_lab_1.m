clc;
clear;

Q = [-cos(pi/3) 0 sin(pi/3)] * 3 * 10^3;
G = [cos(pi/6) 0 -sin(pi/6)] * 2 * 10^3;
a = [0 60 0] * 10^(-2);
b = [0 20 0] * 10^(-2);
c = [0 40 0] * 10^(-2);
R = 20 * 10^(-2);
r = [5 * 10^(-2) 0 0];

force_vectorQ = [Q * sin(pi/3) 0 -Q * cos(pi/3)];
force_vectorG = [0 0 -G];

syms RAx  RAz RBx  RBz P;

PC = [cos(pi/6) 0 -sin(pi/6)] * P;
RA=[RAx 0 RAz];
RB=[RBx 0 RBz];

rPC =[cos(pi/3) 0 sin(pi/3)] * R;

V2A = [0 0 0];
V2Q = V2A + a + r + b;
V2B = V2A + a + 3*b;
V2G = V2A + a + 3*b + c;
V2PC = V2A + a + 3*b + c + rPC;

mG=0:0.5:6;
mRAx=mG;
mRAz=mG;
mRBx=mG;
mRBz=mG;
mPz=mG;

for i=1:length(mG)
 G=[0 0 -mG(i)]*10^3;
 % Составляем уравнения равновесия тела
 eqnP=RA+RB+Q+G+PC+Q==[0 0 0];
 
eqnM=cross(RA,V2A)+cross(RB,V2B)+cross(Q,V2Q)+cross(G,V2G)+cross(PC,V2PC)==[0 0 0];
 %Решаем составленные уравнения
 [FRAx, FRAz, FRBx, FRBz, FP]=solve([eqnP
eqnM],[RAx  RAz RBx  RBz P]);
 mRAx(i)=eval(FRAx);
 mRAz(i)=eval(FRAz);
 mRBx(i)=eval(FRBx);
 mRBz(i)=eval(FRBz);
 mPz(i)=eval(FP);
end
figure
hold on
xlabel('G');
ylabel('mRAx,...')

plot(mG,mRAx,'--r', 'LineWidth',2);
plot(mG,mRAz,'--b', 'LineWidth',2);
plot(mG,mRBx,':g', 'LineWidth', 1);
plot(mG,mRBz,':m', 'LineWidth', 1);
plot(mG,mPz, '-ok');

