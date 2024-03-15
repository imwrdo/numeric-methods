function Zad_7

[numer_indeksu, Edges, I, B, A, b, r] = page_rank();
plot_PageRank(r);
end


function [numer_indeksu, Edges, I, B, A, b, r] = page_rank()
numer_indeksu = 201267;
L1 = floor(mod(numer_indeksu / 10, 10)); % value: 6
L2 = floor(mod(numer_indeksu / 100, 10));% value: 2
from_8 = mod(L1, 7)+1; % value:7
to_8 = mod(L2, 7)+1; % value: 3
d = 0.85;
N = 8;
Edges = [1,1,2,2,2,3,3,3,4,4,5,5,6,6,7,8,to_8;
         4,6,3,4,5,5,6,7,5,6,4,6,4,7,6,from_8,8];
I = speye(N);
B = sparse(Edges(2,:), Edges(1,:), 1,N,N);

A = spdiags(1./sum(B)', 0, N, N);
b = ((1 - d) / N) * ones(N, 1);
r = (I - d * B * A) \ b;
end

function plot_PageRank(r)
bar(r);
xlabel("Strony");
ylabel("PR");
title("Siec");
print -dpng zadanie7.png 
end
