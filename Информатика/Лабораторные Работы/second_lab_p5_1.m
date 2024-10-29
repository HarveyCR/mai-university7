A = [3 -7 7 2; 1 -8 10 3; 4 -7 14 5; 1 2 -3 -1];
B = [-22; -35; -48; 12];
AB = [A B]
rank(A)
rank(AB)
# Матричный метод
det(A)
A_inv = inv(A)
X = A_inv * B

A\B


