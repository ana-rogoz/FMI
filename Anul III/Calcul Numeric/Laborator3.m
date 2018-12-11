% ex 1 din tema 2 pe hartie -> adus lab viitor
% ex 2,3 -> pe mail

eps = 10^(-20)
A =  [eps 1; 1 1]
b = [1 ; 2]

solutie = GaussFaraPivotare(A, b)

solutiePivotarePartiala = GaussCuPivotarePartiala(A, b)

A = [1 eps; 1 1]
b = [eps;2]
solutiePivotarePartiala2 = GaussCuPivotarePartiala(A, b)

function x = subsDesc(A, b)

n = length(b)
x = zeros(1, n) 
x(n) = b(n) / A(n,n)


for i = n-1:-1:1 
   x(i) = (b(i) - A(i, i+1:n) * x(i + 1 : n)') / A(i, i);
end

end

function x = GaussFaraPivotare(A, b)

Aextins = [A b]

n = length(b);
x = zeros(1, n); 

for k = 1:n-1
    p = -1;
    for i = k:n
        if Aextins(i,k) ~= 0
            p = i;
            break;
        end
    end
    if p == -1
        disp('Sistem incompatibil sau compatibil nedeterminat');
        return;
    end
    
    Aextins([p k], :) = Aextins([k p], :) 
    for i = k + 1:n
        Aextins(i, :) = Aextins(i, :) - (Aextins(i,k) / Aextins(k,k))*Aextins(k, :) 
    end
end

if Aextins(n,n) == 0
  disp('Sistem incompatibil sau compatibil nedeterminat');
  return;
end

x = subsDesc(Aextins(:, 1:n), Aextins(:, n + 1))
end


function x = GaussCuPivotarePartiala(A, b)

Aextins = [A b]

n = length(b);
x = zeros(1, n); 

for k = 1:n-1
    p = k;
    for i = k + 1:n
        if Aextins(i,k) > Aextins(p, k)
            p = i;
        end
    end
    if abs(Aextins(p, k)) == 0 
        disp('Sistem incompatibil sau compatibil nedeterminat');
        return;
    end
    
    Aextins([p k], :) = Aextins([k p], :) 
    for i = k + 1:n
        Aextins(i, :) = Aextins(i, :) - (Aextins(i,k) / Aextins(k,k))*Aextins(k, :) 
    end
end

if Aextins(n,n) == 0
  disp('Sistem incompatibil sau compatibil nedeterminat');
  return;
end

x = subsDesc(Aextins(:, 1:n), Aextins(:, n + 1))
end