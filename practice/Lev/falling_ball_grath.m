function [max_value, min_value, mean_value, k_best] = falling_ball_grath()
    mx = readmatrix('falling_ball.xlsx');
    H = mx(:, 1);
    times = mx(:, 2:end);
    times = sortrows(times')';   
    mx2 = [H times];
    writematrix(mx2, 'falling_ball_s.xlsx');

    max_value = times(:, end);
    min_value = times(:, 1);
    mean_value = mean(times, 2);
    mx_stats = [min_value mean(times, 2) max_value];
    
    mx2 = readmatrix('falling_ball_s.xlsx');  
    H = mx2(:,1);
    times = mx2(:,2:end);
    mean_t = mean(times, 2);                 
    
    k_vals = 0.5:0.001:2;
    
    SSE = zeros(size(k_vals));
    
    g = 9.81;
    for i = 1:length(k_vals)
        k = k_vals(i);
        t_pred = k .* ( sqrt(2 .* H ./ g));  % ваша модель
        SSE(i) = sum( (times - t_pred).^2, "all" );
    end
    [~, idx_min] = min(SSE);
    k_best = k_vals(idx_min);

    
    % Строим график
    figure; hold on; grid on;
    axis([H(1, 1) *0.9 H(end, end)*1.1 times(1, 1)*0.9 times(end, end)*1.1])
    scatter(H, times, 'filled', "green", 'o');
    scatter(H, mx_stats, 'filled', "black", 'd');
    H_smooth = linspace(min(H), max(H), 200);
    t_fit = k_best * sqrt(2*H_smooth ./ g);
    plot(H_smooth, t_fit, 'b-', 'LineWidth',1.5, 'DisplayName',sprintf('Модель t, k=%.3f', k_best));    

    xlabel('Высота H, м');
    ylabel('Время падения t, с');
    title('Высота vs Время');
end