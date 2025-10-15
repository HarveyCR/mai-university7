% Параметры
R1 = 16; R2 = 32;  R3 = 13; R4 = 16; R5 = 16; R6 = 6;
E1 = 157; E2 = 131; E3 = 132;

% Порядок неизвестных: [I1 I2 I3 I4 I5 I6]
A = [ R1,  R6,    0,   0,   0,  0;     % I1*R1 + I2*R4 + I6*R5 = E1
      0,   -R3,  2*R3+R5,   0,  R6,   0;     % I2*R4 - I3*R2 + I5*R6 = E2
      0,   0,    0, R4,  R2,  R4;      % I6*R5 + I5*R6 + I4*R3 = E3  (reordered to variables)
      0,   0,    R3,   R4,  0  -R4;      % I2 - I5 - I6 = 0
      1,  -1,   -1,   -1,   -1,   1;      % I1 - I2 - I3 = 0
      0,   1,    1,   -1, 0,   -1 ];    % I3 + I4 - I5 = 0

b = [E1; E3; E2; E3; 0; 0];

% Решение
I = A \ b;

I1 = I(1);
I2 = I(2);
I3 = I(3);
I4 = I(4);
I5 = I(5);
I6 = I(6);

fprintf('I1 = %.6f A\n', I1);
fprintf('I2 = %.6f A\n', I2);
fprintf('I3 = %.6f A\n', I3);
fprintf('I4 = %.6f A\n', I4);
fprintf('I5 = %.6f A\n', I5);
fprintf('I6 = %.6f A\n', I6);
