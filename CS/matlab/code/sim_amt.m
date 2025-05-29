% sumpref('display', 'unicode');
%sympref display unicode;

%x = sym('x');
%v = sym('v');

syms v u q

sqrt(3);
sqrt(sym('3'));

vpa( sqrt(2) );
vpa( sqrt(3), 30 );

syms a1 a2 a3 b1 b2 b3
A = [a1 a2 a3]; B = [b1, b2, b3];

dot(A, B);
cross(A, B);

syms a b;
expand( (a + b) ^ 3);

factor(sym("154"));
factor(sym(x^6 - 4 * x*4));

limit(F, x, a);
limit(F, x, a, 'right');

syms a b c d x;
f = a*x^3+b*x^2-c*x-d;
diff(diff(f));
diff(f, x, 2);


int(F)

syms x n
f = str2sym('log(3)^n * x/factorial(n)');
s = symsum(f, n, str2sym('0'));
fn = symsum(f, n, sym(0), str2sym('inf'));

pretty(fn)