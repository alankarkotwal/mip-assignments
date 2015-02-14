% *******************************************************************************************
% CS736 Assignment 1 Question 1
% Alankar Kotwal <alankar.kotwal@iitb.ac.in>
% Driver
% Make sure the all fucntions are in the same directory as this file
% Run the code after CDing to that directory.
% *******************************************************************************************

f = phantom(128);

a = myIntegration(f, 0, 0, 1);
b = myRadonTrans(f, 1);