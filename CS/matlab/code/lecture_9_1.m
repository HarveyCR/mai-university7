function s = lecture_9_1 (x, tol, k_max) 
    function s = calc_sum(k, ak)
        if k == k_max || abs(ak) < tol
            s = ak;
        else
            s = ak + calc_sum(k + 1, -(2*x)^2/(2*k+1)/(2*k+2) * ak);
        end
    end
s = -1/2 + calc_sum(1, x^2);
tol = 1e-4;
k_max = 5;
end
