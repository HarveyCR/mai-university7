clc; % очистка консоли
clear; % очистка буфера данных

Q = [-cos(pi/3) 0 sin(pi/3)] * 3 * 10^3; % Вектор Силы Q
G = [0 0 1] * 2 * 10^3; % Вектор силы G
a = [0 60 0] * 10^(-2); % Вектор длины балки a
b = [0 20 0] * 10^(-2); % Вектор длины балки b
c = [0 40 0] * 10^(-2); % Вектор длины балки c
R = 20 * 10^(-2); % Скаляр радиуса R
r = [5 * 10^(-2) 0 0]; % Вектор балки r 

syms RAx  RAz RBx RBz P; % Задаем неизвестные переменные 
% 1. Реакцию опоры Ra по x
% 2. Реакцию опоры Ra по z
% 3. Реакцию опоры Rb по x
% 4. Реакцию опоры Rb по z
% 5. Силу P

PC = [cos(pi/6) 0 -sin(pi/6)] * P; % Вектор Силы P
RA = [RAx 0 RAz]; % Вектор Реакции в точки A
RB = [RBx 0 RBz]; % Вектор Реакции в точки B

rPC =[cos(pi/3) 0 sin(pi/3)] * R; % Вектор Силы P, действующий на систему

V2A = [0 0 0]; % Вектор точки A относительно A
V2Q = V2A + a + r + b; % Вектор точки приложения силы Q относительно A
V2B = V2A + a + 3*b; % % Вектор точки B относительно A
V2G = V2A + a + 3*b + c; % Вектор точки приложения силы G относительно A
V2PC = V2A + a + 3*b + c + rPC; % Вектор приложенияs Силы P относительно A

mG=0:0.5:6; % Массив разных сил G
mRAx=mG; % Массивы соразмерной длины с mG
mRAz=mG; % Массивы соразмерной длины с mG
mRBx=mG; % Массивы соразмерной длины с mG
mRBz=mG; % Массивы соразмерной длины с mG
mPz=mG; % Массивы соразмерной длины с mG

for i=1:length(mG)
 G=[0 0 -mG(i)]*10^3; % Вектор силы G
 % Составляем уравнения равновесия тела
 eqnP=RA+RB+Q+G+PC==[0 0 0];
 
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
ylabel('mRAx, ...')

plot(mG, mRAx, '--b', 'LineWidth', 1.2);
plot(mG, mRAz, '--r', 'LineWidth', 1.2);
plot(mG, mRBx, '-.g',  'LineWidth', 1.2);
plot(mG, mRBz, '-.m',  'LineWidth', 1.2);
plot(mG, mPz,  Color = [1 0.5 0], LineStyle = '-', LineWidth=1.2);
xline(2, Color = [0.5 0 0.8], LineStyle = ":", LineWidth=1);

% Добавляем легенду
legend( { ...
    'Реакция A по оси X', ...  
    'Реакция A по оси Z', ...  
    'Реакция B по оси X', ...  
    'Реакция B по оси Z', ...  
    'Сила P'   ... 
    }, ...
    'Location', 'best', ...       
    'FontSize', 12);
hold off


