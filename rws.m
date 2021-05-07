function f = rws(Fitness, num_pointer)
% Roulette Wheel Selection
% It selects the chromosomes based on a probability proportional to the 
% fitness. The process is repeated until the desired number of chromosomes 
% is selected.
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
sum_dist   = sum(Fitness(:, W + 2));
sum_prob   = 0;
ProbMatrix = zeros(L, 2); % Prob | CProb
f          = zeros(num_pointer, W);

for i = 1 : L
    ProbMatrix(i, 1) = Fitness(i, W + 2) / sum_dist;
    sum_prob         = sum_prob + ProbMatrix(i, 1);
    ProbMatrix(i, 2) = sum_prob;
end


for i = 1 : num_pointer
    prob_rand = rand;
    for j = 1 : L
        if (prob_rand <= ProbMatrix(j, end))
            f(i, :) = Fitness(j, 1 : W);
            break;
        end
    end
end

% In case of duplicate
f                = unique(f,'rows');
[unique_size, ~] = size(f);

while (unique_size ~= num_pointer)
    prob_rand = rand;

    for i = unique_size + 1 : num_pointer
        for j = 1 : L
            if (prob_rand <= ProbMatrix(j, end))
                f(i, :) = Fitness(j, 1 : W);
                break;
            end
        end
    end

    f                = unique(f,'rows');
    [unique_size, ~] = size(f);
end

end