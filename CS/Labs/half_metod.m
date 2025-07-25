function root = half_metod(f, a, b, epsilon)

    if abs(f(a)) <= epsilon
        root = a;
        return
    elseif f(b) <= epsilon
        root = b;
        return
    end
    
    x_current = (a + b)/2;
    if f(x_current) > 0
        b = x_current;
    else
        a = x_current;
    end

    root = half_metod(f, a, b, epsilon);
end