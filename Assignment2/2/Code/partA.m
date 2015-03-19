
%% Part A

function noisemodel = partA(input)
% We take a smal matrix around in the air
noisemat = zeros(49,49);
noisemat = input(1:49,1:49);
noisevect = noisemat(:);
noisevectreal = real(noisevect);
noisevectimag = imag(noisevect);
 % std deviation of the noise in the back ground
noisemodelreal = sqrt(var(noisevectreal));
noisemodelimag = sqrt(var(noisevectimag));

noisemodel = noisemodelreal + 1i*noisemodelimag;

end
