% Titlu: Tema 7
% Autor: Ana-Cristina Rogoz
% Grupa: 332

%%%%%%%%%%%%%%
% Exercitiul 1
%%%%%%%%%%%%%%

f1 = @(x,y) x.^2 + y.^2 - 4
f2 = @(x,y) x.^2/8 - y

% Sa se calculeze simbolic Jacobianul sistemului.
syms x y
j11_simbolic(x,y) = diff(f1(x,y), x);
j12_simbolic(x,y) = diff(f1(x,y), y);
j21_simbolic(x,y) = diff(f2(x,y), x);
j22_simbolic(x,y) = diff(f2(x,y), y);

j11 = matlabFunction(j11_simbolic);
j12 = matlabFunction(j12_simbolic);
j21 = matlabFunction(j21_simbolic);
j22 = matlabFunction(j22_simbolic);

% Sa se construiasca grafic cele doua curbe.  
figure
ezplot(f1, [-3 3 -3 3]);
hold on
ezplot(f2, [-3 3 -3 3]);

% Sa se afle punctele de intersectie apeland procedura Newton. 
x1 = [-2; 1];
eps = 10^(-6);
[x_aprox1, N1] = Newton(f1, f2, j11, j12, j21, j22, x1, eps);
% x_aprox1 = [-1.943; 0.4721], N1 = 4

x2 = [2; 1];
eps = 10^(-6);
[x_aprox2, N2] = Newton(f1, f2, j11, j12, j21, j22, x2, eps);
% x_aprox2 = [1.943; 0.4721], N1 = 4

% Sa se construiasca pe graficul curbelor punctele de intersectie. 
plot([x_aprox1(1) x_aprox2(1)], [x_aprox1(2) x_aprox2(2)], '*r'); 
title("Puncte de intersectie");

% Matricea Jacobiana calculat folosind diferente finite. 
x1 = [-2; 1];
eps = 10^(-6);
[x_aprox_finit1, N_aprox_finite1] = NewtonAproximari(f1, f2, x1, eps);
% x_aprox_finit1 = [-1.943; 0.4721], N_aprox_finite1 = 5

x2 = [2; 1];
eps = 10^(-6);
[x_aprox_finit2, N_aprox_finite2] = NewtonAproximari(f1, f2, x2, eps);
% x_aprox_finit2 = [1.943; 0.4721], N_aprox_finite2 = 5

%%
%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%

f1 = @(x1,x2) x1.^2 - 10.* x1 + x2.^2 + 4
f2 = @(x1,x2) x1 .* x2.^2 + x1 - 10 * x2 + 8

% Sa se calculeze simbolic Jacobianul sistemului.
syms x1 x2
j11_simbolic(x1,x2) = diff(f1(x1,x2), x1);
j12_simbolic(x1,x2) = diff(f1(x1,x2), x2);
j21_simbolic(x1,x2) = diff(f2(x1,x2), x1);
j22_simbolic(x1,x2) = diff(f2(x1,x2), x2);

j11 = matlabFunction(j11_simbolic);
j12 = matlabFunction(j12_simbolic);
j21 = matlabFunction(j21_simbolic);
j22 = matlabFunction(j22_simbolic);

% Sa se construiasca grafic cele doua curbe.  
figure
ezplot(f1, [0 5 0 5]);
hold on
ezplot(f2, [0 5 0 5]);

% Sa se afle punctele de intersectie apeland procedura Newton. 
x1 = [1; 1];
eps = 10^(-6);
[x_aprox1, N1] = Newton(f1, f2, j11, j12, j21, j22, x1, eps);
% x_aprox1 = [0.50;0.89], N1 = 4

x2 = [2; 3];
eps = 10^(-6);
[x_aprox2, N2] = Newton(f1, f2, j11, j12, j21, j22, x2, eps);
% x_aprox2 = [2.03, 3.49], N2 = 5 

% Sa se construiasca pe graficul curbelor punctele de intersectie. 
plot([x_aprox1(1) x_aprox2(1)], [x_aprox1(2) x_aprox2(2)], '*r'); 
title("Puncte de intersectie");

% Matricea Jacobiana calculat folosind diferente finite. 
x1 = [1; 1];
eps = 10^(-6);
[x_aprox_finit1, N_aprox_finite1] = NewtonAproximari(f1, f2, x1, eps);
% x_aprox1 = [0.50;0.89], N1 = 4

x2 = [2; 3];
eps = 10^(-6);
[x_aprox_finit2, N_aprox_finite2] = NewtonAproximari(f1, f2, x2, eps);
% x_aprox2 = [2.03, 3.49], N2 = 5 

%%
%%%%%%%%%%%%%%
% Exercitiul 4
%%%%%%%%%%%%%%

f = @(x) sin(x)

% 2) 
n = 3;
a = -pi/2;
b = pi/2;
x = linspace(a,b, n+1)';
y = f(x); 
div = linspace(a,b,100);

% Metoda directa. 
figure
plot(div, f(div));
hold on
rez_directa = MetodaDirecta(x,y, div); 
plot(div, rez_directa, '*g');

% Metoda Lagrange
figure
plot(div, f(div));
hold on
rez_Lagrange = MetodaLagrange(x,y, div); 
plot(div, MetodaLagrange(x,y, div), 'ob');

% Metoda Newton
figure
plot(div, f(div));
hold on
rez_Newton = MetodaNewton(x,y, div);
plot(div, rez_Newton, '*r');

% 3) - eroarea |f - Pn|
y = f(div);
figure
plot(sort(abs(y - rez_directa), 'desc'), 'or');
figure 
plot(sort(abs(y - rez_Lagrange), 'desc'), '*b');
figure 
plot(sort(abs(y - rez_Newton), 'desc'), '*g');

% 4) 
% Odata crescut gradul polinomului, acesta aproximeaza mult mai bine
% functia f. Pentru n = 10, toate cele trei variante au eroarea maxima de
% ordinul 10^(-8). Continuand, cu cat n este mai mare cu atat eroare devine
% din ce in ce mai mica, pana in jurul valorii n = 60. Pentru acest n,
% polinomul metodei Newton incepe sa isi piarda caracterul. Pentru n = 65, 
% polinomul metodei Newton este complet gresit, iar cel al metodei Lagrange
% incepe sa isi piarda de asemenea caracterul. De asemenea, metoda directa
% continua sa aproximeze bine functia data. 

%%%%%%%%%%%%%%
% Functii 
%%%%%%%%%%%%%%

%%%%%%%%%%%%%%
% Exercitiul 1, 2
%%%%%%%%%%%%%%
function [xaprox, N] = Newton(f1, f2, j11, j12, j21, j22, x0, eps) 

N = 1; 
J = [j11(x0(1), x0(2)) j12(x0(1), x0(2)); j21(x0(1), x0(2)) j22(x0(1), x0(2))];
F = [f1(x0(1), x0(2)); f2(x0(1), x0(2))];

Z = J\(-F);
x1 = x0 + Z;

while(norm(Z) >= eps)
    x0 = x1;
    J = [j11(x0(1), x0(2)) j12(x0(1), x0(2)); j21(x0(1), x0(2)) j22(x0(1), x0(2))];
    F = [f1(x0(1), x0(2)); f2(x0(1), x0(2))];
    
    Z = J\(-F);
    x1 = x0 + Z;
    N = N + 1;
end

xaprox = x1;
end

% Matricea Jacobian calculata aproximativ folosind diferente finite.   
function [xaprox, N] = NewtonAproximari(f1, f2, x0, eps) 

h = 0.01
N = 1;

j11_aprox = (f1(x0(1) + h, x0(2)) - f1(x0(1), x0(2))) / h;
j12_aprox = (f1(x0(1), x0(2) + h) - f1(x0(1), x0(2))) / h;
j21_aprox = (f2(x0(1) + h, x0(2)) - f2(x0(1), x0(2))) / h;
j22_aprox = (f2(x0(1), x0(2) + h) - f2(x0(1), x0(2))) / h;
J = [j11_aprox j12_aprox; j21_aprox j22_aprox];
F = [f1(x0(1), x0(2)); f2(x0(1), x0(2))];

Z = J\(-F);
x1 = x0 + Z;

while(norm(Z) >= eps)
    x0 = x1;
    j11_aprox = (f1(x0(1) + h, x0(2)) - f1(x0(1), x0(2))) / h;
    j12_aprox = (f1(x0(1), x0(2) + h) - f1(x0(1), x0(2))) / h;
    j21_aprox = (f2(x0(1) + h, x0(2)) - f2(x0(1), x0(2))) / h;
    j22_aprox = (f2(x0(1), x0(2) + h) - f2(x0(1), x0(2))) / h;
    J = [j11_aprox j12_aprox; j21_aprox j22_aprox];
    F = [f1(x0(1), x0(2)); f2(x0(1), x0(2))];
    
    Z = J\(-F);
    x1 = x0 + Z;
    N = N + 1;
end

xaprox = x1;
end

%%%%%%%%%%%%%%
% Exercitiul 4
%%%%%%%%%%%%%%
% 1
% a)
function y = MetodaDirecta(X, Y, x)

N = length(X);
for i = 1: N
    A(:, i) = X.^(i-1);
end

a = A\Y;
y = zeros(1, length(x));
for i = 1:N 
    y = y + a(i)*x.^(i-1);
end

end

% b)
function y = MetodaLagrange(X, Y, x) 

N = length(X);
y = 0;
for k = 1:N
    valori_x = X(1:(k-1));
    if (k ~= N) 
        valori_x = [valori_x; X((k+1):N)];
    end
    numarator = prod(ones(N-1, 1) * x  - valori_x);
    
    numitor = prod(X(k) * ones(N-1, 1) - valori_x);
    L =  numarator ./ numitor ;
    y = y + L * Y(k);
end

end

% c)
function y = MetodaNewton(X, Y, x)

n = length(X);
coeficienti = [ones(n, 1) zeros(n, n - 1)];
for i = 2:n
    for j = 2:i
        coeficienti(i,j) = prod(X(i) * ones(j-1, 1) - X(1:j-1));
    end
end

coef_rez = subsAsc(coeficienti, Y);

y = coef_rez(1) .* ones(1,length(x));

for i = 2:n
    produs = coef_rez(i) .* prod(ones(i-1, 1) * x - X(1:i-1), 1);
    y = y + produs;
end

end 

function x = subsAsc(A, b)

n = length(b);
x = zeros(1, n); 
x(1) = b(1) / A(1,1);

for i = 2:1:n 
   x(i) = (b(i) - A(i, 1:i-1) * x(1:i-1)') / A(i, i);
end

end
