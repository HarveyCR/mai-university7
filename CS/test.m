syms x

f = 1/2 * nthroot(asin(sqrt(x ^2 + 2*x)), 4) + log(sin(nthroot(atan(exp(3*x)),3)));
diff(f)