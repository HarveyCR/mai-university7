function [max_value, min_value, mean_value, k_best] = falling_ball_grath()
    data = sortrows(readmatrix('falling_ball.xlsx'), 2);
    
    max_value = data(end, 2);      
    min_value = data(1, 2);      
    mean_value = mean(data(:, 2));

    H = data(:,1);
    t_exp = data(:,2);
    
    k_vals = 0.5:0.001:2;
    
    SSE = zeros(size(k_vals));
    
    g = 9.81;
    for i = 1:length(k_vals)
    k = k_vals(i);
    t_pred = k .* ( sqrt(2 .* H ./ g) .* H );  % ваша модель
    SSE(i) = sum( (t_exp - t_pred).^2 );
    end
    
    [~, idx_min] = min(SSE);
    k_best = k_vals(idx_min);
    
    t_best = k_best .* ( sqrt(2 .* H ./ g) .* H );
    
    figure;
    hold on;
    scatter(H, t_exp, 'filled');
    [H_sorted, sortIdx] = sort(H);
    plot(H_sorted, t_best(sortIdx), 'LineWidth', 2);
    hold off;
    grid on;
    xlabel('H');
    ylabel('t');
    legend('Эксперимент', sprintf('Модель t = k H \\sqrt{2H/g}, k=%.3f', k_best));
    title('Подбор k методом наименьших квадратов перебором');

end