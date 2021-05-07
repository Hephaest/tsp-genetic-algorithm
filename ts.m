function [Parent, Fitness] = ts(Fitness, Data, Distance, num_pointer, num_competitor)
% Tournament Selection
% It selects the required number of chromosomes as candidates and pick the
% best one among each group as child.
% The process is repeated until the desired number of chromosomes is selected.
% Both with-replacement and without-replacement are provide.
%
% Inputs:
%     Fitness           : a m * n matrix presents pathes and corresponding
%                         distance and fitness value
%     Data              : a m * 2 matrix presents X and Y positions of cities
%     Distance          : a m * m matrix presents distances between cities
%     num_pointer       : an integer presents the number of chromosomes as
%                         parents
%     num_competitor    : an integer presents the number of chromosomes as 
%                         candidates in each group
%
% Outputs:
%     Parent            : a m * n matrix presents parents
%     Fitness           : a m * n matrix presents pathes and corresponding
%                         distance and fitness value

[L, W]        = size(Fitness(:, 1: end - 2));
size_rand     = num_competitor * num_pointer;
size_diff     = size_rand - L;

if (size_diff > 0)
    new_pop     = populationMatrix(size_diff, Data);
    new_fitness = fitnessMatrix(new_pop, Distance);
    Fitness(end + 1 : end + size_diff, :) = new_fitness;
    [L, ~]                                = size(Fitness);
end

rand_idx      = randperm(L, size_rand);
groups        = zeros(size_rand, W + 3); % Path | Distance | Value | id
Parent        = zeros(num_pointer, W);
del_list      = zeros(num_pointer, 1);

for i = 1 : length(rand_idx)
    groups(i, 1 : end - 1) = Fitness(rand_idx(i), :);
    groups(i, end)         = rand_idx(i);
end

for i = 1 : num_competitor : length(rand_idx)
    sort_list = sortrows(groups(i : i + num_competitor - 1, :), W + 2, {'descend'});
    idx = floor(i / num_competitor) + 1;
    Parent(idx, :) = sort_list(1, 1 : W);
    del_list(idx) = sort_list(1, end);
end

% Without replacement
Fitness(del_list, :) = [];
end