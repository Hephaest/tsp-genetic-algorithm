function f = bestKParent(Fitness, num_old)
% Pick best k parents according to their fitness values and number of k
%
% Inputs:
%     Fitness    : a m * n matrix presents pathes and corresponding
%                  distance and fitness value
%     num_old    : an integer presents best k parents
%
% Outputs:
%
%     f          : a m * n matrix presents parents that contain best
%                  k fitness values

[~, W]    = size(Fitness);
sort_list = sortrows(Fitness, W, {'descend'});
f         = sort_list(1 : num_old, :);

end