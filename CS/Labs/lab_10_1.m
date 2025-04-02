function S = sum_series_recursive_local(x, tol)
% Рекурсивное вычисление суммы ряда с использованием локальной функции
if nargin < 2, tol = 1e-4; end
S = rec_sum(0, x^(0)/4^(1), x, tol);
end

function S = rec_sum(k, a_k, x, tol)
    if abs(a_k) < tol
        S = a_k;
    else
        coeff = calc_coeff(x);
        a_next = a_k * coeff;
        S = a_k + rec_sum(k+1, a_next, x, tol);
    end
end

function c = calc_coeff(x)
    c = x^2/4;
end

%% Пример вызова рекурсивной функции с вложенной функцией
x = 0.5;         % значение x
tol = 1e-4;      % допустимая погрешность

S_nested = sum_series_recursive_local(x, tol);
fprintf('Рекурсивная сумма (вложенная функция) для x = %.2f: %.6f\n', x, S_nested);
