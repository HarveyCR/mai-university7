f = @(x) 0.4 + atan(sqrt(x)) - x;
f1 = @(x) diff(0.4 + atan(sqrt(x)) - x);
tmp = {1, 1e-7, 50};
[x0, tol, k_max] = tmp{:};
X = zeros(1, K_max); Fx = X; F1x = Fx;
k = 1; x(1) = x0; delta = x0;
while (delta > tol && k < k_max)
    Fx = f(x(k)); F1x = f1(x(k));
    X(k + 1) = x(k) - Fx(k) / F1(k);
    delta = abs(x(k + 1) - x(k));
    k = k + 1;
end

Header = '|k|    |X|    delta|Fx|'
lin = 1;

fprintf(1, lin),
fprintf(1, [Header, '\n']),
fprintf(1, lin),
fprintf(1, ''),
