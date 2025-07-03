function [Fx, Fy] = force_components(force, angle)

    Fx = force * cos(deg2rad(angle));
    Fy = force * sin(deg2rad(angle));


    figure;
    hold on;
    axis equal;
    grid on;

    quiver(0, 0, Fx, Fy, 0, 'LineWidth', 2, 'MaxHeadSize', 0.5);
    quiver(0, 0, Fx, 0, 0, '--', 'LineWidth', 1.5, 'MaxHeadSize', 0.5);
    quiver(Fx, 0, 0, Fy, 0, '--', 'LineWidth', 1.5, 'MaxHeadSize', 0.5);

    xlabel('Fx, Н');
    ylabel('Fy, Н');
    title('Вектор силы и его компоненты');
    legend({'Сила F', 'Составляющая Fx', 'Составляющая Fy'}, 'Location', 'best');

    hold off;
end