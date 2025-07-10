prompt = {'Начальная скорость (м/с):', 'Угол броска (градусы):'};
answer = inputdlg(prompt, 'Параметры броска', 1, {'20', '45'});
v = str2double(answer{1});
a = str2double(answer{2});
[x_no, y_no, x_drag, y_drag, t, maxH, range_no, range_drag] = ball_flight2(v, a);

% === Рисуем оси и статичные линии траекторий ===
figure('Name','Анимация полёта мяча','Color',[1 1 1]); hold on; grid on;
xlabel('Горизонтальное смещение, м');
ylabel('Высота, м');
title('Анимация полёта мяча: без сопротивления (синий) и с сопротивлением (красный)');
axis equal;

% жёстко фиксируем границы
xmax = max(range_no, range_drag)*1.1;
ymax = maxH*1.1;
axis([0 xmax 0 ymax],'manual');

% рисуем траектории
plot(x_no,   y_no,   'b-',  'LineWidth', 1);
plot(x_drag, y_drag, 'r--', 'LineWidth', 1);

% === Создаём маркеры в стартовых точках ===
hBall_no   = plot(x_no(1),   y_no(1),   'bo', 'MarkerFaceColor','b', 'MarkerSize',8);
hBall_drag = plot(x_drag(1), y_drag(1), 'ro', 'MarkerFaceColor','r', 'MarkerSize',8);

% === Анимационный цикл ===
nFrames = numel(x_no);  % число точек в траектории без сопротивления
for k = 1:nFrames
    % обновляем только положение шариков
    set(hBall_no,   'XData', x_no(k),   'YData', y_no(k));
    set(hBall_drag, 'XData', x_drag(k), 'YData', y_drag(k));
    
    drawnow;           % сразу отобразить кадр
    pause(0.01);       % регулировка скорости
end