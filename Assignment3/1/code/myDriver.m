% *******************************************************************************************
% CS736 Assignment 2 Question 1
% Alankar Kotwal <alankar.kotwal@iitb.ac.in>
% Driver
% Make sure the all functions are in the same directory as this file
% Run the code after CDing to that directory.
% *******************************************************************************************

load('../images/assignmentImageReconstructionPhantom.mat');
disp(rrmse(imageNoiseless, ifft2(imageKspaceData)));
% Prior type: 0 for Quadratic, 1 for Discontinuity-adaptive Huber
% 2 for Discontinuity-adaptive
priorType = 1;
if(priorType ~=0 && priorType ~=1 && priorType ~=2)
    error('priorType must be one of 0, 1, 2.');
end

% Initial step size
tau = 0.1;

% Parameters to be tuned
% alpha = 0.8; % for quad
alpha = 0.055; % for huber
% alpha = 0.26; % for disc adap
gamma = 0.5; % for huber
% gamma = 0.2; % for disc adap
x = zeros(size(imageKspaceData));

oldX = ones(size(imageKspaceData));
objFns = zeros(1, 1);
oldObjFn = Inf;
iter = 1;

while(rrmse(x, oldX) > 0.002)
    oldX = x;
    priorImage = x;

    likelihoodUpdate = (x - ifft2(imageKspaceData));
    tempImage1 = circshift(x, 1)-priorImage;
    tempImage2 = circshift(x, -1)-priorImage;
    tempImage3 = transpose(circshift(transpose(x), 1))-priorImage;
    tempImage4 = transpose(circshift(transpose(x), -1))-priorImage;
    
                switch(priorType)
                    case 0
                        priorUpdate = tempImage1*quad_derivative(tempImage1, gamma)+tempImage2*quad_derivative(tempImage2, gamma)+tempImage3*quad_derivative(tempImage3, gamma)+tempImage4*quad_derivative(tempImage4, gamma);
                        priorPenalty = tempImage1*quad(tempImage1, gamma)+tempImage2*quad(tempImage2, gamma)+tempImage3*quad(tempImage3, gamma)+tempImage4*quad(tempImage4, gamma);
                    case 1
                        priorUpdate = tempImage1*huber_derivative(tempImage1, gamma)+tempImage2*huber_derivative(tempImage2, gamma)+tempImage3*huber_derivative(tempImage3, gamma)+tempImage4*huber_derivative(tempImage4, gamma);
                        priorPenalty = tempImage1*huber(tempImage1, gamma)+tempImage2*huber(tempImage2, gamma)+tempImage3*huber(tempImage3, gamma)+tempImage4*huber(tempImage4, gamma);
                    case 2
                        priorUpdate = tempImage1*disc_adaptive_derivative(tempImage1, gamma)+tempImage2*disc_adaptive_derivative(tempImage2, gamma)+tempImage3*disc_adaptive_derivative(tempImage3, gamma)+tempImage4*disc_adaptive_derivative(tempImage4, gamma);
                        priorPenalty = tempImage1*disc_adaptive(tempImage1, gamma)+tempImage2*disc_adaptive(tempImage2, gamma)+tempImage3*disc_adaptive(tempImage3, gamma)+tempImage4*disc_adaptive(tempImage4, gamma);
                end

                objFn = alpha*sum(sum(abs(x-ifft2(imageKspaceData)).^2))+(1-alpha)*sum(sum(abs(priorPenalty)));
    objFns(iter) = objFn;

    % Update
    x = x - 2*tau*(alpha*likelihoodUpdate-(1-alpha)*priorUpdate);

    % Changing step-size
    if(objFn < oldObjFn)
        tau = 1.1*tau;
    else
        tau = 0.5*tau;
    end
    oldObjFn = objFn;

    iter = iter+1;


end
%             errs(i, j, priorType+1) = rrmse(imageNoiseless, imageNoisy);
%             j = j + 1;
%         end
%         i = i + 1;
%     end
% end

disp(rrmse(imageNoiseless, x));
figure; imshow(abs(x));
figure; plot(1:iter-1, objFns);