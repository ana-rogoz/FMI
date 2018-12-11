% Titlu: Tema 2
% Autor: Ana-Cristina Rogoz
% Grupa: 332

%%%%%%%%%%%%%%
% Exercitiul 3
%%%%%%%%%%%%%%
% b) 
A_1 = [0 1 1; 
       2 1 5;
       4 2 1];
b_1 = [3; 5; 1]; 
solutie_fara_pivotare_1 = GaussFaraPiv(A_1, b_1); % [-1, 2, 1]
solutie_pivotare_partiala_1 = GaussPivPart(A_1, b_1); % [-1, 2, 1]
solutie_pivotare_totala_1 = GaussPivTot(A_1, b_1); % [-1, 2, 1]

A_2 = [0 1 -2; 
       1 -1 1;
       1 0 -1];
b_2 = [4; 6; 2]; 
solutie_fara_pivotare_2 = GaussFaraPiv(A_2, b_2); % Sistem incompatibil sau compatibil nedeterminat.
solutie_pivotare_partiala_2 = GaussPivPart(A_2, b_2); % Sistem incompatibil sau compatibil nedeterminat.
solutie_pivotare_totala_2 = GaussPivTot(A_2, b_2); % Sistem incompatibil sau compatibil nedeterminat.

% c)
eps = 10^(-20)
A_3 = [eps 1;
       1 1]
b_3 = [1; 2]
solutie_fara_pivotare_3 = GaussFaraPiv(A_3, b_3); % [0, 1] - nu este corecta
solutie_pivotare_partiala_3 = GaussPivPart(A_3, b_3); % [1, 1]
% Cele doua solutii se comporta diferit pentru sistemul dat. 
% Astfel, la intalnirea valorilor foarte mici (10^(-20)), 
% metoda Gauss fara pivotare nu reuseste sa gaseasca solutia
% corecta, pe cand Gauss cu pivotare partiala ajunge la 
% adevarata solutie a sistemului, si anume [1,1].


eps = 10^(20)
A_4 = [1 eps;
       1 1];
b_4 = [eps; 2];
solutie_pivotare_partiala_4 = GaussPivPart(A_4, b_4); % [0, 1] - nu este corecta
solutie_pivotare_totala_4 = GaussPivTot(A_4, b_4); % [1, 1]
% Cele doua solutii se comporta diferit pentru sistemul dat. 
% Astfel, la intalnirea valorilor foarte mari (10^20), 
% metoda Gauss cu pivotare partiala nu reuseste sa gaseasca solutia
% corecta, pe cand Gauss cu pivotare totala ajunge la 
% adevarata solutie a sistemului, si anume [1,1].


%%%%%%%%%%%%%%
% Functii 
%%%%%%%%%%%%%%

%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%
function x = SubsDesc(A, b)

n = length(b);
x = zeros(1, n); 
x(n) = b(n) / A(n,n);

for i = n-1:-1:1 
   x(i) = (b(i) - A(i, i+1:n) * x(i + 1 : n)') / A(i, i);
end

end

%%%%%%%%%%%%%%
% Exercitiul 3
%%%%%%%%%%%%%%
% a) 

% Gauss fara pivotare
function x = GaussFaraPiv(A, b)

Aextins = [A b];

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
        Aextins(i, :) = Aextins(i, :) - (Aextins(i,k) / Aextins(k,k))*Aextins(k, :); 
    end
end

if Aextins(n,n) == 0
  disp('Sistem incompatibil sau compatibil nedeterminat');
  return;
end

x = SubsDesc(Aextins(:, 1:n), Aextins(:, n + 1))
end

% Gauss cu pivotare partiala
function x = GaussPivPart(A, b)

Aextins = [A b];

n = length(b);
x = zeros(1, n); 

for k = 1:n-1
    p = k;
    for i = k + 1:n
        if abs(Aextins(i,k)) > abs(Aextins(p, k))
            p = i;
        end
    end
    if abs(Aextins(p, k)) == 0 
        disp('Sistem incompatibil sau compatibil nedeterminat');
        return;
    end
    
    Aextins([p k], :) = Aextins([k p], :);
    for i = k + 1:n
        Aextins(i, :) = Aextins(i, :) - (Aextins(i,k) / Aextins(k,k))*Aextins(k, :); 
    end
end

if Aextins(n,n) == 0
  disp('Sistem incompatibil sau compatibil nedeterminat');
  return;
end

x = SubsDesc(Aextins(:, 1:n), Aextins(:, n + 1));
end

% Gauss cu pivotare totala
function x = GaussPivTot(A, b)

Aextins = [A b];

n = length(b);
x = zeros(1, n); 
index = [1:n];

for k = 1:n-1
    p = k;
    m = k;
    for i = k:n
        for j = k:n  
            if abs(Aextins(i,j)) > abs(Aextins(p, m))
                p = i;
                m = j;
            end
        end
    end
    if abs(Aextins(p, m)) == 0 
        disp('Sistem incompatibil sau compatibil nedeterminat');
        return;
    end
    
    index([m k]) = index([k m]);
    Aextins([p k], :) = Aextins([k p], :); 
    Aextins(:, [m k]) = Aextins(:, [k m]); 
    for i = k + 1:n
        Aextins(i, :) = Aextins(i, :) - (Aextins(i,k) / Aextins(k,k))*Aextins(k, :); 
    end
end

if Aextins(n,n) == 0
  disp('Sistem incompatibil sau compatibil nedeterminat');
  return;
end

y = SubsDesc(Aextins(:, 1:n), Aextins(:, n + 1));
for i = 1:n
    x(index(i)) = y(i);
end

end
