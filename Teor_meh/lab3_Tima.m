clc; % очистка консоли
clear; % очистка буфера данных

Q = [0 0 -1] * 4 * 10^3; % Вектор Силы Q
T = [-cos(pi/6) sin(pi/6) 0] * 6 * 10^3; % Вектор Силы T
G = [0 0 -1] * 3 * 10^3; % Вектор силы G
t = [0 1 0] * (6/2) * 10^3;
a = [0 0 20] * 10^(-2); % Вектор длины балки a
b = [0 0 40] * 10^(-2); % Вектор длины балки b
c = [0 0 15] * 10^(-2); % Вектор длины балки c
R = 20 * 10^(-2); % Скаляр радиуса R
r = 10 * 10^(-2); % Вектор балки r 

syms RAx RAy RAz RBx RBy RBz P; % Задаем неизвестные переменные 
% 1. Реакцию опоры Ra по x
% 2. Реакцию опоры Ra по z
% 3. Реакцию опоры Rb по x
% 4. Реакцию опоры Rb по z
% 5. Силу P

PC = [0 1 0] * P; % Вектор Силы P
RA = [RAx RAy RAz]; % Вектор Реакции в точки A
RB = [RBx RBy 0]; % Вектор Реакции в точки B

rPC =[1 0 0] * r; % Вектор Силы P, действующий на систему
rQC =[-1 0 0] * R; % Вектор Силы Q, действующий на систему
rTC = [-sin(pi/6) -cos(pi/6) 0] * R;
rtC = [1 0 0] * R;

V2A = [0 0 0]; % Вектор точки A относительно A
V2PC = V2A + a + rPC; % Вектор приложенияs Силы P относительно A
V2G = V2A + a + b/2; % Вектор точки приложения силы G относительно A
V2B = V2A + a + b; % % Вектор точки B относительно A
V2Q = V2A + a + b + c + rQC; % Вектор точки приложения силы Q относительно A
V2T = V2A + a + b + c + rTC; % Вектор точки приложения силы Q относительно A
V2t = a + b + c + rtC;

mG=0:0.5:6; % Массив разных сил G
mRAx=mG; % Массивы соразмерной длины с mG
mRAy=mG; % Массивы соразмерной длины с mG
mRAz=mG; % Массивы соразмерной длины с mG
mRBx=mG; % Массивы соразмерной длины с mG
mRBy=mG; % Массивы соразмерной длины с mG
mPy=mG; % Массивы соразмерной длины с mG

for i=1:length(mG)
 G=[0 0 -mG(i)]*10^3; % Вектор силы G
 % Составляем уравнения равновесия тела
 eqnP=RA+RB+Q+G+PC+T+t==[0 0 0];
 
eqnM=cross(RA,V2A)+cross(RB,V2B)+cross(Q,V2Q)+cross(G,V2G)+cross(PC,V2PC)+cross(T, V2T)+cross(t, V2t)==[0 0 0];
 %Решаем составленные уравнения
 [FRAx, FRAy, FRAz, FRBx, FRBy, FP]=solve([eqnP
eqnM],[RAx RAy RAz RBx RBy P]);
 mRAx(i)=eval(FRAx);
 mRAy(i)=eval(FRAy);
 mRAz(i)=eval(FRAz);
 mRBx(i)=eval(FRBx);
 mRBy(i)=eval(FRBy);
 mPy(i)=eval(FP);
end

figure
hold on
xlabel('G');
ylabel('mRAx, ...')

plot(mG, mRAx, '--b', 'LineWidth', 1.2);
plot(mG, mRAy, '--m', 'LineWidth', 1.2);
plot(mG, mRAz, '--r', 'LineWidth', 1.2);
plot(mG, mRBx, '-.g',  'LineWidth', 1.2);
plot(mG, mRBy, '-.m',  'LineWidth', 1.2);
plot(mG, mPy,  Color = [1 0.5 0], LineStyle = '-', LineWidth=1.2);
xline(3, Color = [0.5 0 0.8], LineStyle = ":", LineWidth=1);

% Добавляем легенду
legend( { ...
    'Реакция A по оси X', ...  
    'Реакция A по оси Y', ...  
    'Реакция A по оси Z', ...  
    'Реакция B по оси X', ...  
    'Реакция B по оси Y', ...  
    'Сила P'   ... 
    }, ...
    'Location', 'best', ...       
    'FontSize', 12);
hold off


