% Ex 4 si 5 facem fara relaxari - adica doar Jacobi, Jacobi DDL si G-S

A = [0.2 0.01 0; 0 1 0.04; 0 0.02 1];
b = [1;2;3];

eps = 10^(-5);

[x, iteratii] = MetJacobi(A, b, eps);


function [x, nr_iteratii] = MetJacobi(A, b, eps)

n = length(A);
N = eye(n);

nr_iteratii = 0;

x = zeros(n,1);

% la DDL verif ca A e DDL si la G-S verif ca A sim si poz def 

if norm(N - A) >= 1 
    disp ("Nu converge");
    return;
end

while true
    nr_iteratii = nr_iteratii + 1;
    x_curent = (N - A) * x + b;
    if (norm(x_curent - x) < eps)
        break;
    end
    x = x_curent;
end

x = x_curent;
end