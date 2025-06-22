% 1. Очистка экрана и задание формата отображения выражений
clc
% 2. Задание символьных переменных
syms x real
syms f real

% 3. Задание функции
fprintf('1. Исследуемая функция.\nf(x)=\n ');
f(x) = (x^2 - x)/(x^2 + x);
pretty(f(x))

% 4. Поиск области определения функции f(x)
fprintf(1,"\n2. Область определения функции f(x).");
 N = (x^2 - x);
 D = (x^2 + x);
 Roots = solve(D==0,x);
 fprintf(1,"\nВсё множество вещественных чисел");
if isempty(Roots)
  fprintf(1,".\n");
else
  fprintf(1," за исключением следующих значений: \n");
  disp(Roots');
end

% 5. Определение чётности или нечётности функции
fprintf(1,"\n3. Вид функции.\nФункция f(x) ");
evenFun = @(f, x) isequal(f(x), f(-x));
oddFun = @(f, x) isequal(f(-x), -f(x));

if evenFun(f, x)
    fprintf(1, "чётная.\n");
elseif oddFun(f, x)
    fprintf(1, "нечётная.\n");
else
    fprintf(1, "общего вида.\n");
end

%6. Поиск пересечения точек графика функции с осями Ох и Oy
fprintf(1,"\n4. Точки пересечения.\n");
Roots = solve(f(x),x);
fprintf(1,"C осью Ох ");
if ~isempty(Roots), pretty(Roots);
else fprintf(1,"отсутствуют.\n");
end

fprintf(1,"C осью Оy ");
if any(0, Roots) 
    F0 = f(0);
    if isfinite(F0), pretty(F0);
    else fprintf(1,"отсутствует.\n");
    end
else fprintf(1,"отсутствует.\n");
end
% 7. Поиск промежутков знакопостоянства
isNumAlwaysPos = isAlways(N > 0);

% Используем solveset для получения множеств решений неравенств
% Решаем для f(x) > 0 и f(x) < 0
PosIntervals = solve(N/D > 0,  x,'ReturnConditions', true);
NegIntervals = solve(N/D < 0, x,'ReturnConditions', true);

% Вывод результатов
if ~isempty(PosIntervals)
    fprintf('Значение функции f(x) положительно на множестве:\n');
    disp(PosIntervals.conditions)
end
if ~isempty(NegIntervals)
    fprintf('Значение функции f(x) отрицательно на множестве:\n');
    disp(NegIntervals.conditions)
end

%8. Поиск интервалов, на которых функция возрастает и убывает,
% а также экстремумов функции
 fprintf("\n6. Первая производная функции f'(x)=\n");
 FirstDerivative = simplify(diff(f(x),x));
 pretty(FirstDerivative);
 fprintf("\n6.1. Промежутки возрастания функции.\n");
 UpValInterval = solve(FirstDerivative > 0, x,'ReturnConditions', true);
 if UpValInterval == sym("false")
  disp("Отсутствуют.");
 else
  pretty(UpValInterval.conditions);
 end
 fprintf("\n6.2. Промежутки убывания функции.");
 DownValInterval = solve(FirstDerivative < 0, x,'ReturnConditions', true);
 if DownValInterval == sym("false")
  disp("Отсутствуют.");
 else
  pretty(DownValInterval.conditions);
 end
 fprintf("\n6.3. Экстремумы функции.");
 Extrema = solve(FirstDerivative == 0,x);
 if isempty(Extrema)
  fprintf("Отсутствуют.");
 else
  pretty(Extrema);
 end

%9. Поиск промежутков выпуклости и вогнутости,    
%нахождение точек перегиба
 fprintf("\n7. Вторая производная функции f''(x)=\n");
 SecondDerivative = simplify(diff(f(x),x,2));
 pretty(SecondDerivative);
 fprintf("\n7.1. Промежутки выпуклости функции.\n");
 UpCurveInterval = solve(SecondDerivative < 0,x, 'ReturnConditions', true);
 if UpCurveInterval == sym("false")
  disp("Отсутствуют.");
 else
  pretty(UpCurveInterval.conditions);
 end
 fprintf("\n7.2. Промежутки вогнутости функции.\n");
 DownCurveInterval = solve(SecondDerivative > 0, x, 'ReturnConditions', true);
 if DownCurveInterval == sym("false")
  disp("Отсутствуют.");
 else
  pretty(DownCurveInterval.conditions);
 end
 fprintf("\n7.3. Точки перегиба функции.\n");
 Point = solve(SecondDerivative == 0,x);
 if isempty(Point)
  disp("Отсутствуют.");
else
  pretty(Point);
 end

%10. Поиск наклонной асимптоты
fprintf("\n8. Асимптота к графику функции f(x).\n");

% Compute oblique asymptote parameters
K = limit(simplify(f(x)/x), x, inf);
B = limit(simplify(f(x) - K*x), x, inf);

% Check existence and build symbolic asymptote
if ~isempty(K) && ~isempty(B)
    Asymptote = K*x + B;
    fprintf('Asymptote: y = ');
    pretty(Asymptote);
else
    warning('No oblique asymptote exists.');
    Asymptote = [];
end


%11. Построение графика функции f(x)
Hf = ezplot(f(x));
 set(Hf,"LineWidth",3,"Color","Red");
 XLim = get(gca,"xlim");
 YLim = get(gca,"ylim");
 grid on, hold on
HA = ezplot(Asymptote);
    set(HA,"LineWidth",2,"Color","Blue","LineStyle","--");
    axis([XLim(1) XLim(2) YLim(1) YLim(2)])