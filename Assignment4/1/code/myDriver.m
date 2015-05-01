% *******************************************************************************************
% CS736 Assignment 4 Question 1
% Alankar Kotwal <alankar.kotwal@iitb.ac.in>
% Driver
% Make sure the all functions are in the same directory as this file
% Run the code after CDing to that directory.
% *******************************************************************************************

% Load the data
load('images/assignmentSegmentBrain.mat');
imSize = size(imageData);
nPoints = nnz(imageMask);

% Constants
K = 3;

% Parameters
q = 4;
winSize = 25;
sigma = 2;
maxIter = 1;

% Variables
mems = ones(imSize(1), imSize(2), K)/3;
weights = fspecial('gaussian', winSize, sigma);
bias = ones(imSize);
means = [0 0.5 1];

% Calculate some stuff
winRad = (winSize-1)/2;

% Iterate maxIter times
for iter = 1:maxIter
    
    disp(iter);
    
    for i=1:imSize(1)
        for j=1:imSize(2)
            
            disp('Iter');
            disp(iter);
            
            disp('Mems');
            disp([i j]);
            
            if(imageMask(i, j) == 1)
                
                % Calculate memberships 
                d = [0 0 0];
                for k=1:K
                    
                dElem = 0;
                for l=i-winRad:i+winRad
                    for m=j-winRad:j+winRad
                        if(imageMask(l, m) == 1)

                            dElem = dElem + weights(l-i+winRad+1, m-j+winRad+1)*(imageData(i, j)-means(k)*bias(l, m))^2;

                        end
                    end
                end
                d(k) = dElem;

                end
                mems(i, j, :) = (1./d).^(1/(q-1));
                mems(i, j, :) = mems(i, j, :)/sum(mems(i, j, :));
                
            end
        end
    end
    
    convImage = conv2(bias, weights);
    convSqImage = conv2(bias.^2, weights);
    for k=1:K
        
        disp('Iter');
        disp(iter);
        
        disp('Means');
        disp(k);
        
        classNum = 0;
        classDen = 0;
        for i=1:imSize(1)
            for j=1:imSize(2)
                
                if(imageMask(i, j) == 1)
                
                    classNum = classNum + convImage(i, j)*mems(i, j, k)*imageData(i, j);
                    classDen = classDen + convSqImage(i, j)*mems(i, j, k);
                
            
                end
                
            end
        end
        
        means(k) = classNum/classDen;
        
    end
    
    for i=1:imSize(1)
        for j=1:imSize(2)
            if(imageMask(i, j) == 1)
                
                disp('Iter');
                disp(iter);
                
                disp('Bias');
                disp([i j]);
                
                biasNum = 0;
                biasDen = 0;
                for l=i-winRad:i+winRad
                    for m=j-winRad:j+winRad
                        if(imageMask(l, m) == 1)

                            classNum = 0;
                            classDen = 0;
                            for k=1:K
                                classNum = classNum + mems(l, m, k)*means(k);
                                classDen = classDen + mems(l, m, k)*means(k)^2;
                            end
                            
                            
                            biasNum = biasNum + weights(l-i+winRad+1, m-j+winRad+1)*imageData(l, m)*classNum;
                            biasDen = biasDen + weights(l-i+winRad+1, m-j+winRad+1);
                        end
                    end
                end
               
                bias(i, j) = biasNum/biasDen;
                
            end
        end
    end
    
end

biasRemoved = means(1)*mems(:, :, 1) + means(2)*mems(:, :, 2) + means(3)*mems(:, :, 3);
for i=1:imSize(1)
    for j=1:imSize(2)
        if(imageMask(i, j) ~= 1)
            biasRemoved(i, j) = 0;
        end
    end
end
residual = imageData - biasRemoved.*bias;