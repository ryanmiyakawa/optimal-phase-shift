% checking graphs for Mo

% parameters
d = 45;
L = (2*d)/cosd(6);
lambda = 13.5;
delta = .08;
beta = .06;
n2 = 1 + delta;
E0 = 1;
pitch = 100;
halfPitch = pitch/2;

% setting the x-axis
x1 = linspace(0, halfPitch-(2*d*tand(6)), 50);
x2 = linspace(halfPitch-(2*d*tand(6)), halfPitch, 50);
x3 = linspace(halfPitch, pitch-(2*d*tand(6)), 50);
x4 = linspace(pitch-(2*d*tand(6)), pitch, 50);

%{
path 1
%}

% E field at end of path
E1 = E0*(exp(1i*(2*pi*L)/lambda));

%{
path 2
%}
% parameters
path2a = abs(((L.*sind(6))-abs(x2-(halfPitch-(2*d*tand(6)))))./(sind(6)));
path2b = L - path2a;

% E field at end of path
E2 = E0.*exp(1i.*(((2.*pi.*path2a)./lambda)+((2.*pi.*path2b.*n2)./lambda))).*exp(-((2.*pi.*beta).*path2b)./lambda);

%{
path 3
%}

% E field at end of path
E3 = E0*exp(1i*((2*pi*L*n2)/lambda))*exp(-(2*pi*L*beta)/lambda);

%{
path 4
%}
% parameters
path4a = abs((x4-pitch)./sind(6));
path4b = L - path4a;
E4 = E0.*exp(1i.*(((2.*pi.*path4a.*n2)./lambda)+((2.*pi.*path4b)./lambda))).*exp(-(2.*pi.*beta.*path4a)./lambda);

%{
plotting the amplitude
%}

figure(1)
plot(x1, abs(E1)*ones(size(x1)))
hold on
plot(x2, abs(E2))
plot(x3, abs(E3)*ones(size(x3)))
plot(x4, abs(E4))
hold off

%{
plotting the phase
%}

figure(2)
plot(x1, angle(E1)*ones(size(x1))) 
hold on
plot(x2, angle(E2))
plot(x3, angle(E3)*ones(size(x3)))
plot(x4, angle(E4))
hold off

% trying to stitch the paths together
            
% 1 period of diffraction grating
x = linspace(0, pitch, 200);

% find phase shift of light passing through absorber
phaseShift1 = exp(1i*(2*pi*L)/lambda);
phaseShift2 = exp(1i.*(((2.*pi.*path2a)./lambda)+((2.*pi.*path2b.*n2)./lambda)));
phaseShift3 = exp(1i*((2*pi*L*n2)/lambda));
phaseShift4 = exp(1i.*(((2.*pi.*path4a.*n2)./lambda)+((2.*pi.*path4b)./lambda)));

% find attenuation of intensity as light passes through absorber
attenuation2 = exp(-((2.*pi.*beta).*path2b)./lambda);
attenuation3 = exp(-(2*pi*L*beta)/lambda);
attenuation4 = exp(-(2.*pi.*beta.*path4a)./lambda);

path1 = phaseShift1;
path2 = phaseShift2.*attenuation2;
path3 = phaseShift3.*attenuation3;
path4 = phaseShift4.*attenuation4;

figure(3)
plot(x1, abs(path1)*ones(size(x1)))
hold on
plot(x2, abs(path2))
plot(x3, abs(path3)*ones(size(x3)))
plot(x4, abs(path4))
hold off


if (x > 0 && x < halfPitch-(2*d*tand(6)))
    grating = phaseShift1;
elseif (x > halfPitch-(2*d*tand(6)) && x < halfPitch)
    grating = phaseShift2*attenuation2;
elseif (x > pitch && x < pitch-(2*d*tand(6)))
    grating = phaseShift3*attenuation3;
elseif (x > pitch-(2*d*tand(6)) && x < pitch)
    grating = phaseShift4*attenuation4;
end


