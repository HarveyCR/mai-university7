QS = 4 * 10^3;
GS = 2 * 10^3;
aS = 20 * 10^(-2);
bS = 10 * 10^(-2);
cS = 30 * 10^(-2);
RS = 10 * 10^(-2);
rS = 10 * 10^(-2);

syms P;

My = 2*rS*P*sin(pi/3) + RS*QS * sin(pi/3);

SolMy = solve(My, P);
