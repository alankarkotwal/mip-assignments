
%% Function C: RRMSE plot 

function[] = partC(img)

disp('PartC takes around 10min to execute fully');
f = img;
[rt,x] = radon(f,linspace(0,177,60));

ft_R = fftshift(fft(rt,[],1),1);
wmax = round(max(max(ft_R)));  % this is scaled to 1 in L
L1 = linspace(0,1,wmax);
rrm1 = L1;

for i=1:wmax
% disp(i);
rrm1(1,i) = rrmse(f,myFilter12(1,L1(1,i),rt,x));
end

figure;
plot(L1,rrm1);
title('RRMSE vs w_{normalized} for S0');
xlabel('Normalized w');
ylabel('RRMSE');

mask = fspecial('gaussian',11,1);
S1 = conv2(f,mask,'same');
mask = fspecial('gaussian',51,5);
S5 = conv2(f,mask,'same');

[rt,x] = radon(S1,linspace(0,177,60));

ft_R = fftshift(fft(rt,[],1),1);
wmax = round(max(max(ft_R)));  % this is scaled to 1 in L
L2 = linspace(0,1,wmax);
rrm2 = L2;

for i=1:wmax
% disp(i);
rrm2(1,i) = rrmse(S1,myFilter12(1,L2(1,i),rt,x));
end

figure;
plot(L2,rrm2);
title('RRMSE vs w_normalized for S1');
xlabel('Normalized w');
ylabel('RRMSE');

[rt,x] = radon(S5,linspace(0,177,60));

ft_R = fftshift(fft(rt,[],1),1);
wmax = round(max(max(ft_R)));  % this is scaled to 1 in L
L3 = linspace(0,1,wmax);
rrm3 = L3;

for i=1:wmax
% disp(i);
rrm3(1,i) = rrmse(S5,myFilter12(1,L3(1,i),rt,x));
end

figure;
plot(L3,rrm3);
title('RRMSE vs w_normalized for S5');
xlabel('Normalized w');
ylabel('RRMSE');

end