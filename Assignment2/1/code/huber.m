% *******************************************************************************************
% CS736 Assignment 2 Question 1
% Alankar Kotwal <alankar.kotwal@iitb.ac.in>
% Huber derivative
% Make sure the all fucntions are in the same directory as myDriver
% Run the code after CDing to that directory.
% *******************************************************************************************

function out = huber(in, gamma)

    if(in<=gamma)
        out = 0.5*abs(in)^2;
    else
        out = gamma*abs(in)-gamma^2/2;
    end

end