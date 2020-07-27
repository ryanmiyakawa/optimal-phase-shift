idx = linspace(-1, 1, 8);
yidx = linspace(-2, 2, 8);

% element i, j of each matrix corresponds to a point on the graph
[x, y] = meshgrid(idx, yidx);
surf(idx, yidx, x.^2+y.^2)

%%
xx = linspace(0, 100, 500);
yy = linspace(0, 100, 500);
[X, Y] = meshgrid(xx, yy);

fwhm = 1;
mu = 50;
sigma = fwhm/(2*sqrt(2*log(2)));
gaussian = (1/sigma*sqrt(2*pi)).*exp(-(((X-mu).^2)/(2*(sigma^2)))-(((Y-mu).^2)/(2*(sigma^2))));
imagesc(gaussian)


