
% Part B

function [noisy,denoisedquad,denoisedhuber,denoisedadap] = partB(input)
% denoisedhuber=input;
% denoisedquad=input;
tau1 = 0.1;

noisy = input.imageNoisy;

% Now we apply the quadratic prior to the denoising algorithm
% h(u) = 1
% Update equation => x = x - k*(y10 + y01 + y-10 + y0-1 - 4x)

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
            x(i,j) = xnew(i,j);
            count = count +1;  
           
       end
   end    
end   

denoisedquad = xnew;

% Now to apply the Huber Function


tau2 = 0.1;
x=y;
xnew = zeros(m,n);
xnew=double(xnew);
for i=2:m-1
    
   for j =2:n-1 
       count=1;
       while(count <51)
            xnew(i,j) = x(i,j) - 2*tau2*((x(i,j) - y(i,j-1))*huberH(y(i,j-1) - x(i,j)) + (x(i,j) - y(i,j+1))*huberH(y(i,j+1) - x(i,j)) + (x(i,j) - y(i-1,j))*huberH(y(i-1,j) - x(i,j)) +(x(i,j) - y(i+1,j))*huberH(y(i+1,j) - x(i,j)));
            x(i,j) = xnew(i,j);    
            count = count +1;
       end
   end    
end   

denoisedhuber = xnew;

% Now apply the discontunity prior 
% h(u) = exp(-|u|^2/gamma)

tau3 = 0.05;
x=y;
xnew = zeros(m,n);
xnew=double(xnew);
for i=2:m-1
%     i
   for j =2:n-1 
       count=1;
       while(count <51)
            xnew(i,j) = x(i,j) - 2*tau3*((x(i,j) - y(i,j-1))*disAdap(y(i,j-1) - x(i,j)) + (x(i,j) - y(i,j+1))*disAdap(y(i,j+1) - x(i,j)) + (x(i,j) - y(i-1,j))*disAdap(y(i-1,j) - x(i,j)) +(x(i,j) - y(i+1,j))*disAdap(y(i+1,j) - x(i,j)));
            x(i,j) = xnew(i,j);    
            count = count +1;
       end
   end    
end   

denoisedadap = xnew;

end