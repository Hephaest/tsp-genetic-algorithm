function f = distanceMatrix(Data)
% Generate a matrix presents distance between cities
%
% Inputs:
%     Data    : a m * 2 matrix presents X and Y positions of cities
%
% Outputs:
%     f       : a m * m matrix presents distances between cities

[L,~] = size(Data);
X     = Data(:, 1);
Y     = Data(:, 2);
f     = zeros(L);

for i = 1 : L
    for j = 1 : L
        f(i, j) = sqrt((X(i) - X(j)) ^2 + (Y(i) - Y(j)) ^2);
    end
end

end