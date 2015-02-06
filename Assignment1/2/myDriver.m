
%% Riddhish Bhalodia and Alankar Kotwal

% the phantom image
img = phantom(256);

%% PART A: Filtering the backprojection in 3 different ways
% The function partA is the supporting one

[out11,out12,out21,out22,out31,out32] = partA(img);
% The L parameter is tuned in the function PartA, which contains the
% function myFilter12.

figure('Name','PartA: Ram Lak Filter');
subplot(1,2,1);imagesc( out11 ); title('Manual filtering by Ram Lak, L=wmax')
colormap(gray(256)); axis image; axis off

subplot(1,2,2);imagesc( out12 ); title('Manual filtering by Ram Lak, L=wmax/2')
colormap(gray(256)); axis image; axis off

figure('Name','PartA: Shepp-Logan Filter');
subplot(1,2,1);imagesc( out21 ); title('Manual filtering by Shepp-Logan, L=wmax')
colormap(gray(256)); axis image; axis off

subplot(1,2,2);imagesc( out22 ); title('Manual filtering by Shepp-Logan, L=wmax/2')
colormap(gray(256)); axis image; axis off

figure('Name','PartA: Cosine Filter');
subplot(1,2,1);imagesc( out31 ); title('Manual filtering by Cosine Filter, L=wmax')
colormap(gray(256)); axis image; axis off


subplot(1,2,2);imagesc( out32 ); title('Manual filtering by Cosine Filter, L=wmax/2')
colormap(gray(256)); axis image; axis off

% The diffrences in the images can be seen in the same manner and they are
% justified, just too many combinations to be put here. so one can just
% execute the following commented code for observing the diffrence

% figure;
% imagesc( out31 - out11 ); 
% colormap(gray(256)); axis image; axis off

%% PartB: Backprojection of noisy image

[S0,S1,S5,R0,R1,R5,rrmse1,rrmse2,rrmse3] = partB(img)