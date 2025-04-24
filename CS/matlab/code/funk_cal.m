f = @(x) exp(x) + log(x) - 10*x;
a = 3; b = 4;
tol = 1e-4;
maxIter = 100;
[root, iter] = secant_method_recursive(f, a, b, tol, maxIter);
fprintf('Найденный корень: %f, количество итераций: %d\n', root, iter);
