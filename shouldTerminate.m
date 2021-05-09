function f = shouldTerminate(Fitness, prob_converge, AVGFIT,  num_avg_even, MINDIST, num_min_even)
% Stopping criterion.
%
% Condition 1: 
%     The population converges when either 90% of the chromosomes in the
%     population have the same fitness value
%
% Condition 2: 
%     The average fitness value of population remains fixed for several
%     iterations
%
% Condition 3: 
%     The shortest fitness value of population remains fixed for several
%     iterations
%
% Inputs:
%     Fitness          : a m * n matrix presents pathes and corresponding
%                        distance and fitness value
%     prob_converge    : a float value presents converge probability
%     AVGFIT           : a m * n matrix presents average fitness value and
%                        distance of population for iterations
%     num_avg_even     : an integer presents the number of fixed average
%                        fitness value of population for iterations
%     MINDIST          : a m * n matrix presents shortest distance
%                        information of population for iterations
%     num_min_even     : an integer presents the number of fixed shortest
%                        distance of population for iterations
%
% Outputs:
%     f                 : a boolean checking result

f        = false;

% -------------------------------------------------------------------------
%                  Condition 1
% -------------------------------------------------------------------------

values   = Fitness(:, end);
dist_val = unique(values);
L        = length(dist_val);

for i = 1 : L
    num_val = sum(values == dist_val(i));
    prob    = num_val / L;
    
    if (prob >= prob_converge)
        fprintf("num_val: %d\n", num_val);
        fprintf("prob: %.4f\n", prob);
        f = true;
        return;
    end 
end

% -------------------------------------------------------------------------
%                  Condition 2
% -------------------------------------------------------------------------

AVGVAL = AVGFIT(:, 1);

if (length(AVGVAL) < num_avg_even)
    return;
end

dist_avg = unique(AVGVAL(end - num_avg_even + 1 : end));
L        = length(dist_avg);

for i = 1 : L
    num_avg = sum(AVGVAL == dist_avg(i));
    
    if (num_avg >= num_avg_even)
        fprintf("Terminated because of the number of same average fitness value");
        f = true;
        return;
    end 
end

% -------------------------------------------------------------------------
%                  Condition 3
% -------------------------------------------------------------------------

MINVAL   = MINDIST(:, end);

if (length(MINVAL) < num_min_even)
    return;
end

dist_min = unique(MINVAL(end - num_min_even + 1 : end));
L        = length(dist_min);

for i = 1 : L
    num_min = sum(MINVAL == dist_min(i));
    
    if (num_min >= num_min_even)
        fprintf("Terminated because of the number of same shortest fitness value");
        f = true;
        return;
    end 
end
