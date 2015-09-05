
%% Huber Objective function output

function out = huberObj(input)
gamma = 0.001;

if(abs(input)>gamma)
%       abs(input)
    out = gamma*abs(input) - 0.5*gamma*gamma;
else
%   
    out = 0.5*abs(input)*abs(input);
end    
end