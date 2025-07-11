function falling_time(H)
    t = sqrt(2 * H / 9.81)' * ones(1, 10);
    infelicity = 0.8 + (1.1 - 0.8) * rand(4, 10);
    result = [H' round(infelicity.*t, 3)];
    writematrix(result, 'falling_ball.xlsx');
end