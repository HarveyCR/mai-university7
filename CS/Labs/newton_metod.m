function root  = newton_metod(f, df, x_current, epsilon)
    if abs(f(x_current)) < epsilon
        root = x_current;
        return;
    end

    x_next = x_current - f(x_current)/df(x_current);
    root = newton_metod(f, df, x_next, epsilon);
end