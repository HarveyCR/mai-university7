% Очистка рабочей области и командного окна
clear; clc;

% Объявление символьных переменных
syms i1 i2 i3 i4 i5 i6;

% Задание уравнений (все уравнения должны быть заданы в виде expr == value)
eqns = [i3 - i2 - i5 == 0,
        i6 - i5 - i1 == 0,
        i2 - i1 - i4 == 0,
        -19*i2 - 11*i1 + 13*i5 == -105,
        -7*i3 - 13*i5 - 3*i6 == -66,
        -11*i4 + 3*i6 + 11*i1 == 0];

% Решение системы
vars = [i1, i2, i3, i4, i5, i6];
[sol_i1, sol_i2, sol_i3, sol_i4, sol_i5, sol_i6] = solve(eqns, vars);

% Вывод результатов
disp('Символьные решения:');
disp('i1 = '); fprintf('%.6f\n', sol_i1);
disp('i2 = '); disp(sol_i2);
disp('i3 = '); disp(sol_i3);
disp('i4 = '); disp(sol_i4);
disp('i5 = '); disp(sol_i5);
disp('i6 = '); disp(sol_i6);

clear; clc;

syms  p_a p_d p_c p_b;

eqns = [(p_d - p_c + 66) / 7 - (p_c - p_a + 105) / 19 - (p_c - p_b) / 13 == 0,
         (p_b - p_d) / 3 - (p_c - p_b) / 13 - (p_a - p_b) / 11 == 0,
          (p_c - p_a + 105) / 19 - (p_a - p_b) / 11 - (p_a - p_d) / 11 == 0];

vars = [p_a, p_d, p_c, p_b];
[sol_pa, sol_pd, sol_pc, sol_pb] = solve(eqns, vars);

disp('Потенциалы:');
disp('p_a = '); fprintf('%.6f\n', sol_pa);
disp('p_d = '); fprintf('%.6f\n', sol_pd);
disp('p_c = '); fprintf('%.6f\n', sol_pc);
disp('p_b = '); fprintf('%.6f\n', sol_pb);

i1 = (sol_pa - sol_pb) / 11;
i2 = (sol_pc - sol_pa + 105) / 19;
i3 = (sol_pd - sol_pc + 66) / 7;
i4 = (sol_pa - sol_pd) / 11;
i5 = (sol_pc - sol_pb) / 13;
i6 = (sol_pb - sol_pd) / 3;

disp('Токи: ');
disp('i1 = '); fprintf('%.6f\n', i1);
disp('i2 = '); fprintf('%.6f\n', i2);
disp('i3 = '); fprintf('%.6f\n', i3);
disp('i4 = '); fprintf('%.6f\n', i4);
disp('i5 = '); fprintf('%.6f\n', i5);
disp('i6 = '); fprintf('%.6f\n', i6);