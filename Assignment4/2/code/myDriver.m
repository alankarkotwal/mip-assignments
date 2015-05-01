% *******************************************************************************************
% CS736 Assignment 4 Question 2
% Riddhish Bhalodia
% Driver
% Make sure the all functions are in the same directory as this file
% Run the code after CDing to that directory.
% *******************************************************************************************

initial_file = load('assignmentSegmentBrainGmmEmMrf.mat');
data_file = initial_file.imageData;
mask_file = initial_file.imageMask;
% Cropping the window to the brain segment, then we use 4 classes for
% segmentation, that would compesate for the background
data_file_new = data_file(20:236,40:216);

data_vec = data_file_new(:);
mask_vec = mask_file(:);
figure;
imshow(data_file_new,[]);
figure;
imshow(mask_file,[]);

[m,n] = size(data_file);
theta = [0.15,0.5,0.65,0;1,1,1,1];

data_vec_old=data_vec;

 for count =1:2
%     E step%
    gamma1 = membership(1,theta,data_vec_old);
    gamma2 = membership(2,theta,data_vec_old);
    gamma3 = membership(3,theta,data_vec_old);
    gamma4 = membership(4,theta,data_vec_old);
    
%     M step
    theta(1,1) = sum(gamma1.*data_vec_old)/sum(gamma1);
    theta(1,2) = sum(gamma2.*data_vec_old)/sum(gamma2);
    theta(1,3) = sum(gamma3.*data_vec_old)/sum(gamma3);
    theta(1,4) = sum(gamma4.*data_vec_old)/sum(gamma4);
    
    theta(2,1) = sum(gamma1.*(data_vec_old - theta(1,1)).^2)/sum(gamma1);
    theta(2,2) = sum(gamma2.*(data_vec_old - theta(1,2)).^2)/sum(gamma2);
    theta(2,3) = sum(gamma3.*(data_vec_old - theta(1,3)).^2)/sum(gamma3);
    theta(2,4) = sum(gamma4.*(data_vec_old - theta(1,4)).^2)/sum(gamma4);
    
 end    
final_vec = data_vec;

for i=1:length(data_vec)
    final_vec(i) =  max(max(gamma1(i),gamma2(i)),gamma3(i));
end

out = reshape(final_vec,size(data_file_new));
figure;
imshow(out,[]);
























