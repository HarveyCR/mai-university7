[iconData, iconCmap] = imread('grfwnd','ico');
createMode.WindowStyle = 'modal';
createMode.Interpreter = 'tex';
message = {'Вы вошли в Мир';'\bfMat^{rix} Lab^{oratory}'};
msgbox(message,'Привет!','custom', iconData, iconCmap, createMode);
clear message iconData iconCmap createMode

quest = {'Вы действительно хотите покинуть мир','\bfMat^{rix} Lab^{oratory}?'};
Options.Default = 'Нет'; Options.Interpreter = 'tex'; l = false;
l = strcmp(questdlg(quest,'Выход','До свидания', 'Нет', Options),'До свидания');
if l ~= true, quit cancel, end

[iconData, iconCmap] = imread('grfwnd','ico');
createMode.WindowStyle = 'modal';
createMode.Interpreter = 'tex';
message = {' Вы вошли в мир';'\bfMat^{rix} Lab^{oratory}'};
msgbox(message,'Привет!','custom',iconData,iconCmap,createMode);
screen= get(0,'screensize');
width=450; height=350;
position=[fix((screen(3)-width)/2), fix((screen(4)-height)/2), width, height];
set(0,'DefaultFigurePosition', position);
clear screen position width height
clear message iconData iconCmap createMode

sphere(40)

% Параметры спирали
a = 1;      % Масштабный коэффициент
b = 0.1;    % Коэффициент экспоненты
% Диапазон углов (в радианах)
phi = linspace(0, 4*pi, 1000); % от 0 до 4*pi с 1000 точками
% Вычисление радиус-вектора r
r = a .* exp(b - phi);
% Перевод в декартовы координаты
x = r .* cos(phi);
y = r .* sin(phi);
% Построение графика
figure;
plot(x, y, 'b', 'LineWidth', 1.5);
grid on;
axis equal;
title('Логарифмическая спираль');
xlabel('x');
ylabel('y');