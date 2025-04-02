P = [0 -45 0];
syms RAx  RAy RBx RBy;

RA=[RAx RAy 0];
RB=[-RBx*sin(pi/3) RBy*cos(pi/3) 0];

VA = [0 0 0];
VB = VA + [0 -1 0];
VC = VA + [-0.5 -1 0];


eqnP = RA + RB + P == [0 0 0];
 
eqnM = cross(RA, VA) + cross(RB, VB) + cross(P, VC) == [0 0 0];

[FRAx, FRAy, FRBx, FRBy] = solve([eqnP eqnM],[RAx RAy RBx RBy])

eval(FRBx) + eval(FRBy)