function [x, y, vremia, max_visota, dlina_poleta] = polet_mecha(nach_skorost, ugol)

    vremia = 2 * nach_skorost * sin(deg2rad(ugol)) / 9.81;
    max_visota = nach_skorost ^2 * sin(deg2rad(ugol)) ^2 / (2 * 9.81);
    dlina_poleta = nach_skorost ^ 2 * sin(deg2rad(2 * ugol)) / 9.81;

    t = linspace(0, vremia, 100);
    
    x = nach_skorost * cos(deg2rad(ugol)) * t;
    y = nach_skorost * sin(deg2rad(ugol)) .* t - 0.5 * 9.81 * t.^2;
    
    figure;
    plot(x, y, 'LineWidth', 2);
    title('Траектория полёта');
    xlabel('Горизонтальное смещение, м');
    ylabel('Высота, м');
    grid on;
end