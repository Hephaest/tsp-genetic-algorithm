function [Fitness, min_dist] = addParentToOffspring(Offspring, num_old, Distance, best_k_parent)
% Add best k parents from the current population to the next population and 
% replace rest of the current population with children
% 
% Inputs:
%     Offspring        : a m * n matrix presents children
%     num_old          : an integer presents best k parents
%     Distance         : a m * m matrix presents distances between cities
%     best_k_parent    : a m * n matrix presents parents that contain best 
%                        k fitness values
%
% Outputs:
%     Fitness          : a m * n matrix presents pathes and corresponding
%                        distance and fitness value
%     min_dist         : a 1 * n matrix presents a path and corresponding
%                        distance

[L, W]  = size(Offspring);
Fitness = zeros(L, W + 2); % Pathes | Distance | Value

for i = 1 : L
    Fitness(i, 1 : W) = Offspring(i, :);
    sum_dist    = 0;

    for j = 1 : W - 1
        sum_dist  = sum_dist + Distance(Offspring(i, j), Offspring(i, j + 1));
    end

    Fitness(i, W + 1) = sum_dist;
    Fitness(i, W + 2) = 1 / sum_dist;
end

Fitness                  = sortrows(Fitness, W + 2, {'ascend'});
Fitness(1 : num_old, :)  = best_k_parent;

resort_list              = sortrows(Fitness, W + 2, {'descend'});
min_dist                 = resort_list(1, 1: W + 1);

end