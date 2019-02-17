% Titlu: Tema 9
% Autor: Ana-Cristina Rogoz
% Grupa: 332

%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%
n = 3;
a = -pi/2;
b = pi/2;
div = linspace(a,b,100);
syms Xsym
f = @ (x) sin (x)
df = matlabFunction(diff(f(Xsym)));

X = linspace(a, b, n + 1);
X = sort([X,X]);
Y = f(X);
Z = df(X);

figure
[H,dH] = MetHermiteDD(X, Y, Z, Xsym);
plot(div, f(div));
hold on
plot(div, subs(H, Xsym, div), '*r');
title("Functia sin(x)");
legend('Functia sin(x)', 'Hermite cu DD');

figure, hold on
plot(div, df(div));
plot(div, subs(dH, Xsym, div), '*k');
title("Derivata functiei sin(x)");
legend('Functia sin(x)', 'Hermite cu DD');



y = f(div);
y_Hermite = subs(H, Xsym, div);
figure 
plot(abs(y - y_Hermite), '*b');
title('Graficul erorii folosind metoda Hermite cu DD');

%% 
%%%%%%%%%%%%%%
% Exercitiul 4
%%%%%%%%%%%%%%
% b)
f = @ (x) sin (x)
a = -pi/2;
b = pi/2;
div = linspace(a,b,100);

n = 2;

X = linspace(a, b, n + 1);
Y = f(X)

y = zeros(100, 1);
for i = 1:100
    y(i) = MetSpline(X, Y, div(i)); 
end

figure
plot(div, f(div), 'r');
hold on
plot (div, y, '*g');
title('3 noduri de interpolare');

n = 4;

X = linspace(a, b, n + 1);
Y = f(X)

y = zeros(100, 1);
for i = 1:100
    y(i) = MetSpline(X, Y, div(i)); 
end

figure
plot(div, f(div), 'r');
hold on
plot (div, y, '*g');
title('5 noduri de interpolare');

n = 10;

X = linspace(a, b, n + 1);
Y = f(X)

y = zeros(100, 1);
for i = 1:100
    y(i) = MetSpline(X, Y, div(i)); 
end

figure
plot(div, f(div), 'r');
hold on
plot (div, y, '*g');
title('11 noduri de interpolare');

% e)
n = 4;

X = linspace(a, b, n + 1);
Y = f(X)
y = MetSpline_Vector(X, Y, div);

figure
plot(div, f(div), 'r');
hold on
plot (div, y, '*g');
title('Metoda Spline pentru vector');

%%%%%%%%%%%%%%
% Functii
%%%%%%%%%%%%%%

%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%
function [y, z] = MetHermiteDD(X, Y, Z, x)

n = length(X);
Q = sym(zeros(n,n));
Q(:,1) = Y;
Q(2:2:n, 2) = Z(2:2:n);

for j = 2:n
    for i = j:n
        if (j == 2 && mod(i, 2) == 1 || j ~= 2)
            Q(i,j) = (Q(i,j-1) - Q(i-1,j-1))/(X(i) - X(i-j+1));
        end
    end
end

y = sym(0);
for i = 1:n
    term = Q(i,i);
    prod = 1;
    for j = 1:i-1
        prod = prod * (x-X(j));
    end
    y = y + term * prod;
end

z = diff(y, x);
end

%%%%%%%%%%%%%%
% Exercitiul 4
%%%%%%%%%%%%%%
% a) 
function y = MetSpline(X,Y,x)

n = length(X);

a = zeros(1,n);
b = zeros(1,n);

for j = 1:n-1
    a(j) = Y(j);
    b(j) = (Y(j+1) - Y(j)) / (X(j+1) - X(j));
end

S = 0 
for j = 1:n-1
    if (x >= X(j) &&  x <= X(j+1))
        S = a(j) + b(j)*(x-X(j));
        break;
    end
end

y = S;
end

% e)
function y = MetSpline_Vector(X,Y,x)

n = length(X);

a = zeros(1,n);
b = zeros(1,n);

for j = 1:n-1
    a(j) = Y(j);
    b(j) = (Y(j+1) - Y(j)) / (X(j+1) - X(j));
end
 
m = length(x);
S = zeros(m, 1);
for i = 1:m 
    for j = 1:n-1
        if (x(i) >= X(j) &&  x(i) <= X(j+1))
            S(i) = a(j) + b(j)*(x(i)-X(j));
            break;
        end
    end
end

y = S;
end
