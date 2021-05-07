function f = rs(Fitness, num_pointer)
% Linear Rank Selection
% Individuals are first sorted according to their fitness values and then 
% the ranks are assigned to them. Every chromosome receives fitness from 
% its ranking. The worst will have fitness 1. The best will have fitness N 
% (number of chromosomes in population).
% The process is repeated until the desired number of chromosomes is selected.
% This selection based on RWS.
%
% Inputs:
%     Fitness        : a m * n matrix presents pathes and corresponding
%                      distance and fitness value
%     num_pointer    : an integer presents the number of chromosomes as
%                      parents
%
% Outputs:
%     f              : a m * n matrix presents parents


[L, W]     = size(Fitness(:, 1: end - 2));
sort_list  = sortrows(Fitness, W + 2, {'ascend'});
rand_idx   = randperm(L, num_pointer);
f          = sort_list(rand_idx, 1 : W);

end