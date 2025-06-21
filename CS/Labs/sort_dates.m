% Параметры
sizes    = [1000, 2000, 3000, 4000, 5000, 6000, 7000];
maxValue = 10000;
nSizes   = numel(sizes);
nRuns    = 1;  % число генерируемых векторов на каждый размер

% Список тестируемых функций и их имёна
funcs = {
    @sort_bubble,           'Bubble Sort';
    @sort_simple_selec, 'Selection Sort';
    @sort_int,        'Insertion Sort';
    @sort_heap,              'Sort Heap';
    @sort_quick,            'Sort Quick';
    @sort_merge,             'Sort Merge'
};
nAlgos = size(funcs,1);

%% Шаг 1: Генерация всех случайных списков заранее
% Будем хранить их в cell‑массиве lists{si, run}
lists = cell(nSizes, nRuns);
for si = 1:nSizes
    N = sizes(si);
    for run = 1:nRuns
        lists{si,run} = randi(maxValue, 1, N);
    end
end

%% Шаг 2: Замер времени для каждой функции на тех же самых списках
sum_times = zeros(nAlgos, nSizes);

for ai = 1:nAlgos
    fHandle = funcs{ai,1};
    fName   = funcs{ai,2};
    fprintf('\n=== Тестирование %s ===\n', fName);
    
    for si = 1:nSizes
        times = zeros(1, nRuns);
        
        for run = 1:nRuns
            A = lists{si,run};  % повторно используем заранее сгенерированный вектор
            tic;
            fHandle(A);
            times(run) = toc;
        end
        
        sum_times (ai,si) = sum(times);
        fprintf('%-15s | N=%5d : Суммарное время = %.6f сек\n', ...
                fName, sizes(si), sum_times (ai,si));
    end
end

%% Шаг 3: Итоговая таблица (опционально)
fprintf('\nСводная таблица суммарного времён (строки — алгоритмы):\n');
disp(array2table(sum_times , ...
    'VariableNames', strcat('N', string(sizes)), ...
    'RowNames', funcs(:,2)));

%% Шаг 4: Построение графика
figure;
hold on;
markers = {'-o','-s','-^','-d','-v','-p'};
for ai = 1:nAlgos
    plot(sizes, sum_times (ai,:), markers{ai}, 'LineWidth', 1.5);
end
hold off;

xlabel('Размер массива, N');
ylabel('Суммарное время выполнения (сек)');
title('Сравнение алгоритмов сортировки');
legend(funcs(:,2), 'Location', 'northwest');
grid on;
