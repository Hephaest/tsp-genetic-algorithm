function f = populationMatrix(Size, Data)
% Generate a matrix presents pathes of chromosomes
%
% Inputs:
%     Data    : a m * 2 matrix presents X and Y positions of cities
%     Size    : an integer presents the number of cities
%
% Outputs:
%     f       : a m * n matrix presents population

[L,~] = size(Data);
f     = zeros(Size, L + 1);

for i = 1 : Size
    f(i, 1 : L) = randperm(L);
    f(i, end) = f(i,1);
end

end