
%% Part A: Optimization problem of Diffusion Tensor MRI estimation

function [D,L,objfunction,D1,D2,D3,D4] = partA(x,y,z)
 
% Data input array
g = [[1, 0]; [0.866, 0.5]; [0.5, 0.866]; [0, 1]; [-0.5, 0.866]; [-0.866, 0.5]];
Sg = [0.5045 - 1i*0.0217, 0.6874 + 1i*0.0171, 0.3632 + 1i*0.1789, 0.3483 + 1i*0.1385, 0.2606 - 1i*0.0675, 0.2407 + 1i*0.1517];
ASg = abs(Sg);
% we take the choloskey decomposiiton of D and the initial estimate be I
% the beta vector be [a,b,c] as there are just three degrees of freedom.
D1 = [];
D2 = [];
D3 = [];
D4 = [];
objfunction = [];
beta = [x; y; z];
J = zeros(6,3);
count =1;
err_change = -10;
while ((err_change < 0)) 	% run till error stats to rise
    [out,delta] = obj_func(beta(1),beta(2),beta(3),1);
    betaNew = double(beta + delta);
    [outnew,deltanew] = obj_func(betaNew(1),betaNew(2),betaNew(3),0);    
    beta = betaNew;
    objfunction(count) = log(outnew);
    err_change = (outnew-out);
    count = count + 1;
    L = [beta(1),0;beta(2),beta(3)]; % The lower triangular matrix
    D = L*L';
    D1(count) = D(1,1);
    D2(count) = D(1,2);
    D3(count) = D(2,1);
    D4(count) = D(2,2);
end    

% Now D corrosponding to beta is 
L = [beta(1),0;beta(2),beta(3)]; % The lower triangular matrix
D = L*L';

end