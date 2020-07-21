
grating = zeros(1, N);
numOfPeriods = 5;

for i = 1:(numOfPeriods*4)
    if mod(i, 4) == 1
        region1 = (x >= boundaries(i) & x <= boundaries(i+1));
        E1 = E0*(exp(1i*(2*pi*L)/lambda));
        grating(region1) = E1;
    elseif mod(i, 4) == 2
        region2 = (x >= boundaries(i) & x <= boundaries(i+1));
        x2 = abs(x(region2)-((i/4)*pitch-(2*d*tand(6))));
        path2a = abs(((L.*sind(6))-x2./(sind(6)))); 
        path2b = (L - path2a);
        E2 = E0.*exp(1i.*(((2.*pi.*path2a)./lambda)+((2.*pi.*path2b.*n2)./lambda))).*exp(-((2.*pi.*beta).*path2b)./lambda);
        grating(region2) = E2;
    elseif mod(i, 4) == 3
        region3 = (x >= boundaries(i) & x <= boundaries(i+1));
        E3 = E0*exp(1i*((2*pi*L*n2)/lambda))*exp(-(2*pi*L*beta)/lambda);
        grating(region3) = E3;
    elseif mod(i, 4) == 0
        region4 = (x >= boundaries(i) & x <= boundaries(i+1));
        path4a = abs((x(region4)-pitch)./sind(6)); 
        path4b = L - path4a;
        E4 = E0.*exp(1i.*(((2.*pi.*path4a.*n2)./lambda)+((2.*pi.*path4b)./lambda))).*exp(-(2.*pi.*beta.*path4a)./lambda);
        grating(region4) = E4;
    else 
        disp('whoops something went wrong');
    end
end

a = linspace(1, 100, 100);
b = [0];
for i = 1:10
    b = [b, 10*i];
end

smth = zeros(1, 100);
for i = 1:10
    if mod(i, 2) == 1
        cOdd = (a >= b(i) & a <= b(i+1));
        smth(cOdd) = (i*2);
    elseif mod(i, 2) == 0
        cEven = a >= b(i) & a <= b(i+1);
        smth(cEven) = (i*2);
    else
        disp('somethings not right')
    end
end