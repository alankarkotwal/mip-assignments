% *******************************************************************************************
% CS736 Assignment 1 Question 1
% Alankar Kotwal and Riddhish Bhalodia
% myRadonTransform function
% Make sure the driver is in the same directory as this file
% Run the code after CDing to that directory.
% *******************************************************************************************

function R = myRadonTrans(im, stepSize)
    [tArr, thetaArr] = meshgrid(-90:5:90, 0:5:175);
    R = zeros(36, 37);
    
    for i=1:36
        for j=1:37
            disp([i j]);
            R(i, j) = myIntegration(im, tArr(i, j), thetaArr(i, j), stepSize);
        end
    end
end