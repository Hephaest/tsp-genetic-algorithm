function f = crossover(Parent, prob_crossover)
% Generate children by parents under crossover
% If random probability is under crossover probability then generate
% children else save parents as children.
%
% Inputs:
%     Parent            : a m * n matrix presents parents
%     prob_crossover    : a float value presents crossover probability
%
% Outputs:
%     f                 : a m * n matrix presents children

[L, W]     = size(Parent);
order_rand = randperm(L);
f          = zeros(L, W);
temp       = zeros(1, W);
lp         = W - 1;

for i = 2 : 2 : L
    prob_rand  = rand;
    parent1    = Parent(order_rand(i - 1), :);
    parent2    = Parent(order_rand(i), :);

    if (prob_rand <= prob_crossover)
        sp                = randi([1, lp - 1]);
        ep                = randi([sp, lp]);
        
        % offspring 1
        temp(sp: ep)      = parent1(sp : ep);
        element_rest      = parent2(ismember(parent2(1 : end - 1), temp(sp : ep)) == 0);
        temp(ep + 1 : lp) = element_rest(1 : (lp - ep));
        temp(1 : sp - 1)  = element_rest((lp - ep + 1) : end);
        temp(end)         = temp(1);
        
        f(i - 1, :)       = temp;
        
        % offspring 2
        temp(sp: ep)      = parent2(sp : ep);
        element_rest      = parent1(ismember(parent1(1 : end - 1), temp(sp : ep)) == 0);
        temp(ep + 1 : lp) = element_rest(1 : (lp - ep));
        temp(1 : sp - 1)  = element_rest((lp - ep + 1) : end);
        temp(end)         = temp(1);
        
        f(i, :)           = temp;
        
    else
        f(i - 1, :)       = parent1;
        f(i, :)           = parent2;
    end
end

end