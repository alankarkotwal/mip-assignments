function [out,delta] = obj_func(x,y,z,t)
   g = [[1, 0]; [0.866, 0.5]; [0.5, 0.866]; [0, 1]; [-0.5, 0.866]; [-0.866, 0.5]];
   Sg = [0.5045 - 1i*0.0217, 0.6874 + 1i*0.0171, 0.3632 + 1i*0.1789, 0.3483 + 1i*0.1385, 0.2606 - 1i*0.0675, 0.2407 + 1i*0.1517]; 
   
   J = zeros(6,3);
    s = 0.01;    % Step Size
    lambda = 0.00005;  % Levenberg parameter

    L = [x 0; y z];  % Lower Traingular matrix by cholexsky decomposition

    for i=1:6
        r(i) = Sg(i) - exp(-0.1*g(i,:)*(L*L')*g(i,:)');  % Residual
        J(i,:) = 0.2.*exp(-0.1*g(i,:)*(L*L')*g(i,:)').*[x*g(i,1)^2 + y*g(i,1)*g(i,2), y*g(i,2)^2 + x*g(i,1)*g(i,2), z*g(i,2)^2 ];
    end

    out = sum(abs(r.*r));

    if(t==1)
        delta = -s*inv(J'*J+lambda*diag(diag(J'*J)))*J'*r';
    else
        delta = 0;
    end     
    
end
