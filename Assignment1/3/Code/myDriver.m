
tic;
%% Riddhish Bhalodia and Alankar Kotwal

% Part A function will give the output of D matrix estimate 
% The input is the initial condition of L matrix
% Here the inital condition is that L = [1,0;1,1] and D = LL'
% Have applied Levenberg-marquadtt method for optimization

[D,L,objfunction,D1,D2,D3,D4] = partA(1,1,1);

D
% we need to plot
figure;
plot(objfunction);
title('Plot of logarithm of objective function as per iteration');
figure;
% If we require the whole complex number to be plotted we can just remove
% the real from all Di's
plot(real(D1));
title('Plot of real part of 1st element od D with iteration');
figure;
plot(real(D2));
title('Plot of real part of 2nd element of D with iteration');
figure;
plot(real(D3));
title('Plot of real part of 3rd element of D with iteration');
figure;
plot(real(D4));
title('Plot of real part of 4th element of D with iteration');

%% Part B 
%We take the SVD of the L matrix and find the eigenvector
%corrosponding to the maximumum eigenvalue of LL', which is the coloumn 
% of the matrix U

[U,S,V] = svd(L);
Princ_maximus = U(:,1);  % The final direction along which the diffusion is maximum
Princ_maximus

%% Part C

multi_factor = U(:,1)./U(:,2);
multi_factor

toc;
