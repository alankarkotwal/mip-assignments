
%% membership function


function gamma = membership(k,theta,y)
    % GMM
    gaus1 = normpdf(y,theta(1,1) ,theta(2,1));
  gaus2 = normpdf(y,theta(1,2) ,theta(2,2));
 gaus3 = normpdf(y,theta(1,3) ,theta(2,3));
gaus4 = normpdf(y,theta(1,4) ,theta(2,4));
    if(k == 1)
        
        gamma = gaus1./(gaus1+gaus2+gaus3+gaus4);  
%  
    end
    if(k == 2)
        
        gamma = gaus2./(gaus1+gaus2+gaus3+gaus4);
    end
    if(k == 3)
        
        gamma = gaus3./(gaus1+gaus2+gaus3+gaus4);
    end   
    if(k == 4)
        
        gamma = gaus4./(gaus1+gaus2+gaus3+gaus4);
    end   
end