
%% The function myFilter

% Type = 1 --> Ram Lak
%      = 2 --> Shepp-Logan
%      = 3 --> Cosine

% L = free parameter


function[out_img] = myFilter12(img)
%     out_img = [];
%     N1 = length(xp);
      theta = linspace(0,177,60);
      N_theta = length(theta);
      freqs=linspace(-1, 1, 367).';

%     if(type == 1)
        
        % Setting at L/2
        myFilter1 = abs( freqs.*1 );
        myFilter2 = repmat(myFilter1, [1 N_theta]);

        % do my own FT domain filtering
        ft_R = fftshift(fft(img,[],1),1);
        filteredProj1 = ft_R .* myFilter2;
        filteredProj2 = ifftshift(filteredProj1,1);
        ift_R = real(ifft(filteredProj2,[],1));

        % tell matlab to do inverse FBP without a filter
        I1 = iradon(ift_R, theta, 'linear', 'none', 1.0, 256);
        out_img = real(I1);
        %figure;
        %imagesc( real(I1) ); title('Manual filtering by Ram Lak')
        %colormap(gray(256)); axis image; axis off

      
%     end    
%     
%     if(type == 2)
%     end
%     
%     if(type == 3)
%     end    
    
end
