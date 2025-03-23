QS = 4 * 10^3;
GS = 2 * 10^3;
aS = 20 * 10^(-2);
bS = 10 * 10^(-2);
cS = 30 * 10^(-2);
RS = 10 * 10^(-2);
rS = 10 * 10^(-2);


FQ = [cos(pi/3) 0 sin(pi/3)] * QS;
FG = [0 0 -1] * GS;

syms RAx  RAz RBx RBz P;

FP1 = [-1 0 0] * P;
FP2 = [1 0 0] * P;
RA=[RAx 0 RAz];
RB=[RBx 0 RBz];

VA = [0 0 0];
VQ = VA + [0 aS 0 ] + [-RS 0 0] + [0 bS 0];
VG = VA + [0 aS+3*bS 0];
VB = VG +[0, aS, 0];
VL = VB + [0 cS 0];
VC = VL + [0 -cos(pi/3) +sin(pi/3)] * rS;
VD = VL + [0 +cos(pi/3) -sin(pi/3)] * rS;

mG=0:0.5:6;
mRAx=mG;
mRAz=mG;
mRBx=mG;
mRBz=mG;
mP=mG;


for i=1:length(mG)
 G=[0 0 -mG(i)]*10^3;
 eqnP = RA + RB + FQ + G + FP1 + FP2 == [0 0 0];
 
 eqnM = cross(RA, VA) + cross(RB, VB) + cross(FQ, VQ) + cross(G, VG) + cross(FP1, VC) + cross(FP2, VD) == [0 0 0];

 [FRAx, FRAz, FRBx, FRBz, FP]=solve([eqnP eqnM],[RAx  RAz RBx  RBz P]);
 mRAx(i)=eval(FRAx);
 mRAz(i)=eval(FRAz);
 mRBx(i)=eval(FRBx);
 mRBz(i)=eval(FRBz);
 mP(i)=eval(FP);
end

figure
hold on
xlabel('G');
ylabel('mRAx,...')

plot(mG,mRAx,'--r', 'LineWidth',2);
plot(mG,mRAz,'--b', 'LineWidth',2);
plot(mG,mRBx,':g', 'LineWidth', 1);
plot(mG,mRBz,':m', 'LineWidth', 1);
plot(mG,mP, '-ok');
