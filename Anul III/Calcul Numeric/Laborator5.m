A = [1 1 0; 1 0 1; 0 1 1];
b = [1;2;5];

[q_givens, r_givens, x_givens] = Givens(A, b);
[q,r] = qr(A);


function [Q,R,x] = Givens(A, b)

n = length(A);
Q = eye(n);
R = zeros(n,n);

for i = 1:n 
    for j = i + 1:n 
    sigma = sqrt(A(i,i)^2 + A(j,i)^2);
    c = A(i,i) / sigma;
    s = A(j,i) / sigma;
    L = A(i, :);
    A(i, :) = A(i,:) * c + A(j,:) * s;
    A(j, :) = -L * s + A(j,:) * c;
    % A([i,j], :) = ([A(i,:) * c + A(j,:) * s, -A(i,:) * s + A(j,:) * c], :); 
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


%%


%%