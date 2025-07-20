function falling_time(H)
    t = sqrt(2 * H / 9.81)' * ones(1, 10);
    infelicity = 0.8 + (1.1 - 0.8) * rand(5, 10);
    infelicity_time = round(infelicity .* t, 3);
    result = [ repelem(H', 10, 1), infelicity_time(:) ];
    writematrix(result, 'falling_ball.xlsx');
end
