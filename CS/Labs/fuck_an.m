%% analyze_function.m
% Универсальный анализ символьной функции в MATLAB

clc; clearvars; close all;
syms x real
syms f(x)

%% === Задайте вашу функцию здесь ===
f(x) = (2*x^2 - 4*x + 7)/(x + 3);   % пример
% f(x) = log(x^2 - 1);
% f(x) = sin(x)/x;
% ================================

fprintf("Анализ функции f(x) = %s\n\n", char(f(x)));

%% 1) Область определения
[Num, Den] = numden(f(x));
all_sing = solve(Den == 0, x);
sing = unique(double(all_sing(imag(all_sing)==0)));
fprintf("1) Область определения: ");
if isempty(sing)
    fprintf("R\n\n");
else
    fprintf("R \\ { %s }\n\n", strjoin(string(sing), ", "));
end

%% 2) Чётность / нечётность (численно)
fprintf("2) Чётность/нечётность: ");
pts = linspace(-5,5,11);
pts = pts(~ismembertol(pts, sing, 1e-3));  % исключаем окрестности разрывов
val_e = arrayfun(@(xi) double(f(xi) - f(-xi)), pts);
val_o = arrayfun(@(xi) double(f(xi) + f(-xi)), pts);
tol = 1e-6;
if all(abs(val_e) < tol)
    fprintf("чётная\n\n");
elseif all(abs(val_o) < tol)
    fprintf("нечётная\n\n");
else
    fprintf("общего вида\n\n");
end

%% 3) Пересечения с осями
rootsOx = unique(double(vpasolve(f(x)==0, x, [-100,100])));
rootsOx = rootsOx(isfinite(rootsOx) & imag(rootsOx)==0);
fprintf("3) Пересечения с Ox: ");
if isempty(rootsOx)
    fprintf("нет\n");
else
    fprintf("x = %s\n", strjoin(string(rootsOx), ", "));
end
valOy = subs(f(x), x, 0);
fprintf("   Пересечение с Oy: ");
if isfinite(double(valOy))
    fprintf("(0, %s)\n\n", char(valOy));
else
    fprintf("нет\n\n");
end

%% 4) Промежутки знакопостоянства (численно)
fprintf("4) Промежутки знакопостоянства (приближённо):\n");
f_num = matlabFunction(f);
xx = linspace(-20,20,20000);
yy = f_num(xx);
valid = isfinite(yy);
xx = xx(valid); yy = yy(valid);
sgn = sign(yy);
chg = find(diff(sgn)~=0);
for k = chg
    a = xx(k); b = xx(k+1);
    if sgn(k)>0
        fprintf("  f>0 примерно на (%g; %g)\n", a, b);
    else
        fprintf("  f<0 примерно на (%g; %g)\n", a, b);
    end
end
fprintf("\n");

%% 5) Интервалы монотонности и экстремумы
fprintf("5) Интервалы монотонности и экстремумы:\n");
f1 = diff(f(x), x);
crit = unique(double(vpasolve(f1==0, x, [-20,20])));
crit = crit(isfinite(crit) & imag(crit)==0).';
% Объединяем с точками разрыва
cuts = sort([ -Inf, sing.', crit, Inf ]);
for i = 1:length(cuts)-1
    a = cuts(i); b = cuts(i+1);
    % выбираем серединную точку для проверки
    if isfinite(a) && isfinite(b)
        mid = (a + b)/2;
    elseif isfinite(a)
        mid = a + 1;
    elseif isfinite(b)
        mid = b - 1;
    else
        continue
    end
    % если середина настолько близко к разрыву — мимо
    if any(abs(mid - sing) < 1e-3)
        continue
    end
    dval = double(subs(f1, x, mid));
    interval = sprintf("(%g; %g)", a, b);
    if dval > 0
        fprintf("  f возрастает на %s\n", interval);
    elseif dval < 0
        fprintf("  f убывает на %s\n", interval);
    else
        fprintf("  производная ≈0 на %s\n", interval);
    end
end
if isempty(crit)
    fprintf("  Экстремумы отсутствуют\n\n");
else
    fprintf("  Критические точки: x = %s\n\n", strjoin(string(crit), ", "));
end

%% 6) Выпуклость/вогнутость и точки перегиба
fprintf("6) Выпуклость, вогнутость и точки перегиба:\n");
f2 = diff(f1, x);
infl = unique(double(vpasolve(f2==0, x, [-20,20])));
infl = infl(isfinite(infl) & imag(infl)==0).';
cuts2 = sort([ -Inf, infl, Inf ]);
for i = 1:length(cuts2)-1
    a = cuts2(i); b = cuts2(i+1);
    if isfinite(a) && isfinite(b)
        mid = (a + b)/2;
    elseif isfinite(a)
        mid = a + 1;
    else
        mid = b - 1;
    end
    secv = double(subs(f2, x, mid));
    interval = sprintf("(%g; %g)", a, b);
    if secv < 0
        fprintf("  f вогнута на %s\n", interval);
    elseif secv > 0
        fprintf("  f выпукла на %s\n", interval);
    end
end
if isempty(infl)
    fprintf("  Точек перегиба нет\n\n");
else
    fprintf("  Точки перегиба: x = %s\n\n", strjoin(string(infl), ", "));
end

%% 7) Наклонная асимптота
fprintf("7) Наклонная асимптота:\n");
K = limit(f(x)/x, x, Inf);
B = limit(f(x) - K*x, x, Inf);
if ~(isempty(K) || isempty(B))
    fprintf("  y = %s*x + %s\n\n", char(K), char(B));
    hasA = true;
else
    fprintf("  нет\n\n");
    hasA = false;
end

%% 8) Построение графика
figure('Name','График f(x)','NumberTitle','off');
hold on; grid on;
fplot(f,[-10,10],'r','LineWidth',2);
if hasA
    asym = matlabFunction(K*x + B);
    fplot(asym,[-10,10],'--b','LineWidth',1.5);
    legend('f(x)','Асимптота','Location','best');
else
    legend('f(x)','Location','best');
end
xlabel('x'); ylabel('f(x)');
title(['f(x) = ', char(f(x))]);
hold off;
