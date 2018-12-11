% Titlu: Tema 3
% Autor: Ana-Cristina Rogoz
% Grupa: 332


%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%
A = [4 2 2; 2 10 4; 2 4 6]
[invA, detA] = GaussJordan(A);

b = [12; 30; 10]
x = invA * b;

%%%%%%%%%%%%%%
% Exercitiul 5
%%%%%%%%%%%%%%
A = [0 1 1; 2 1 5; 4 2 1]
b = [3; 5; 1]
[L,U,x_LU] = factLU(A,b) 

%%%%%%%%%%%%%%
% Exercitiul 7
%%%%%%%%%%%%%%
A = [1 2 3; 2 5 8; 3 8 14];
b = [-5; -14; -25];
[x_Cholesky, L_Cholesky] = factCholesky(A, b);

 
%%%%%%%%%%%%%%
% Functii 
%%%%%%%%%%%%%%

%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%
function [invA, detA] = GaussJordan(A) 

n = length(A);
A = [A eye(n)];

detA = 1;
for i =  1:n
    p = 0
    for j = i:n
        if A(i,j) ~= 0
            p = j;
            break;
        end
    end
    if p == 0
        disp ('Matricea nu este inversabila!');
        return;
    end
    if i ~= p
        A([i,p], :) = A([p,i], :)
        detA = detA * (-1);
    end
    
    detA = detA * A(i,i);
    A(i, :) = A(i, :) / A(i,i);
    
    for j = 1:n
        if i ~= j
            A(j, :) = A(j, :) - A(j, i) * A(i, :);
        end
    end
end
invA = A(:, n+1:2*n);

end

%%%%%%%%%%%%%%
% Exercitiul 5
%%%%%%%%%%%%%%
% a) 
function x = subsAsc(A, b)

n = length(b);
x = zeros(1, n); 
x(1) = b(1) / A(1,1);

for i = 2:1:n 
   x(i) = (b(i) - A(i, 1:i-1) * x(1:i-1)') / A(i, i);
end

end

% b) 
function [L, U, x] = factLU(A, b)

n = length(A);
U = A;
L = eye(n);
P = eye(n);

for k = 1:n
    p = k;
    for i = k + 1 :n 
        if abs(U(i,k)) > abs(U(p,k)) 
            p = i;
        end
    end
    
    if abs(U(p,k)) == 0
        disp ('Matricea nu este inversabila!');
        return;
    end
    if p ~= k
        U([p k], :) = U([k p], :)
        P([p,k], :) = P([k p], :) 
    end
    if ( k >=2 )
        L([p k], 1:k-1) = L([k p ], 1:k-1);
    end
    for l = k + 1:n
        L(l,k) = U(l,k) / U(k,k);
        U(l, :) = U(l, :) - L(l,k) * U(k, :);
    end
end

y = subsAsc(L, P*b)
x = subsDesc(U, y)

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
% Exercitiul 7
%%%%%%%%%%%%%%
function [x, L] = factCholesky(A, b) 

n = length(b);
L = zeros(n,n);

alpha = A(1,1);
if (alpha <= 0)
    disp ('Matricea nu este pozitiv definita');
        return;
end
L(1,1) = sqrt(alpha);
for i = 2:n 
    L(i,1) = A(i,1) / L(1,1);
end

for k = 2:n
    alpha = A(k,k) - sum(L(k, 1:k-1).^2);
    if alpha <= 0
        disp ('Matricea nu este pozitiv definita');
        return;
    end
    L(k,k) = sqrt(alpha);
    
    for i = k + 1:n
        L(i,k) = (A(i,k) - L(i,1:k-1)*L(k,1:k-1)') / L(k,k);
    end
end
y = subsAsc(L, b);
x = subsDesc(L', y);

end



