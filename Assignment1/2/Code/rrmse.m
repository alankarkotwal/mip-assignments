
%% Function for RRMSE

function[a] = rrmse(img1,img2)
a = sum((img1 - img2).^2);
a = sqrt(a);
a = a/(sqrt(sum(img1.^2)));
end