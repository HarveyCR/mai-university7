A = [3 -7 7 2; 1 -8 10 3; 4 -7 14 5; 1 2 -3 -1];
B = [-22; -35; -48; 12];
AB = [A B];
rank(A)
rank(AB)
% Cramer Metods
det_A = det(A);
X = [det([B A(:,2:4) ]) / det_A; det([A(:, 1) B A(:,3:4)]) / det_A; ...
det([A(:, 1:2) B A(:,4)]) / det_A; det([A(:, 1:3) B]) / det_A]

A.\B;

