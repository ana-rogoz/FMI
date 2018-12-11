% Titlu: Tema 5
% Autor: Ana-Cristina Rogoz
% Grupa: 332

%%%%%%%%%%%%%%
% Exercitiul 1
%%%%%%%%%%%%%%
% a)
A = [3 1 1; 1 3 1; 1 1 3];
norma1 = normap(A, 1); % 5
norma2 = normap(A, 2); % 5
normainf = normap(A, inf); % 5

% b)
valoriProprii = Jacobi(A, 10^(-4)); % 2 5 2 
razaSpectrala = max(abs(valoriProprii)); % 5
% raza spectrala este egala cu cele 3 norme anterior calculate pentru A.

% c)
cond1 = condp(A, 1); % 3
cond2 = condp(A, 2); % 2.5
condinf = condp(A, inf); % 3

% d)
normaMatlab1 = norm(A, 1); % 5
normaMatlab2 = norm(A, 2); % 5
normaMatlabinf = norm(A, inf); % 5

condMatlab1 = cond(A, 1); % 3
condMatlab2 = cond(A, 2); % 2.5
condMatlabinf =  cond(A, inf); % 3

%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%
% a)
A = [10 7 8 7; 7 5 6 5; 8 6 10 9; 7 5 9 10];
b = [32; 23; 33; 31];
x = GaussPivTot(A, b)';

% b)
b_perturbat = [32.1; 22.9; 33.1; 30.9];
x_perturbat = GaussPivTot(A, b_perturbat)'; % [9.2;-12.6;4.5;-1.1]
dx = x_perturbat - x; % [8.2;-13.6;3.5;-2.1]
db = b_perturbat - b; % [0.1;-0.1;0.1;-0.1]
% Solutia obtinuta difera cu mult fata de prima solutie, chiar daca
% datele de intrare au fost putin perturbate. 

% c)
condInf = condp(A, inf); % 4488
raport1 = normap(dx, inf) / normap(x, inf); % = 13.60
raport2 = condInf * (normap(db, inf) / normap(b, inf)); % = 13.60
% Eroarea relativa a solutiei sistemului x este egala cu valoarea erorii
% vectorului b amplificata cu valoarea numarului de conditionare k(A) inf
% in cazul acesta. 

% d) 
A_perturbat = [10 7 8.1 7.2; 7.08 5.04 6 5; 8 5.98 9.89 9; 6.99 4.99 9 9.98];
x_perturbat = GaussPivTot(A_perturbat, b)'; % [-81;137;-34;22]
dx = x_perturbat - x; % [-82;136;-35;21]
eroare_relativa_solutie = normap(dx, inf) / normap(x, inf); % = 136
% Solutia sistemului perturbat difera cu mult mai mult decat in cazul
% precedent cand fusese perturbat b-ul. Deoarece eroarea relativa
% pentru A perturbat (= 0.0091) este de 3 ori mai mare decat cea din cazul  
% precedent pentru b (= 0.003), iar k(A) inf este in continuare relativ 
% mare (aprox. 4488), solutia sistemului are perturbari considerabile, iar
% de data aceasta eroarea relativa a solutiei sistemului este mai mica
% decat valoarea erorii matricei A amplificata cu numarul de conditionare
% k(A) inf. 

%%%%%%%%%%%%%%
% Exercitiul 5
%%%%%%%%%%%%%%
% 1 
% a) 
A = [0.2 0.01 0; 0 1 0.04; 0 0.02 1];
% Deoarece norm(eye(3) - A) = 0.8 < 1 putem aplica metoda Jacobi, iar x-ul 
% va converge la solutie
% b)
A = [4 1 2; 0 3 1; 2 4 8];
% 4 > (1 + 2), 3 > (0 + 1), 8 > (2 + 4) deci matricea este diagonal
% dominanta pe linii; se poate aplica metoda Jacobi DDL. 
% c) 
A = [4 2 2; 2 10 4; 2 4 6];
% norm(eye(3) - A) = 12.29 > 1, metoda Jacobi nu va converge. 
% A simetrica si toti minorii principali sunt pozitivi, deci metoda
% Gauss-Seidel va converge catre solutie. 

% 2
a = [1; 2; 3];
eps = 10 ^ (-5);
% a)
A = [0.2 0.01 0; 0 1 0.04; 0 0.02 1];
[x_solutie_subpunct_a, iteratii_a] = MetJacobi(A, a, eps); % [4.9;1.88;2.96], iteratii 53   
% b)
A = [4 1 2; 0 3 1; 2 4 8];
[x_solutie_subpunct_b, iteratii_b] = MetJacobiDDL(A, a, eps); % [0.07;0.65;0.02], iteratii 16
% c)
A = [4 2 2; 2 10 4; 2 4 6];
MetJacobi(A, a, eps); % Nu converge. 
[x_solutie_subpunct_c, iteratii_c] = MetGaussSeidel(A, a, eps); % [5.817714779365879e-07;-1.713311507378634e-06;0.50] iteratii 10

%%%%%%%%%%%%%%
% Functii 
%%%%%%%%%%%%%%

%%%%%%%%%%%%%%
% Exercitiul 1
%%%%%%%%%%%%%%
% a)
function [norma] = normap(A, p) 

norma = 0;

if (p == 1)
    norma = sum(abs(A(:,1)));
    n = size(A, 2);
    for i = 2:n
        if (sum(abs(A(:,i))) > norma)
            norma = sum(abs(A(:,i)));
        end
    end
elseif (p == 2)
    lambda = Jacobi(A'*A, 10^(-4));
    norma = max(sqrt(lambda));
elseif (p == inf)
    norma = sum(abs(A(1,:)));
    n = size(A, 1);
    for i = 2:n
        if (sum(abs(A(i,:))) > norma)
            norma = sum(abs(A(i,:)));
        end
    end
end

end

% c)
function [cond] = condp(A, p)
cond = normap(A, p) * normap(inv(A), p);
end

% Valori proprii. 
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

%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%
% a)
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

function x = SubsDesc(A, b)

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
function [x, nr_iteratii] = MetJacobi(A, b, eps)

n = length(A);
N = eye(n);

nr_iteratii = 0;

x = zeros(n,1);

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

function [x, nr_iteratii] = MetJacobiDDL(A, a, eps)

n = length(A);

for i = 1:n
    if (abs(A(i,i)) <= (sum(abs(A(i,:))) - A(i,i)))
        disp ("Matricea nu este diagonal dominanta pe linii.");
        return;
    end
end

x = zeros(n, 1);
nr_iteratii = 0;
I = eye(n);
D = diag(diag(A));
B = I - inv(D)*A;
b = inv(D) * a;
q = normap(B, inf);

while true
    nr_iteratii = nr_iteratii + 1;
    x_curent = B * x + b;
    if ((q^nr_iteratii / (1-q)) * normap(x_curent - x, inf) < eps)
        break;
    end
    x = x_curent;
end

x = x_curent;
end

function [x, nr_iteratii] = MetGaussSeidel(A, b, eps)

if (issymmetric(A) == 0)
    disp ("Matricea nu este simetrica.");
    return;
end

n = length(A);
for i = 1:n
    if (det(A(1:i, 1:i)) <= 0)
        disp ("Matricea nu este pozitiv definita.");
        return;
    end
end

x = zeros(n, 1);
nr_iteratii = 0;
while true
   nr_iteratii = nr_iteratii + 1;
   x_curent = zeros(n, 1);
   for i = 1:n
       for j = 1:(i-1)
         x_curent(i) = x_curent(i) - A(i,j) * x_curent(j);
       end
       for j = (i + 1):n
         x_curent(i) = x_curent(i) - A(i, j) * x(j); 
       end
       x_curent(i) = (x_curent(i) + b(i)) / A(i,i);
   end
   if (normap(x_curent - x, inf) / normap(x_curent, inf) < eps)
       break;
   end
   x = x_curent;
end

x = x_curent;
end