function [x_no, y_no, x_drag, y_drag, time, maxH, range_no, range_drag] = ball_flight2(initial_speed, angle)
    % Параметры
    g  = 9.81;       % ускорение свободного падения, м/с^2
    mu = 0.1;        % коэффициент сопротивления
    
    % Время полёта без сопротивления
    alpha = deg2rad(angle);
    time = 2 * initial_speed * sin(alpha) / g;
    
    % Максимальная высота и дальность без сопротивления
    maxH     = (initial_speed^2 * sin(alpha)^2) / (2 * g);
    range_no = (initial_speed^2 * sin(2*alpha)) / g;
    
    % Время для построения траектории
    t = linspace(0, time, 200);
    
    % Траектория без сопротивления
    x_no = initial_speed * cos(alpha) .* t;
    y_no = initial_speed * sin(alpha) .* t - 0.5 * g * t.^2;
    
    % Дальность полёта с сопротивлением (анализ на бесконечном времени)
    range_drag = (initial_speed * cos(alpha) / mu) * (1 - exp(-mu * time));
    
    % Траектория с сопротивлением
    x_drag = (initial_speed * cos(alpha) / mu) * (1 - exp(-mu * t));
    y_drag = initial_speed * sin(alpha) .* t - 0.5 * g * t.^2;
    
    % (не рисуем внутри функции, чтобы оставить всю графику в скрипте)
end