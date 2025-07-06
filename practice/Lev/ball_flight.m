function [x, y, time, maximum_height, flight_range] = ball_flight(initial_speed, angle)

    g = 9.81;
    time = 2 * initial_speed * sin(deg2rad(angle)) / g;
    maximum_height = initial_speed ^2 * sin(deg2rad(angle)) ^2 / (2 * g);
    flight_range = initial_speed ^ 2 * sin(deg2rad(2 * angle)) / g;

    t = linspace(0, time, 100);
    
    x = initial_speed * cos(deg2rad(angle)) * t;
    y = initial_speed * sin(deg2rad(angle)) .* t - 0.5 * g * t.^2;
    
    figure;
    plot(x, y, 'LineWidth', 2);
    title('Траектория полёта');
    xlabel('Горизонтальное смещение, м');
    ylabel('Высота, м');
    grid on;
end