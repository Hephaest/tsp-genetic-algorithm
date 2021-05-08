function f = mutation(Child, prob_mutation)
% Children mutation.
% Children have a probability of being mutated. Further, the probability of 
% being swapped, flipped and slid is different, which promises varieties.
%
% Inputs:
%     Child            : a m * n matrix presents children
%     prob_mutation    : a float value presents mutation probability
%
% Outputs:
%     f                 : a m * n matrix presents mutated children



[L, W]     = size(Child);
f          = zeros(L, W);
lp         = W - 1;

prob_swap  = 0.3;
prob_flip  = 0.5;
prob_slide = 1.0;

for i = 1 : L
    prob_mut  = rand;
    temp      = Child(i, :);
    indexes   = sort(randperm(lp, 2));
    sp        = indexes(1);
    ep        = indexes(2);
    

    if (prob_mut <= prob_mutation)
        
        prob_rand = rand;
        
        % Swap
        if (prob_rand <= prob_swap)
            temp(sp)      = Child(i, ep);
            temp(ep)      = Child(i, sp);
            temp(end)     = temp(1);
            f(i, :)       = temp;
            continue;
        end
        
        % Flip
        if (prob_rand <= prob_flip)
            temp(sp : ep) = fliplr(temp(sp : ep));
            temp(end)     = temp(1);
            f(i, :)       = temp;
            continue;
        end
        
        % Slide
        if (prob_rand <= prob_slide)
            temp(sp : ep) = circshift(temp(sp : ep), -1);
            temp(end)     = temp(1);
            f(i, :)       = temp;
            continue;
        end

    else
        f(i, :) = temp;
    end
end

end