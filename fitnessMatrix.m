function f = fitnessMatrix(Population, Distance)
% Generate a matrix presents fitness information of each path.
%
% Inputs:
%     Population    : a m * n matrix presents population
%     Distance      : a m * m matrix presents distances between cities
%
% Outputs:
%     f             : a m * n matrix presents pathes, distances and fitness value
%                     of pathes in population                   

[L, W] = size(Population);
f      = zeros(L, W + 2); % Pathes | Distance | Value

for i = 1 : L
    f(i, 1 : W) = Population(i, :);
    sum_dist    = 0;

    for j = 1 : W - 1
      sum_dist  = sum_dist + Distance(Population(i, j), Population(i, j + 1));
    end

    f(i, W + 1) = sum_dist;
    f(i, W + 2) = 1 / sum_dist;
end

end
