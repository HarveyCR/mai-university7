%% Анализ функции f(x) в MATLAB

clc; clearvars; close all;
syms x real
syms f(x)

%% === УКАЖИТЕ ВАШУ ФУНКЦИЮ НИЖЕ ===
f(x) = (2*x^2 - 4*x + 7)/(x + 3);  % Пример. Можно заменить.
% f(x) = log(x^2 - 1);            % Пример 2. Попробуйте!
% f(x) = sin(x)/x;                % Пример 3.
% ================================

fprintf("Анализ функции f(x) = %s\n\n", char(f(x)));

%% 1) Область определения
[Num, Den] = numden(f(x));
all_singular = solve(Den == 0, x);  % могут быть комплексные
singular = all_singular(imag(all_singular) == 0);  % только вещественные
fprintf("1) Область определения: ");
if isempty(singular)
    fprintf("весь R\n\n");
else
    fprintf("R \\ { %s }\n\n", strjoin(string(singular), ", "));
end

%% 2) Чётность / нечётность
evenTest = simplify(f(x) - f(-x)) == 0;
oddTest  = simplify(f(x) + f(-x)) == 0;
fprintf("2) Чётность/нечётность: ");
if isAlways(evenTest)
    fprintf("чётная\n\n");
elseif isAlways(oddTest)
    fprintf("нечётная\n\n");
else
    fprintf("общего вида\n\n");
end

%% 3) Пересечения с осями
% Ось Ox:
rootsOx = vpasolve(f(x) == 0, x, [-100, 100]);
fprintf("3) Пересечения с Ox: ");
if isempty(rootsOx)
    fprintf("нет\n");
else
    fprintf("x = %s\n", strjoin(string(double(rootsOx)), ", "));
end
% Ось Oy:
valOy = subs(f(x), x, 0);
fprintf("   Пересечение с Oy: ");
if isfinite(double(valOy))
    fprintf("(0, %s)\n\n", char(valOy));
else
    fprintf("нет\n\n");
end

%% 4) Промежутки знакопостоянства (численно)
fprintf("4) Промежутки знакопостоянства (приближённо):\n");
f_numeric = matlabFunction(f);
xx = linspace(-20, 20, 10000);
yy = f_numeric(xx);
sign_change_idx = find(diff(sign(yy)));
for i = 1:length(sign_change_idx)
    idx = sign_change_idx(i);
    a = xx(idx);
    b = xx(idx+1);
    sign_val = sign(yy(idx));
    if sign_val > 0
        fprintf("  f(x) > 0 на примерно (%g; %g)\n", a, b);
    else
        fprintf("  f(x) < 0 на примерно (%g; %g)\n", a, b);
    end
end
fprintf("\n");

%% 5) Возрастание, убывание, экстремумы
fprintf("5) Интервалы монотонности и экстремумы:\n");
f1 = diff(f(x), x);
crit_pts = double(vpasolve(f1 == 0, x, [-20 20]));
crit_pts = unique(real(crit_pts(abs(imag(crit_pts)) < 1e-6)));
test_points = [-inf, crit_pts, inf];

for i = 1:length(test_points)-1
    a = test_points(i);
    b = test_points(i+1);
    mid = (a + b)/2;
    deriv_val = double(subs(f1, x, mid));
    interval_str = sprintf("(%g; %g)", a, b);
    if deriv_val > 0
        fprintf("  f возрастает на %s\n", interval_str);
    elseif deriv_val < 0
        fprintf("  f убывает на %s\n", interval_str);
    else
        fprintf("  производная ≈ 0 на %s\n", interval_str);
    end
end

if isempty(crit_pts)
    fprintf("  Экстремумы: отсутствуют\n\n");
else
    fprintf("  Экстремумы в точках x = %s\n\n", strjoin(string(crit_pts), ", "));
end

%% 6) Выпуклость, вогнутость, перегибы
fprintf("6) Выпуклость и точки перегиба:\n");
f2 = diff(f1, x);
infl_pts = double(vpasolve(f2 == 0, x, [-20, 20]));
infl_pts = unique(real(infl_pts(abs(imag(infl_pts)) < 1e-6)));
test_points2 = [-Inf, infl_pts, Inf];

for i = 1:length(test_points2)-1
    a = test_points2(i);
    b = test_points2(i+1);
    mid = (a + b)/2;
    second_val = double(subs(f2, x, mid));
    interval_str = sprintf("(%g; %g)", a, b);
    if second_val < 0
        fprintf("  f вогнута на %s\n", interval_str);
    elseif second_val > 0
        fprintf("  f выпукла на %s\n", interval_str);
    end
end

if isempty(infl_pts)
    fprintf("  Точки перегиба отсутствуют\n\n");
else
    fprintf("  Точки перегиба: x = %s\n\n", strjoin(string(infl_pts), ", "));
end

%% 7) Асимптота
fprintf("7) Наклонная асимптота:\n");
K = limit(f(x)/x, x, Inf);
B = limit(f(x) - K*x, x, Inf);
if ~(isequal(K,[]) && isequal(B,[]))
    fprintf("  y = %s*x + %s\n\n", char(K), char(B));
    hasAsymptote = true;
else
    fprintf("  Отсутствует\n\n");
    hasAsymptote = false;
end

%% 8) Построение графика
figure('Name','График функции','NumberTitle','off');
hold on; grid on;

xMin = -10; xMax = 10;
fplot(f, [xMin, xMax], 'LineWidth', 2, 'Color', 'r');

if hasAsymptote
    asymp = matlabFunction(K*x + B);
    fplot(asymp, [xMin, xMax], '--b', 'LineWidth', 1.5);
    legend('f(x)', 'Асимптота');
else
    legend('f(x)');
end

xlabel('x'); ylabel('f(x)');
title(['График f(x) = ', char(f(x))]);
hold off;
