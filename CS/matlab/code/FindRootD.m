function [x, k] = FindRootD(f, range, tol, k_max)
    if length(range) == 2
        if f(range(1)) * f(range(2)) > 0
            error ('Уточните начальный интервал');
        end
        a = range(1); b = range(1);
    elseif length(range) == 1    
        a = range; deltaX = 0.1;
        k = 1; b = a + deltaX;
        while f(a)*f(b) >= 0
            k = -k;
            if (k>0) b = b + deltaX;
            else a = a - deltaX;
            end
        end
    
        if (k > 0) a = b - deltaX;
        else b = a + deltaX;
        end

    else
        error('Error')
    end
    
    [k, Fa] = {0, f(a)}{:};
    do
        k = k + 1; x = (a + b)/2; Fx = f(x);
        if (Fa * Fx < 0), b = x; else a = x; Fa = Fx; end
    untile ((abs(Fx) < tol)) || (k == k_max)
            
end
