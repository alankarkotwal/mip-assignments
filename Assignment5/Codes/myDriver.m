
%% CS 736: Assignment 5 : Shape Analysis

% Riddhish Bhalodia and Alankar Kotwal

% Read the DataSet
data = load('assignmentShapeAnalysis.mat');
datamat = data.pointSets;
S = size(datamat);
initial_datamat =datamat;
 figure;
 plot(initial_datamat(1,:),initial_datamat(2,:),'*');
z_mean = zeros(S(1),S(2));

% Step 1: Translate each example so that their COG at orign and norm =1
for k=1:S(3)
     datamat(1,:,k) = datamat(1,:,k) - mean(datamat(1,:,k));
     datamat(2,:,k) = datamat(2,:,k) - mean(datamat(2,:,k));
%      z_mean = datamat(:,:,k);
     datamat(:,:,k) = datamat(:,:,k)./norm(datamat(:,:,k));     
end    

 % Step2: Initial Estimate of mean as example 1 and scale it for norm 1
 z_mean = datamat(:,:,1);
 
 % We need to translate the datapoints so that their mean is 0
 % Determine the optimal transformations for each shape from the mean
 % We will use the matlab function called procustrus minus the reflection
 % for getting the optimal parameters
 
 % Step 3: Align the points to this mean by procrustes analysis
 datamat_transformed = datamat;
 
 title('plot of original pointsets');
 scale = zeros(1,S(3));
 translate = zeros(S(2),S(1),S(3));
 rotatemat = zeros(S(1),S(1),S(3));
 deg = 1;
count = 1;
 while(deg >0.0000001)
     %count
     count = count +1;
     
     z_mean_old = z_mean;
     for k = 1:S(3)
         z_temp = datamat(:,:,k);
         % now we compute the optimal parameters between kth pointset and the
         % mean pointset
         [d,z_trf,tr] = procrustes(z_mean',z_temp','reflection',false);
         datamat_transformed(:,:,k) = z_trf';
         scale(1,k) = tr.b;
         translate(:,:,k) = tr.c;
         rotatemat(:,:,k) = tr.T;
     end    

     % Lets find the average pointset from the transformed ones
     
     for i = 1:S(1)
         for j = 1:S(2)
            z_mean(i,j) = mean(datamat_transformed(i,j,:)); 
         end
     end 

     % again we need to normalize
     for k=1:S(3)
         datamat_transformed(1,:,k) = datamat_transformed(1,:,k) - mean(datamat_transformed(1,:,k));
         datamat_transformed(2,:,k) = datamat_transformed(2,:,k) - mean(datamat_transformed(2,:,k));
     %     z_mean = datamat(:,:,k);
         datamat_transformed(:,:,k) = datamat_transformed(:,:,k)./norm(datamat_transformed(:,:,k));     
     end  
     
     z_mean(1,:) = z_mean(1,:) - mean(z_mean(1,:));
     z_mean(2,:) = z_mean(2,:) - mean(z_mean(2,:));
     z_mean = z_mean./norm(z_mean);
     
     datamat = datamat_transformed;
     deg = norm(z_mean - z_mean_old);
 end
 
 % Now we need to plot the final dataset which is aligned
 figure;
 plot(datamat(1,:),datamat(2,:),'*');
 hold on;
 plot(z_mean(1,:),z_mean(2,:),'r');
 title('The Aligned Pointsets and mean shape');
 legend('aligned pts','mean shape');
 
 % now to find the covariance matrix and find the modes of variation
 C1 = zeros(S(2));
 C2 = zeros(S(2));
 for k=1:S(3)
    C1 = C1 + (datamat(1,:,k) - z_mean(1,:))'*(datamat(1,:,k) - z_mean(1,:));
    C2 = C2 + (datamat(2,:,k) - z_mean(2,:))'*(datamat(2,:,k) - z_mean(2,:));
 end    
 C1 = C1./(S(3)-1);
 C2 = C2./(S(3)-1);
 [U1 S1 V1] = svd(C1);
 [U2 S2 V2] = svd(C2);
 
 % now we need the plot of variances for each principle modes of variation
 lamda1 = zeros(1,S(2));
 lamda1 = zeros(1,S(2));
 for i =1:S(2)
     lamda1(1,i) = S1(i,i);
     lamda2(1,i) = S2(i,i);
 end    
 
 figure;
 plot(lamda1);
 hold on
 plot(lamda2,'r');
 title('Plot of eigenvalues with the modes of variation');
 legend('for x','for y');
 
 var1 = z_mean;
 var2 = z_mean;
 var1(1,:) = z_mean(1,:) + 2*(lamda1(1)^0.5)*V1(:,1)';
 var1(2,:) = z_mean(2,:) + 2*(lamda2(1)^0.5)*V2(:,1)';
 var2(1,:) = z_mean(1,:) - 2*(lamda1(1)^0.5)*V1(:,1)';
 var2(2,:) = z_mean(2,:) - 2*(lamda2(1)^0.5)*V2(:,1)';
 
 figure;
 plot(datamat(1,:),datamat(2,:),'*');
 hold on;
 plot(z_mean(1,:),z_mean(2,:),'r');
  hold on;
 plot(var1(1,:),var1(2,:),'y');
  hold on;
 plot(var2(1,:),var2(2,:),'g');
 title('Aligned Datasets and mean shape plus 2 principle modes of variation');
 legend('aligned pts','mean shape','+2root(l1)','-2root(l1)');