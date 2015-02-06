
%% Function B: noisy image backprojection

function[S0,S1,S5,R0,R1,R5,rrmse1,rrmse2,rrmse3] = partB(img)

S0 = img;
mask = fspecial('gaussian',11,1);
S1 = conv2(S0,mask,'same');
mask = fspecial('gaussian',51,5);
S5 = conv2(S0,mask,'same');

% Compute the radon transform for each of the following
[rt1,x1] = radon(S0,linspace(0,177,60));
[rt2,x2] = radon(S1,linspace(0,177,60));
[rt3,x3] = radon(S5,linspace(0,177,60));

R0 = myFilter12(1,1,rt1,x1);
R1 = myFilter12(1,1,rt2,x2);
R5 = myFilter12(1,1,rt3,x3);

rrmse1 = rrmse(S0,R0);
rrmse2 = rrmse(S1,R1);
rrmse3 = rrmse(S5,R5);

end
