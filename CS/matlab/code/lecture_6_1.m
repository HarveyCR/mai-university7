A = 3;B = 4; C = -4; D = -1;
x = -1:0.4:1; y = -1:0.5:1;

% ones(lenght(Y),1)
%XX = [1;1;1] * [-1 -1/2 0 1/2 1]
%YY = [1/2 0 -1/2] * ones(1, lenght(x))


[X, Y] = meshgrid(x, y);
Z = (-A * X - B * Y - D) / C;
surf(X, Y, Z), box on;
xlabel('x');
ylabel('y');
zlabel('z');
title('3x + 4y - 4z - 1=0')

hSurf = findobj('Type', "Surface");
set(hSurf, 'FaceColor', 'Red');
set(hSUrf, 'FaceAlpha', 0)

flipud(cool);
% Приемер 5.19

A = [1, -5];
B = [-1, -1];
C = [-1, 1];
D = [1, -0.1];
% Координатыузловых точек
x = -2;0.4;2;
y = -2;0.4;2; % y = x

[X, Y] = meshgrid(x, x);
% Уравнение 
Z = (-A(1) * X - B(1) * Y - D(1)) / C(1);
Z(:, :, 2) = (-A(2) * X - B(2) * Y - D(2)) / C(2); % !!!!!

% Графическое окно

figure('NumberTitle','off', 'Name', 'Liner', 'Renderer','zbuffer')

% First layer color
[height_Z, width_Z] = size(Z(:,:,1));
r = (0:height_Z-1)'./(height_Z) + 0.25;
r = min(r, 1);
R = (r * ones(1, width_Z));
G = (r * zeros(1, width_Z));
B = flipud(G);
TrueColor = R;
TrueColor(:,:,2) = G;
TrueColor(:,:,3) = B;
surface('XData', X, 'YData', Y, 'ZData', Z, 'CData', TrueColor);

