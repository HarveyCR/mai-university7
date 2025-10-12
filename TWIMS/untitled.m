R1 = 8; R2 = 9; R3 = 3; R4 = 7; R5 = 15; R6 = 11;
E2 = 140; E3 = 102;

A = [ R1+R3+R4,  -R4,            -R3;
      -R4,       (R2+R4+R5),    -R5;
      -R3,       -R5,            (R3+R5+R6) ];

b = [-E3; E2; E3];

I = A \ b;

fprintf('I11 = %.6f A\n', I(1));
fprintf('I22 = %.6f A\n', I(2));
fprintf('I33 = %.6f A\n', I(3));

res = A*I - b;
fprintf('max residual = %.2e\n', max(abs(res)));