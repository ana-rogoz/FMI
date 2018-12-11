% 3 si 6 pe foaie 


A = [4 2 2; 2 10 4; 2 4 6]

[invA, detA] = GaussJordan(A);

b = [12; 30; 10]

x = invA * b;

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


function [L, U, x] = factLU(A, b)

n = length(A);
U = A;
L = eye(n);
P = eye(n);

for k = 1:n
    % det piv partial cu PivPart
    % aleg pivot |apk| = max |aik| i de la k la n
    p = k;
    for i = k + 1:n 
        if (A(i,k) > A(p,k))
            p = i;
        end
    end
    
    if p ~= k
        U([p k], :) = U([k p], :)
        P([p,k], :) = P([p k], :)
    end
    for l = k + 1:n
        L(l,k) = U(l,k) / U(k,k);
        U(l, :) = U(l, :) - L(l,k) * U(k, :);
    end
end

y = subsAsc(L, P*b)
x = subsDesc(U, y)

end
