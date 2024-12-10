a = 1; 
b = 2;
c = 2; 
h = [-2:0.2:2]; % сечения поверхности
theta = [0:pi/16:2*pi]'; % долгота
al = sqrt(a^2*h.^2/c^2); bl = sqrt (b^2*h.^2/c^2);

X=cos(theta) *al; Y=sin(theta) *bl; Z=ones(size(theta), 1) * h;

   % считывание изображения в переменную
A = imread('example', 'jpg');
figure('NumberTitle', 'off', 'Name', 'Конус второго порядка',...
    'Color', 'w', 'MenuBar', 'none')

subplot (1,2,1)
image (A), axis square, axis off
title('example.jpg')
subplot (1,2,2)

% построение поверхности
surf (X, Y, Z, 'CData', A, 'FaceColor', 'texture', 'EdgeColor', 'none')

% в оформление графика
axis equal, box on, set (gca, 'Color', 'none'), view (-36,23)
xlabel('x'), ylabel('y'), zlabel('z')
title('\ita \rm= 1; \itb \rm= 2; \itc \rm=2')