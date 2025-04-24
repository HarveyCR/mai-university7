f = @(x) exp(x) + log(x) - 10*x;
xs = (0:1:9);
f_xs = f(xs);

figure;
hold on;
% Используем логарифмический масштаб по оси Y
plot(xs, f_xs, '-o', LineWidth=2, Color="r");
xline(3, 'b--', LineWidth=1);
xline(4, 'b--', LineWidth=1);
yline(0, 'g--', LineWidth=1);
title('$f(x) = e^{x} + \ln(x) - 10x$', 'Interpreter', 'latex');
xlabel('$x$', 'Interpreter', 'latex');
ylabel('$f(x)$', 'Interpreter', 'latex');
grid on;