%=== Начало скрипта для оценки эмпирической сложности ===%

% Параметры эксперимента
sizes = round(logspace(2, 4, 10));  % от 10^2 до 10^4, 10 точек
numTrials = 5;                      % повторений для каждого n

times = zeros(length(sizes),1);

for idx = 1:length(sizes)
    n = sizes(idx);
    tAccum = 0;
    
    for trial = 1:numTrials
        A = rand(1, n);  % случайный массив длины n
        tic;
        bubbleSort(A);   % ваша функция пузырьковой сортировки
        tAccum = tAccum + toc;
    end
    
    times(idx) = tAccum / numTrials;  % среднее время
    fprintf('n = %6d:  t = %.4f s\n', n, times(idx));
end

% Построим график времени в линейных координатах
figure;
plot(sizes, times, 'o-','LineWidth',1.5);
xlabel('Размер массива n');
ylabel('Среднее время, с');
title('Время работы bubbleSort');
grid on;

% Лог–лог аппроксимация T = a * n^b
logn = log(sizes(:));
logt = log(times(:));
p = polyfit(logn, logt, 1);
b = p(1);
a = exp(p(2));

fprintf('\nАппроксимация T ≈ %.3e * n^{%.2f}\n', a, b);

% Построим тот же график в лог–координатах с аппроксимацией
figure;
loglog(sizes, times, 'o','MarkerSize',8); hold on;
% линия аппроксимации
nFit = linspace(min(sizes), max(sizes), 100);
plot(nFit, a * nFit.^b, '--','LineWidth',1.5);
xlabel('n');
ylabel('T(n), с');
title(sprintf('Лог–лог: оценка T \\approx %.2e n^{%.2f}', a, b));
legend('Измерения','Аппроксимация','Location','NorthWest');
grid on;

%=== Конец скрипта ===%
