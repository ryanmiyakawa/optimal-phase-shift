%{
the plan

1. define domain
    a. defined by pitch
    b. N elements
2. define region boundaries
3. define each region
4. define what the E-field looks like in each region
    a. reset the 'origin' for each region
5. define new grating
    a. needs to have N elements
6. set each region in grating equal to corresponding E-field
7. plot magnitude and phase shift of E-field to check it worked

%}

% parameters for Mo
delta = .08;
beta = .06;
n2 = 1 + delta;
d = 45;
L = (2*d)/cosd(6);

% other parameters
lambda = 13.5;
E0 = 1;
pitch = 100;
halfPitch = pitch/2;
N = 200;

% 1. defining the domain
x = linspace(0, pitch, N);

% 2. defining region boundaries
boundaries = [halfPitch-(2*d*tand(6)), halfPitch, pitch-(2*d*tand(6)), pitch];

% 3. defining each region
region1 = x >= 0 & x <= boundaries(1);
region2 = x >= boundaries(1) & x <= boundaries(2);
region3 = x >= boundaries(2) & x <= boundaries(3);
region4 = x >= boundaries(3) & x <= boundaries(4);

% 4. defining E-field in each region
% region 1
E1 = E0*(exp(1i*(2*pi*L)/lambda));

% region 2
% redefined origin using 'x(region2)-(halfPitch-(2*d*tand(6)))'
path2a = abs(((L.*sind(6))-abs(x(region2)-(halfPitch-(2*d*tand(6)))))./(sind(6))); 
path2b = L - path2a;
E2 = E0.*exp(1i.*(((2.*pi.*path2a)./lambda)+((2.*pi.*path2b.*n2)./lambda))).*exp(-((2.*pi.*beta).*path2b)./lambda);

% region 3
E3 = E0*exp(1i*((2*pi*L*n2)/lambda))*exp(-(2*pi*L*beta)/lambda);

% region 4
% redefined origin using 'x(region4)-pitch'
path4a = abs((x(region4)-pitch)./sind(6)); 
path4b = L - path4a;
E4 = E0.*exp(1i.*(((2.*pi.*path4a.*n2)./lambda)+((2.*pi.*path4b)./lambda))).*exp(-(2.*pi.*beta.*path4a)./lambda);

% 5. defining the grating
% initialize grating variable
grating = zeros(1, N);

% 6. define grating in each region with corresponding E-field
grating(region1) = E1;
grating(region2) = E2;
grating(region3) = E3;
grating(region4) = E4;

% 7. plotting of E-field
% magnitude
figure(1)
plot(x, abs(grating))
% phase shift
figure(2)
plot(x, angle(grating))






