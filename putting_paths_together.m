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

%{

goal: plot 5 periods of diffraction grating
options:
- *construct for loop*
- manually copy and paste separate regions
the plan:
1. redefine domain
2. separate domains into each region
    a. redefine boundaries
    b. redefine regions
3. set each region equal to corresponding E field
    a. modulo

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
numOfPeriods = 5;
pitch = 100;
halfPitch = pitch/2;
N = 1000;

% defining the domain
x = linspace(0, pitch*numOfPeriods, N);


% defining region boundaries
% initializing boundaries variable (can set equal to be correct size)
boundaries = [0];

% defining boundaries (better way to do this?)
for i = 1:numOfPeriods
    boundaries = [boundaries, ((2*i-1)*halfPitch)-(2*d*tand(6))];
    boundaries = [boundaries, (2*i-1)*halfPitch];
    boundaries = [boundaries, (i*pitch)-(2*d*tand(6))];
    boundaries = [boundaries, i*pitch];
end

% defining each region
% initializing regions (is this necessary?)
region1 = false(1, N);
region2 = false(1, N);
region3 = false(1, N);
region4 = false(1, N);

% initializing grating variable
grating = zeros(1, N);

% defining each region using boundaries and setting them equal
% to corresponding E field (shouldnt add logical arrays)
for i = 1:(numOfPeriods*4)
    if mod(i, 4) == 1
        region1 = (x >= boundaries(i) & x <= boundaries(i+1));
        E1 = E0*(exp(1i*(2*pi*L)/lambda));
        grating(region1) = E1;
    elseif mod(i, 4) == 2
        region2 = (x >= boundaries(i) & x <= boundaries(i+1));
        x2 = abs(x(region2)-((i/4)*pitch-(2*d*tand(6))));
        path2a = abs((((L.*sind(6))-x2)./(sind(6)))); 
        path2b = (L - path2a);
        E2 = E0.*exp(1i.*(((2.*pi.*path2a)./lambda)+((2.*pi.*path2b.*n2)./lambda))).*exp(-((2.*pi.*beta).*path2b)./lambda);
        grating(region2) = E2;
    elseif mod(i, 4) == 3
        region3 = (x >= boundaries(i) & x <= boundaries(i+1));
        E3 = E0*exp(1i*((2*pi*L*n2)/lambda))*exp(-(2*pi*L*beta)/lambda);
        grating(region3) = E3;
    elseif mod(i, 4) == 0
        region4 = (x >= boundaries(i) & x <= boundaries(i+1));
        path4a = abs((x(region4)-((i/4)*pitch))./sind(6)); 
        path4b = L - path4a;
        E4 = E0.*exp(1i.*(((2.*pi.*path4a.*n2)./lambda)+((2.*pi.*path4b)./lambda))).*exp(-(2.*pi.*beta.*path4a)./lambda);
        grating(region4) = E4;
    else 
        disp('whoops something went wrong');
    end
end

%{
for each time the value of region is true, define E field. 
but i need to redefine the origin each time a 'true' block appears in the region array.
- could either figure out a way to do that
    - find indices of true
    - for each range, redefine the origin (but how to find each range?)
- or create 20 regions and then splice them together
    - not good to create dynamic variables but i dont want to manually
    create that many regions either
%}

% 7. plotting of E-field
% magnitude
figure(1)
plot(x, abs(grating))
% phase shift
figure(2)
plot(x, angle(grating))








