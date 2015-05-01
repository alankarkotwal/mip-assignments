% *******************************************************************************************
% CS736 Assignment 2 Question 1
% Alankar Kotwal <alankar.kotwal@iitb.ac.in>
% Discontinuous-adaptive penalty function
% Make sure the all fucntions are in the same directory as myDriver
% Run the code after CDing to that directory.
% *******************************************************************************************

function out = disc_adaptive(in, gamma)

    out = gamma*abs(in) - gamma^2 * log(1 + abs(in)/gamma);

end