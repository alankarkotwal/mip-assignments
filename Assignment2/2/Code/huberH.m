

%% Function HuberH

function out = huberH(input)
    gamma = 0.01;
    if(abs(input) >= gamma)
        out = 1/2;
    end
    if(abs(input) < gamma)
        out = gamma/(2*abs(input));
%         input
    end    
%     out
end