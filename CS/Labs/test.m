close all; clear; clc;
r = 1; n = 50;
theta = linspace(0, 2*pi, n);
Ax = r * cos(theta);
Ay = r * sin(theta);
a = 2.5; e = 0.25; c = 0.5; d = 1; t = 0.06;
By = e + c/2;
Bx = Ax + sqrt(a^2 - (Ay - e -c/2).^2);
plot(Ax, Ay, '--', 0, 0, 'ko');
axis equal;
hold on;
axislimits = [min(Ax)*1.1 max(Bx)*1.2 min(Ay)*1.1 max(Ay)*1.1];
sliderY = [e e+c e+c e e];
groundX = [min(Bx)-d/2 min(Bx)-d/2 max(Bx)+d/2 max(Bx)+d/2 min(Bx)-d/2];
groundY = [e-t e e e-t e-t];
for i = 1:n
    plot(Ax, Ay, '--', 0, 0, 'ko');
    axis equal;
    hold on;
    sliderX = [Bx(i)-d/2 Bx(i)-d/2 Bx(i)+d/2 Bx(i)+d/2 Bx(i)-d/2];
    fill(sliderX, sliderY, 'm')
    fill(groundX, groundY, 'g')
    plot([0, Ax(i)], [0, Ay(i)], 'k')
    plot(Ax(i), Ay(i), 'ko')
    plot(Bx(i), By, 'ko')
    axis(axislimits)
    plot([Ax(i), Bx(i)], [Ay(i), By], 'k')
    hold off;
    pause(0.05);
end