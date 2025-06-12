% Ряд Фурье
% sympref('dispaley', 'unicode');

syms x real;
% syms L real;
syms pi;
syms k integer positive; % Целое число

% Определение кусочно-линейной функции

disp('Кусочно Линейная Функция f(x) = ')

f(x) = piecewise(x > 0, 1, 0);

pretty(f(x));

L = 1; % Полупериод
% Вычисение коэффициентов а0
disp("\nКоэффициент a_0 = ");

a0 = 1 / L * int(f(x), x, -L, L);
pretty(a0);

disp("\nАналитическое вырадение для коэффициентов");
ak = 1 / L * int(f(x) * cos(pi*k*x/L), x, -L, L);
pretty(ak);

disp("\nАналитическое вырадение для коэффициентов");
bk = 1 / L * int(f(x) * sin(pi*k*x/L), x, -L, L);
pretty(bk);

disp("\nЧастная сумма тригонометрических");
s4 = a0/2 + symsum(ak * cos(pi*k*x/L)+ ...
    bk * sin(pi*k*x/L), k, 1, 4);

disp("\nЧастная сумма тригонометрических");
s10 = a0/2 + symsum(ak * cos(pi*k*x/L)+ ...
    bk * sin(pi*k*x/L), k, 1, 10);

pretty(expand(simplify(s4)))

h4 = ezplot(s4, [-2*L 2*L]);
set(h4, 'LineWidth', 1, 'Color', 'r')
grid on, hold on
h10 = ezplot(s10, [-2*L 2*L]);
set(h10, 'LineWidth', 1, 'Color', 'r')

T = tic;
Sigma4 = sqrt(int(f(x) - s4)^2 , x, -L, L);
eTime = toc(T);
disp('sigma_4 = ');
pretty(Sigma4);

fprintf(1, " = %.15f\n", double(Sigma4));
fprintf(1, " Время вычисления t = %3.f", eTime);


T = tic;
Sigma10 = sqrt(int(f(x) - s10)^2 , x, -L, L);
eTime = toc(T);
disp('sigma_10 = ');
pretty(Sigma10);

fprintf(1, " = %.15f\n", double(Sigma10));
fprintf(1, " Время вычисления t = %3.f", eTime);
