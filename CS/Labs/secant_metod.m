function root = secant_metod(f, x_current, x_past, epsilon)
    if abs(f(x_current)) < epsilon
        root = x_current;
        return;
    end

    x_next = x_current - (x_current - x_past) / (f(x_current)- f(x_past)) * f(x_current);
    root = secant_metod(f, x_next, x_current, epsilon);
end