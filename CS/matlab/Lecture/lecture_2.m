#A = [1 2 3];
#format compact;
#whos A;
#A = vertcat(1,2,3);
#size(A, 2);

#A = rand(1, 3);
#sqrt(sum(A.^2));
#norm(A, 2);
#B = - rand(1, 3)
#dot(A, B)
#lenA = norm(A)
#lenB = norm(A)
#angle = dot(A,B) / (lenA * lenB)
#acosd(angle)
#cos(angle) * 180/pi

#A = [6 3; 1 6]
#B = [7 5; 5 2]

#A + B
#A - B
#A.*B
#[A B A*B A.*B]
#det(A) # Определитель
#A' * A
#rank(A)

A = [3 -7 7; 1 -8 9; 4 -7 14]
B = [-8; -15; -13]

Xm = inv(A) * B
