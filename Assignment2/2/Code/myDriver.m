

%% Riddhish Bhaodia and Alankar Kotwal : Assignment 2 -- Question 2
tic;
input = load('assignmentImageDenoisingBrainNoisy.mat');

noisemodel = partA(input.imageNoisy);
disp(noisemodel);

%% Part B

[noisy,denoisedquad,denoisedhuber,denoisedadap] = partB(input);

figure;
imshow(noisy,[]);
title('The Noisy Image');
colorbar;
colormap(gray(256)); axis image; axis off

figure;
imshow(denoisedquad,[]);
title('The output of quadratic prior filter');
colorbar;
colormap(gray(256)); axis image; axis off

figure;
imshow(denoisedhuber,[]);
title('The output of huber prior filter');
colorbar;
colormap(gray(256)); axis image; axis off

figure;
imshow(denoisedadap,[]);
title('The output of discontinuity adaptive prior filter');
colorbar;
colormap(gray(256)); axis image; axis off

%% Part C

dummy = partC(input);
toc;