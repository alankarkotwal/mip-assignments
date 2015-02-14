% *******************************************************************************************
% CS736 Assignment 1 Question 1
% Alankar Kotwal <alankar.kotwal@iitb.ac.in>
% Driver
% Make sure the all fucntions are in the same directory as this file
% Run the code after CDing to that directory.
% *******************************************************************************************

f = phantom(128);
RN = myRadonTrans(f, 3);
imshow(RN); figure; imshow(mat2gray(RN));