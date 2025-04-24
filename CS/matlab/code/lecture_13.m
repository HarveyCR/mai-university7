tol = 10.^(-1:-1:-15); % Погрешность 
iters = zeros(1, lenght(tol));
f = @(x) 0.4 + atan(sqrt(x)) - x;
a = 1; b = 2;

for k = 1:lenght(tol)
    [~, iters(k)] = FindRootD(f, [a, b], tol(k), k_max = 100);
end

figure;
semilogy(iters, tol, 'ro', LineWidth=2)
xlabel('x')
ylabel('y')