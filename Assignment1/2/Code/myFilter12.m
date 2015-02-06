
%% The function myFilter

% Type = 1 --> Ram Lak
%      = 2 --> Shepp-Logan
%      = 3 --> Cosine

% L = free parameter normalized by wmax so lies in [0,1]


function[out_img] = myFilter12(type,L,img,xp)

      N1 = length(xp);
      theta = linspace(0,177,60);
      N_theta = length(theta);
      freqs=linspace(-1, 1, N1).';
% Ram Lak
     if(type == 1)
        
        myFilter = abs( freqs );
        wmax = max(myFilter);
        wcut = wmax*L;
        for i=1:length(myFilter)
            if myFilter(i)>wcut
                myFilter(i) = 0;
            end    
        end
        myFilter = repmat(myFilter, [1 N_theta]);

        % do my own FT domain filtering
        ft_R = fftshift(fft(img,[],1),1);
        filteredProj = ft_R .* myFilter;
        filteredProj = ifftshift(filteredProj,1);
        ift_R = real(ifft(filteredProj,[],1));

        % tell matlab to do inverse FBP without a filter
        I1 = iradon(ift_R, theta, 'linear', 'none', 1.0, 256);
        out_img = real(I1);
        
      
     end    
%     Shepp Logan
     if(type == 2)
        myFilter = abs(freqs);
        wmax = max(myFilter);
        wcut = wmax*L;
        for i=1:length(myFilter)
            if myFilter(i)>wcut
                myFilter(i) = 0;
            end    
        end
        myFilter = myFilter.*sinc((0.5/(wmax*L)).*freqs);
        myFilter = repmat(myFilter, [1 N_theta]);

        % do my own FT domain filtering
        ft_R = fftshift(fft(img,[],1),1);
        filteredProj = ft_R .* myFilter;
        filteredProj = ifftshift(filteredProj,1);
        ift_R = real(ifft(filteredProj,[],1));

        % tell matlab to do inverse FBP without a filter
        I1 = iradon(ift_R, theta, 'linear', 'none', 1.0, 256);
        out_img = real(I1);
     end
     
 % Cosine
    if(type == 3)
        myFilter = abs(freqs);
        wmax = max(myFilter);
        wcut = wmax*L;
        for i=1:length(myFilter)
            if myFilter(i)>wcut
                myFilter(i) = 0;
            end    
        end
        myFilter = myFilter.*cos((0.5/(wmax*L)).*freqs);
        myFilter = repmat(myFilter, [1 N_theta]);

        % do my own FT domain filtering
        ft_R = fftshift(fft(img,[],1),1);
        filteredProj = ft_R .* myFilter;
        filteredProj = ifftshift(filteredProj,1);
        ift_R = real(ifft(filteredProj,[],1));

        % tell matlab to do inverse FBP without a filter
        I1 = iradon(ift_R, theta, 'linear', 'none', 1.0, 256);
        out_img = real(I1);
    end    
    
end
