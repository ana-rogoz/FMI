% Titlu: Tema 4
% Autor: Ana-Cristina Rogoz
% Grupa: 332


%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%
A = [1 1 0; 1 0 1; 0 1 1];
b = [1;2;5];

[q_givens, r_givens, x_givens] = Givens(A, b);

%%%%%%%%%%%%%%
% Exercitiul 4
%%%%%%%%%%%%%%
A = [3 1 1; 1 3 1; 1 1 3];
eps = 10 ^ (-4);
[valori_proprii] = Jacobi(A, eps);

%%%%%%%%%%%%%%
% Functii 
%%%%%%%%%%%%%%

%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%
function [Q,R,x] = Givens(A, b)

n = length(A);
Q = eye(n);
R = zeros(n,n);

for i = 1:n 
    for j = i + 1:n 
    sigma = sqrt(A(i,i)^2 + A(j,i)^2);
    c = A(i,i) / sigma;
    s = A(j,i) / sigma;
    A([i,j], :) = [A(i,:) * c + A(j,:) * s; -A(i,:) * s + A(j,:) * c]; 
    LQ = Q(i, :);
    Q(i, :) = Q(i, :) * c + Q(j, :) * s;
    Q(j, :) = -LQ * s + Q(j, :) * c;
    
    end
end

R = A;
Q = Q';
x = subsDesc(R, Q'*b);
end

function x = subsDesc(A, b)

n = length(b);
x = zeros(1, n); 
x(n) = b(n) / A(n,n);

for i = n-1:-1:1 
   x(i) = (b(i) - A(i, i+1:n) * x(i + 1 : n)') / A(i, i);
end

end

%%%%%%%%%%%%%%
% Exercitiul 4
%%%%%%%%%%%%%%
function [lambda] = Jacobi(A, eps)

n = length(A);
lambda = zeros(1, n);

while true
    modul = 0;
    for i = 1:n
        for j = 1:n
            if i ~= j
                modul = modul + A(i,j)^2;
            end
        end
    end
    
    if (sqrt(modul) < eps)
       break;
    end
    
    p = 1;
    q = 2;
    for i = 1:n
        for j = i+1:n
            if (abs(A(i,j)) > abs(A(p,q)))
                p = i;
                q = j;
            end
        end
    end
    if A(p,p) == A(q,q)
        teta = deg2rad(45);
    else
        teta = atan(2*A(p,q) / (A(q,q) - A(p,p))) / 2;
    end
    
    c = cos (teta);
    s = sin (teta);
    
    for j = 1:n
        if j ~= p && j ~= q
            u = A(p,j) * c - A(q,j) * s;
            v = A(p,j) * s + A(q,j) * c;
            A(p,j) = u;
            A(q,j) = v;
            A(j,p) = u;
            A(j,q) = v;
        end
    end
    u = c^2 * A(p,p) - 2 * c * s * A(p,q) + s^2 * A(q,q);
    v = s^2 * A(p,p) + 2 * c * s * A(p,q) + c^2 * A(q,q);
    A(p,p) = u;
    A(q,q) = v;
    A(p,q) = 0;
    A(q,p) = 0;
end
for i = 1:n
    lambda(i) = A(i,i);
end

end