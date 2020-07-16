
T = 2;
N = 500;


regboundaries = [0, 60, 100, 160, 200]/200 * T;

% Define coordinates
idx = linspace(0, T, N);


% reg 1: y = 1
% reg 2; y = 0
% reg 3: y = x
% reg 4: y = x^2


y = zeros(1, N);

tic
for k = 1:length(idx)
    x = idx(k);
    if x <= regboundaries(2) && x >= regboundaries(1)
        % then we're in region 1
%         disp('Im in region 1!')
        y(k) = 1;
        
    elseif x < regboundaries(3) && x >= regboundaries(2)
         % then we're in region 2
%          disp('Im in region 2!')
         y(k) = 0;
    elseif x < regboundaries(4) && x >= regboundaries(3)
         % then we're in region 3
%          disp('Im in region 3!')
         y(k) = (x - regboundaries(3));
    elseif x < regboundaries(5) && x >= regboundaries(4)
         % then we're in region 4
%          disp('Im in region 4!')
         y(k) = 4*(x - regboundaries(4))^2;
    else
        disp('Not in any region!')
    end
end
toc

tic
logicalRegion1 = idx <= regboundaries(2) & idx >= regboundaries(1);
logicalRegion2 = idx <= regboundaries(3) & idx >= regboundaries(2);
logicalRegion3 = idx <= regboundaries(4) & idx >= regboundaries(3);
logicalRegion4 = idx <= regboundaries(5) & idx >= regboundaries(4);

y(logicalRegion1) = 1;
y(logicalRegion2) = 0;
y(logicalRegion3) = idx(logicalRegion3) - regboundaries(3);
y(logicalRegion4) = (idx(logicalRegion4) - regboundaries(4)).^2;
toc



% plot(idx, y)

