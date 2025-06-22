% 1. Задание символьных переменных
syms x;

% 2. Задание функции
f(x) = (x^2 + x)/(x^2 - x);

disp('Анализ функции:');
disp(['f(x) = ', char(f(x))]);
fprintf('\n');

% 3. Поиск области определения
[~, den] = numden(f);
domain_excl = solve(den == 0, x);
disp('3. Область определения:');
if isempty(domain_excl)
    disp('Всё множество вещественных чисел.');
else
    excl_str = join(string(domain_excl), ', ');
    disp(['Всё множество вещественных чисел, кроме x = ', excl_str]);
end
fprintf('\n');

% 4. Проверка на четность/нечетность
f_minus_x = simplify(subs(f, x, -x));
is_even = logical(f_minus_x == f);
is_odd = logical(f_minus_x == -f);

disp('4. Четность/нечетность:');
if is_even
    disp('Функция четная');
elseif is_odd
    disp('Функция нечетная');
else
    disp('Функция f(x) общего вида.');
end
fprintf('\n');

% 5. Пересечение с осями координат
disp('5. Точки пересечения с осями:');

% С осью Oy (x=0)
if ~ismember(sym(0), domain_excl)
    y_intercept = f(-1);
    disp(['С осью Oy: (1, ', num2str(double(y_intercept)), ')']);
else
    disp('отсутствуют.');
end

% С осью Ox (y=0)
x_intercepts = solve(f == 0, x, 'Real', true);
if ~isempty(x_intercepts)
    disp('С осью Ox:');
    for i = 1:length(x_intercepts)
        xi = x_intercepts(i);
        disp(['(', num2str(double(xi)), ', 0)']);
    end
else
    disp('отсутствуют.');
end
fprintf('\n');

% 6. Промежутки знакопостоянства
disp('6. Промежутки знакопостоянства:');
pos_intervals = solve(f > 0, x, 'Real', true, 'ReturnConditions', true);
neg_intervals = solve(f < 0, x, 'Real', true, 'ReturnConditions', true);

% Форматирование вывода
if ~isempty(pos_intervals.conditions)
    disp('f(x) > 0 при:');
    disp_conditions(pos_intervals);
else
    disp('Нет интервалов с положительными значениями');
end

if ~isempty(neg_intervals.conditions)
    disp('f(x) < 0 при:');
    disp_conditions(neg_intervals);
else
    disp('Нет интервалов с отрицательными значениями');
end
fprintf('\n');

% 7. Анализ первой производной
f1 = diff(f, x);
disp('7. Анализ монотонности:');
disp(['Первая производная: f''(x) = ', char(simplify(f1))]);

% Критические точки
crit_points = solve(f1 == 0, x, 'Real', true);

% Определение интервалов возрастания/убывания
[inc, dec] = find_monotony(f1, domain_excl, x);

% Вывод интервалов
disp('Функция возрастает при:');
if ~isempty(inc)
    disp(strjoin(inc, ' и '));
else
    disp('отсутствует');
end

disp('Функция убывает при:');
if ~isempty(dec)
    disp(strjoin(dec, ' и '));
else
    disp('отсутствует');
end

% Поиск экстремумов
disp('Экстремумы:');
if ~isempty(crit_points)
    for i = 1:length(crit_points)
        pt = crit_points(i);
        pt_val = double(pt);
        f2_val = double(subs(diff(f1, x), x, pt_val));
        if f2_val > 0
            type = 'минимум';
        elseif f2_val < 0
            type = 'максимум';
        else
            type = 'экстремум (требует дополнительного анализа)';
        end
        y_val = double(subs(f, x, pt_val));
        disp([type, ' в точке (', num2str(pt_val), ', ', num2str(y_val), ')']);
    end
else
    disp('отсутствуют');
end
fprintf('\n');

% 8. Анализ второй производной
f2 = diff(f, x, 2);
disp('8. Анализ выпуклости:');
disp(['Вторая производная: f''''(x) = ', char(simplify(f2))]);

% Поиск интервалов выпуклости
conv_up = solve(f2 > 0, x, 'Real', true, 'ReturnConditions', true);
conv_down = solve(f2 < 0, x, 'Real', true, 'ReturnConditions', true);

% Форматирование вывода
disp('Функция выпукла вверх (вогнута) при:');
if ~isempty(conv_up.conditions)
    disp_conditions(conv_up);
else
    disp('отсутствуют интервалы');
end

disp('Функция выпукла вниз (выпукла) при:');
if ~isempty(conv_down.conditions)
    disp_conditions(conv_down);
else
    disp('отсутствуют интервалы');
end

% Поиск точек перегиба
inflection_points = solve(f2 == 0, x, 'Real', true);

disp('Точки перегиба:');
if ~isempty(inflection_points)
    for i = 1:length(inflection_points)
        pt = inflection_points(i);
        pt_val = double(pt);
        if ~ismember(pt_val, double(domain_excl))
            y_val = double(subs(f, x, pt_val));
            disp(['(', num2str(pt_val), ', ', num2str(y_val), ')']);
        end
    end
else
    disp('отсутствуют');
end
fprintf('\n');

% 9. Поиск наклонной асимптоты
disp('9. Наклонные асимптоты:');
[asymptote_exists, asymptote_eq] = find_asymptote(f, x);

if asymptote_exists
    disp(['g(x) = ', asymptote_eq]);
else
    disp('Наклонные асимптоты отсутствуют');
end
fprintf('\n');

% 10. Построение графика
figure;
hold on;
axis equal
fplot(f, 'LineWidth', 2);
plot_vertical_asymptotes(domain_excl);
if asymptote_exists
    fplot(str2sym(asymptote_eq), '--r', 'LineWidth', 1.5);
end
title(['График функции f(x) = ', char(f(x))]);
xlabel('x'); ylabel('f(x)');
grid on; box on;
legend('f(x)', 'Асимптоты', 'Location', 'Best');
hold off;

% Вспомогательные функции
function disp_conditions(sol)
    if isempty(sol.conditions)
        return;
    end
    
    if islogical(sol.conditions) && sol.conditions
        if isfield(sol, 'interval')
            intervals = sol.interval;
            for j = 1:size(intervals, 1)
                left = intervals(j,1);
                right = intervals(j,2);
                if isinf(left) && isinf(right)
                    disp('все x');
                elseif isinf(left)
                    disp(['x < ', char(vpa(right, 3))]);
                elseif isinf(right)
                    disp(['x > ', char(vpa(left, 3))]);
                else
                    disp([char(vpa(left, 3)), ' < x < ', char(vpa(right, 3))]);
                end
            end
        else
            disp('все x');
        end
    else
        disp(char(sol.conditions));
    end
end

function [inc, dec] = find_monotony(f1, excl_points, x)
    % Поиск интервалов монотонности
    crit_points = solve(f1 == 0, x, 'Real', true);
    all_points = [crit_points; excl_points];
    
    % Фильтрация действительных точек
    real_indices = imag(all_points) == 0;
    all_points = all_points(real_indices);
    all_points = double(unique(all_points)); % Конвертируем в double
    
    inc = {};
    dec = {};
    
    if isempty(all_points)
        test_point = 0;
        if double(subs(f1, x, test_point)) > 0
            inc = {'все x'};
        else
            dec = {'все x'};
        end
        return;
    end
    
    % Формируем интервалы для анализа
    intervals = [-inf, all_points', inf];
    
    for i = 1:length(intervals)-1
        a = intervals(i);
        b = intervals(i+1);
        
        if a == b
            continue;
        end
        
        % Выбор тестовой точки
        if isinf(a) && isinf(b)
            test_point = 0;
        elseif isinf(a)
            test_point = b - 1;
        elseif isinf(b)
            test_point = a + 1;
        else
            test_point = (a + b)/2;
        end
        
        sign_val = sign(double(subs(f1, x, test_point)));
        
        % Форматирование интервала
        if isinf(a) && isinf(b)
            interval_str = 'все x';
        elseif isinf(a)
            interval_str = ['x < ', num2str(b)];
        elseif isinf(b)
            interval_str = ['x > ', num2str(a)];
        else
            interval_str = [num2str(a), ' < x < ', num2str(b)];
        end
        
        if sign_val > 0
            inc{end+1} = interval_str;
        elseif sign_val < 0
            dec{end+1} = interval_str;
        end
    end
end

function [exists, eq] = find_asymptote(f, x)
    % Поиск наклонных асимптот
    k_plus = limit(f/x, x, inf);
    b_plus = limit(f - k_plus*x, x, inf);
    
    k_minus = limit(f/x, x, -inf);
    b_minus = limit(f - k_minus*x, x, -inf);
    
    tol = 1e-6;
    if abs(k_plus - k_minus) < tol && abs(b_plus - b_minus) < tol
        asymptote = k_plus*x + b_plus;
        exists = true;
        eq = char(asymptote);
    else
        exists = false;
        eq = '';
    end
end

function plot_vertical_asymptotes(excl_points)
    % Построение вертикальных асимптот
    y_lim = ylim;
    for i = 1:length(excl_points)
        pt = excl_points(i);
        if imag(pt) == 0
            x_val = double(pt);
            line([x_val, x_val], y_lim, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 1.5);
        end
    end
end