
%% Function A: backprojection filtering

% Input = phantom image

function[out11,out12,out21,out22,out31,out32] = partA(img)
f = img;
[R,x] = radon(f,linspace(0,177,60));
unfilt_bp = iradon(R,linspace(0,177,60),'none');
figure;
imshow(unfilt_bp,[]);
title('Unfiltered Backprojection');

% general parameters
% myFilter12(type of filter,normalized value of L in [0,1],radon transform parameters)
% See more in the function itself

out31 = myFilter12(3,1,R,x);
out21 = myFilter12(2,1,R,x);
out11 = myFilter12(1,1,R,x);
out32 = myFilter12(3,0.5,R,x);
out22 = myFilter12(2,0.5,R,x);
out12 = myFilter12(1,0.5,R,x);


end