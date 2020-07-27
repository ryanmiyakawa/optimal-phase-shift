idx = linspace(-1, 1, 100);
yidx = linspace(-2, 2, 100);

[x, y] = meshgrid(idx, yidx);
surf(x.^2+y.^2)

