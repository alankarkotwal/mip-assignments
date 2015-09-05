
%% Discontinuity Adaptive Objective Function

function out = disAdapObj(input)
    gamma = 0.1;
    out  = gamma*abs(input)-gamma^2*(log(1+(abs(input)/gamma)));
end