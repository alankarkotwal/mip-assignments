
tic;
%% Riddhish Bhalodia and Alankar Kotwal

% the phantom image
img = phantom(256);

%% PART A: Filtering the backprojection in 3 different ways
% The function partA is the supporting one

[out11,out12,out21,out22,out31,out32] = partA(img);
% The L parameter is tuned in the function PartA, which contains the
% function myFilter12.

figure('Name','PartA: Ram Lak Filter');
subplot(1,2,1);imagesc( out11 ); title('Manual filtering:Ram Lak, L=wmax')
colormap(gray(256)); axis image; axis off

subplot(1,2,2);imagesc( out12 ); title('Manual filtering:Ram Lak, L=wmax/2')
colormap(gray(256)); axis image; axis off

figure('Name','PartA: Shepp-Logan Filter');
subplot(1,2,1);imagesc( out21 ); title('Manual filtering:Shepp-Logan, L=wmax')
colormap(gray(256)); axis image; axis off

subplot(1,2,2);imagesc( out22 ); title('Manual filtering:Shepp-Logan, L=wmax/2')
colormap(gray(256)); axis image; axis off

figure('Name','PartA: Cosine Filter');
subplot(1,2,1);imagesc( out31 ); title('Manual filtering:Cosine Filter, L=wmax')
colormap(gray(256)); axis image; axis off


subplot(1,2,2);imagesc( out32 ); title('Manual filtering:Cosine Filter, L=wmax/2')
colormap(gray(256)); axis image; axis off

% The diffrences in the images can be seen in the same manner and they are
% justified, just too many combinations to be put here. so one can just
% execute the following commented code for observing the diffrence

% figure;
% imagesc( out31 - out11 ); 
% colormap(gray(256)); axis image; axis off

%% PartB: Backprojection of noisy image

[S0,S1,S5,R0,R1,R5,rrmse1,rrmse2,rrmse3] = partB(img);

figure('Name','PartB: No Noise, S0 and R0');
subplot(1,2,1);imagesc( S0 ); title('S0')
colormap(gray(256)); axis image; axis off

subplot(1,2,2);imagesc( R0 ); title('R0')
colormap(gray(256)); axis image; axis off

disp('RRMSE for i=0');
disp(rrmse1);

figure('Name','PartB: S1 and R1');
subplot(1,2,1);imagesc( S1 ); title('S1')
colormap(gray(256)); axis image; axis off

subplot(1,2,2);imagesc( R1 ); title('R1')
colormap(gray(256)); axis image; axis off

disp('RRMSE for i=1');
disp(rrmse2);

figure('Name','PartB: S5 and R5');
subplot(1,2,1);imagesc( S5 ); title('S5')
colormap(gray(256)); axis image; axis off

subplot(1,2,2);imagesc( R5 ); title('R5')
colormap(gray(256)); axis image; axis off

disp('RRMSE for i=5');
disp(rrmse3);

%% Part C: plots (takes about 15 min for all the three plots to get executed)

partC(img);

toc;