
%{
why does changing my N make my fft narrower?
1. convince myself that normal grating of 5 periods has same fft 
    regardless of sampling
2. plot grating in N = 1000 and N = 2000
%}

N = 1000; % in units of pixels
pitch = 200;
periods = 5;
x = linspace(0, pitch*periods, N+1); % in units of space
x(end) = [];
grating = square((x.*(2*pi))./(pitch))+1;

% N = 2000;
% x = linspace(0, 10*pi, N);
% grating = square(x);

% plot the grating
figure(1)
plot(x, grating)

% plot the fft
figure(2)
plot(abs(fftshift(fft(grating))))