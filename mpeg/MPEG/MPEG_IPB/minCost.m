% Finds the indices of the cell that holds the minimum cost
%
% Input
%   costs : The matrix that contains the estimation costs for a macroblock
%
% Output
%   dx : the motion vector component in columns
%   dy : the motion vector component in rows
%
% Written by Aroh Barjatya

function [dx, dy, min1] = minCost(costs)

[row, col] = size(costs);

% % we check whether the current
% % value of costs is less then the already present value in min. If its
% % inded smaller then we swap the min value with the current one and note
% % the indices.

min1 = min(min(costs));
f=find(costs==min1);
f=f(round(numel(f)/2));
[dy dx] = ind2sub(size(costs),f);




