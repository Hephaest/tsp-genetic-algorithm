function f = reverse(Child, prob_reverse)
% Path reverse.
% Pathes of children have a probability of being reversed. The reason of
% reverse is to shorten distance since crossed path has unnecessary distance
% cost.
%
% Inputs:
%     Child           : a m * n matrix presents children
%     prob_reverse    : a float value presents reverse probability
%
% Outputs:
%     f               : a m * n matrix presents mutated children

[L, W] = size(Child);
f      = zeros(L, W);
lp     = W - 1;

for i = 1 : L
    prob_rev  = rand;
    temp      = Child(i, :);
    indexes   = sort(randperm(lp, 2));
    sp        = indexes(1);
    ep        = indexes(2);
    
    if (prob_rev <= prob_reverse)

        % Reverse
        temp(sp : ep) = fliplr(temp(sp : ep));
        temp(end)     = temp(1);
        f(i, :)       = temp;

    else
        f(i, :) = temp;
    end
    
end

end