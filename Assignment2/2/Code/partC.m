
%% Part C: To Plot the Objective Functions wrt iterations

function dummy = partC(input)
dummy = 1;
noisy = input.imageNoisy;

% PLot for the quadratic prior function
% The objective function = abs(u*u)
objfun = zeros(50,1);

tau1 = 0.05;

y = real(noisy);

[m,n] = size(y);
x = real(noisy);
xnew = zeros(m,n);
xnew =  double(xnew);
       
for i=2:m-1
    
   for j =2:n-1 
       count =1;
       while(count <51)
            xnew(i,j) = x(i,j) - 2*tau1*(4*x(i,j) - y(i,j+1) - y(i,j-1) - y(i+1,j) - y(i-1,j));
            objfun(count) = objfun(count) + abs((x(i,j) - y(i+1,j))^2) + abs((x(i,j) - y(i,j+1))^2) + abs((x(i,j) - y(i,j-1))^2) + abs((x(i,j) - y(i-1,j))^2);
            x(i,j) = xnew(i,j);
            count = count +1;  
           
       end
   end    
end   

objfun = objfun./((n-2)*(m-2));
figure;
plot(objfun);
title('Quadratic Obj Function wrt number of iterations(50)');


% For the Huber Function

objfun1 = zeros(50,1);

tau2 = 0.1;
x=y;
xnew = zeros(m,n);
xnew=double(xnew);
for i=2:m-1
    
   for j =2:n-1 
       count=1;
       while(count <51)
            xnew(i,j) = x(i,j) - 2*tau2*((x(i,j) - y(i,j-1))*huberH(y(i,j-1) - x(i,j)) + (x(i,j) - y(i,j+1))*huberH(y(i,j+1) - x(i,j)) + (x(i,j) - y(i-1,j))*huberH(y(i-1,j) - x(i,j)) +(x(i,j) - y(i+1,j))*huberH(y(i+1,j) - x(i,j)));
            objfun1(count) = objfun1(count) + huberObj(y(i,j-1) - x(i,j)) +huberObj(y(i+1,j) - x(i,j)) +huberObj(y(i-1,j) - x(i,j)) +huberObj(y(i,j+1) - x(i,j));
            x(i,j) = xnew(i,j);    
            count = count +1;
       end
   end    
end   

objfun1 = objfun1./((n-2)*(m-2));
figure;
plot(objfun1);
title('Huber Obj Function wrt number of iterations(50)');

% For the discontinuity adaptive function
objfun2 = zeros(50,1);

tau3 = 0.05;
x=y;
xnew = zeros(m,n);
xnew=double(xnew);
for i=2:m-1
    
   for j =2:n-1 
       count=1;
       while(count <51)
            xnew(i,j) = x(i,j) - 2*tau3*((x(i,j) - y(i,j-1))*disAdap(y(i,j-1) - x(i,j)) + (x(i,j) - y(i,j+1))*disAdap(y(i,j+1) - x(i,j)) + (x(i,j) - y(i-1,j))*disAdap(y(i-1,j) - x(i,j)) +(x(i,j) - y(i+1,j))*disAdap(y(i+1,j) - x(i,j)));
            objfun2(count) = objfun2(count) + disAdapObj(y(i-1,j)-x(i,j)) + disAdapObj(y(i,j+1)-x(i,j)) + disAdapObj(y(i,j-1)-x(i,j)) + disAdapObj(y(i+1,j)-x(i,j));
            x(i,j) = xnew(i,j);    
            count = count +1;
       end
   end    
end

objfun2 = objfun2./((n-2)*(m-2));
figure;
plot(objfun2);
title('Discontinuity Adaptive Obj Function wrt number of iterations(50)');

end