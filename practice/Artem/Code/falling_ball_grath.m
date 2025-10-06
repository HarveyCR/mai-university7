function [max_value, min_value, mean_value, k_best] = falling_ball_grath()

    T = readtable('falling_ball.xlsx', 'ReadVariableNames', false);
    T.Properties.VariableNames = {'Height', 'Time'};
    
    T = sortrows(T, 'Height');
    
    stats = groupsummary(T, 'Height', {'min','mean','max'}, 'Time');
    
    stats.Properties.VariableNames{'min_Time'} = 'MinTime';
    stats.Properties.VariableNames{'mean_Time'} = 'MeanTime';
    stats.Properties.VariableNames{'max_Time'} = 'MaxTime';
    
    min_value  = stats.MinTime;
    mean_value = stats.MeanTime;
    max_value  = stats.MaxTime; 
    disp(stats);

    M = readmatrix('falling_ball.xlsx');
    H = M(:,1);
    T = M(:,2);

    k_vals = 0.1 : 0.001 : 1.0;

    SSE = zeros(size(k_vals));
    
    for i = 1:length(k_vals)
        k = k_vals(i);
        T_model = k * sqrt(H);              
        residuals = T - T_model;            
        SSE(i) = sum(residuals .^ 2);       
    end
    
    [~, idx_min] = min(SSE);
    k_best = k_vals(idx_min);
    SSE_best = SSE(idx_min);
    
    fprintf('Лучший k = %.4f (минимальная SSE = %.5f)\n', k_best, SSE_best);

    
    figure; 
    scatter(H, T, 50, 'filled');
    xlabel('Высота, м');
    ylabel('Время падения, с');
    title('Все измерения: высота vs время');
    grid on;
    
    hold on;
    H_model = linspace(min(H), max(H), 100);
    T_model = sqrt(2 * H_model / 9.81);
    plot(H_model, T_model, 'r--', 'LineWidth', 1.5);
    legend('Эксперименты','Теория t = k*\surd(H)','Location','best');
    hold off;
    
end
