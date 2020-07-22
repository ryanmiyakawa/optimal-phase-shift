
%{
convolve wafer image with gaussian
1. define gaussian image as fxn of fwhm
    - define fwhm
2. determine what to convolve it with
    - the bit that has the shot noise
3. do the convolution
4. plot the blurred image
%}

% defining gaussian as fxn of fwhm
range = 100;
x = linspace(1, range, 100);
fwhm = 20;
sigma = fwhm/(2*sqrt(2*log(2)));
mu = range/2;
gaussian = (1/(sigma*sqrt(2*pi))).*exp(-((x-mu).^2)./(2.*sigma^2));
plot(x, gaussian)

% convolve with some vector
vector = linspace(1, 100, 100);
convolution = conv(vector, gaussian);