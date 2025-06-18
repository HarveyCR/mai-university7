% fourier_symbolic_numeric.m
% Ряд Фурье кусочно‑линейной функции:
% символьный расчёт a_k, но численная сборка S_N без arrayfun

clear; close all; clc;
%% Параметры
syms x k real
L    = sym(pi);        % полупериод
T    = 2*L;            % полный период
Nmax = 20;             % макс. число гармоник
Nplt = [1,3,5,10];     % какие S_N рисовать
nx   = 400;            % точек по x для графиков
xnum = linspace(-double(L), double(L), nx)';

%% 1) Символьное задание f(x) и числовая функция
f_sym = heaviside(x)*(x/L);
f_fun = @(xx) (xx>=0).*(xx./double(L));

%% 2) Символьные коэффициенты c помощью ручной разбивки
a0_sym  = (1/L)*( int(0,      x, -L, 0) + int(x/L,   x, 0, L) );
a_k_sym = (1/L)*( int(0*cos(k*pi*x/L), x, -L, 0) + int((x/L)*cos(k*pi*x/L), x, 0, L) );
b_k_sym = (1/L)*( int(0*sin(k*pi*x/L), x, -L, 0) + int((x/L)*sin(k*pi*x/L), x, 0, L) );

a0_sym  = simplify(a0_sym);
a_k_sym = simplify(a_k_sym);
b_k_sym = simplify(b_k_sym);

% Превращаем символические формулы a_k, b_k в числовые функции от k
a_fun = matlabFunction(a_k_sym, 'Vars', k);
b_fun = matlabFunction(b_k_sym, 'Vars', k);
a0    = double(a0_sym);

%% 3) Векторная сборка частичных сумм S_N(x)
% Предзаведём матрицу: каждый столбец — S_N для N=1..Nmax
S = zeros(nx, Nmax);
for N = 1:Nmax
    % начинаем с a0/2
    SN = a0/2 * ones(nx,1);
    % прибавляем по гармоникам
    for m = 1:N
        ak = a_fun(m);
        bk = b_fun(m);
        SN = SN + ak * cos(m*pi*xnum/ double(L)) ...
                + bk * sin(m*pi*xnum/ double(L));
    end
    S(:,N) = SN;
end

%% 4) Рисуем исходную f и выбранные S_N
figure('Name','Частичные суммы ряда Фурье','NumberTitle','off'); hold on;
plot(xnum, f_fun(xnum), 'k-', 'LineWidth',1.5);
colors = lines(length(Nplt));
for idx = 1:length(Nplt)
    N = Nplt(idx);
    plot(xnum, S(:,N), 'LineWidth',1.2, 'Color', colors(idx,:));
end
legend(['f(x)', arrayfun(@(n) sprintf('S_{%d}',n), Nplt,'Uni',0)]);
xlabel('x'); ylabel('f(x) и S_N(x)');
title('Частичные суммы ряда Фурье');
grid on;

%% 5) Среднеквадратическое отклонение σ_N
sigma = zeros(1,Nmax);
for N = 1:Nmax
    err = f_fun(xnum) - S(:,N);
    sigma(N) = sqrt( (1/double(T)) * trapz(xnum, err.^2) );
end

figure('Name','Сходимость в среднем квадратическом смысле','NumberTitle','off');
plot(1:Nmax, sigma, 'LineWidth',1.5);
xlabel('N (число гармоник)'); ylabel('\sigma_N');
title('Среднеквадратическое отклонение');
grid on;
