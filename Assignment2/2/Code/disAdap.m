
%% Discont Adaptive Function

function out = disAdap(input)
    gamma = 0.1;
    out = gamma/(2*(gamma+abs(input)));
end