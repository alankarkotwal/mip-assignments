% *******************************************************************************************
% CS736 Assignment 1 Question 7
% Alankar Kotwal <alankar.kotwal@iitb.ac.in>
% myIntegration function
% Make sure the driver is in the same directory as this file
% Run the code after CDing to that directory.
% *******************************************************************************************

function res = myIntegration(im, t, theta, stepSize)
    imSize = size(im);
    cenX = (imSize(2) + 1)/2;
    cenY = (imSize(1) + 1)/2;
    xLim = (cenX - 0.5);
    yLim = (cenY - 0.5);
    
    res = 0;
    
    % Find ranges for s using intersections with image edges.
    sx1 = (t*cos(theta)-xLim)/sin(theta);
    sx2 = (t*cos(theta)+xLim)/sin(theta);
    sy1 = (-t*sin(theta)-yLim)/cos(theta);
    sy2 = (yLim-t*sin(theta))/cos(theta);
    
    sMin = max(min(sx1, sx2), min(sy1, sy2));
    sMax = min(max(sx1, sx2), max(sy1, sy2));
    
    if(sMin>sMax) 
        return;
    end
    
    [X, Y] = meshgrid(-cenX+1:cenX-1, -cenY+1:cenY-1);
    
    for s=sMin:stepSize:sMax
        x = t*cos(theta) - s*sin(theta);
        y = t*sin(theta) + s*cos(theta);
        val = interp2(X, Y, im, x, y, 'cubic', 0);
        res = res + val*stepSize;
    end
end