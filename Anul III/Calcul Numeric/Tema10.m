% Titlu: Tema 10
% Autor: Ana-Cristina Rogoz
% Grupa: 332

%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%
syms Xsym
f = @ (x) sin (x)
df = matlabFunction(diff(f(Xsym)));

a = -pi/2;
b = pi/2;
div = linspace(a,b,100);

fpa = df(a);

% b), c)
n = 2;
X = linspace(a, b, n + 1);
Y = f(X);
y = zeros(100, 1);
z = zeros(100, 1);
for i = 1:100
    [y(i), z(i)] = SplineP(X, Y, fpa, div(i)); 
end

figure
plot(div, f(div), 'r');
hold on 
plot(div, y, '*g');
plot(X, Y, 'ok');
title("Plotul functiei - 3 puncte de interpolare");

figure 
plot(div, df(div), 'r');
hold on
plot(div, z, '*g');
title("Plotul derivatei - 3 puncte de interpolare");

n = 4;
X = linspace(a, b, n + 1);
Y = f(X);
y = zeros(100, 1);
z = zeros(100, 1);
for i = 1:100
    [y(i), z(i)] = SplineP(X, Y, fpa, div(i)); 
end

figure
plot(div, f(div), 'r');
hold on 
plot(div, y, '*g');
plot(X, Y, 'ok');
title("Plotul functiei - 5 puncte de interpolare");

figure 
plot(div, df(div), 'r');
hold on
plot(div, z, '*g');
title("Plotul derivatei - 5 puncte de interpolare");

n = 10;
X = linspace(a, b, n + 1);
Y = f(X);
y = zeros(100, 1);
z = zeros(100, 1);
for i = 1:100
    [y(i), z(i)] = SplineP(X, Y, fpa, div(i)); 
end

figure
plot(div, f(div), 'r');
hold on 
plot(div, y, '*g');
plot(X, Y, 'ok');
title("Plotul functiei - 11 puncte de interpolare");

figure 
plot(div, df(div), 'r');
hold on
plot(div, z, '*g');
title("Plotul derivatei - 11 puncte de interpolare");

%%
% d)
n = 10;
X = linspace(a, b, n + 1);
Y = f(X);

[y, z] = SplineP_Vector(X, Y, fpa, div); 

figure
plot(div, f(div), 'r');
hold on 
plot(div, y, '*g');
plot(X, Y, 'ok');
title("Plotul functiei - Spline vector");

figure 
plot(div, df(div), 'r');
hold on
plot(div, z, '*g');
title("Plotul derivatei - Spline vector");

%%
%%%%%%%%%%%%%%
% Exercitiul 3
%%%%%%%%%%%%%%
syms Xsym
f = @ (x) sin (x)
df = matlabFunction(diff(f(Xsym)));
ddf = matlabFunction(diff(df(Xsym)));

a = -pi/2;
b = pi/2;
div = linspace(a,b,100);

fpa = df(a);
fpb = df(b);

% b), c), d)
n = 2;
X = linspace(a, b, n + 1);
Y = f(X);
y = zeros(100, 1);
z = zeros(100, 1);
t = zeros(100, 1);
for i = 1:100
    [y(i), z(i), t(i)] = SplineC(X, Y, fpa, fpb, div(i)); 
end

figure
plot(div, f(div), 'r');
hold on 
plot(div, y, '*g');
plot(X, Y, 'ok');
title("Plotul functiei - 3 puncte de interpolare");

figure 
plot(div, df(div), 'r');
hold on
plot(div, z, '*g');
title("Plotul derivatei - 3 puncte de interpolare");

figure 
plot(div, ddf(div), 'r');
hold on
plot(div, t, '*g');
title("Plotul celei de-a doua derivate - 3 puncte de interpolare");

n = 4;
X = linspace(a, b, n + 1);
Y = f(X);
y = zeros(100, 1);
z = zeros(100, 1);
t = zeros(100, 1);
for i = 1:100
    [y(i), z(i), t(i)] = SplineC(X, Y, fpa, fpb, div(i)); 
end

figure
plot(div, f(div), 'r');
hold on 
plot(div, y, '*g');
plot(X, Y, 'ok');
title("Plotul functiei - 5 puncte de interpolare");

figure 
plot(div, df(div), 'r');
hold on
plot(div, z, '*g');
title("Plotul derivatei - 5 puncte de interpolare");

figure 
plot(div, ddf(div), 'r');
hold on
plot(div, t, '*g');
title("Plotul celei de-a doua derivate - 5 puncte de interpolare");

n = 10;
X = linspace(a, b, n + 1);
Y = f(X);
y = zeros(100, 1);
z = zeros(100, 1);
t = zeros(100, 1);
for i = 1:100
    [y(i), z(i), t(i)] = SplineC(X, Y, fpa, fpb, div(i)); 
end

figure
plot(div, f(div), 'r');
hold on 
plot(div, y, '*g');
plot(X, Y, 'ok');
title("Plotul functiei - 11 puncte de interpolare");

figure 
plot(div, df(div), 'r');
hold on
plot(div, z, '*g');
title("Plotul derivatei - 11 puncte de interpolare");

figure 
plot(div, ddf(div), 'r');
hold on
plot(div, t, '*g');
title("Plotul celei de-a doua derivate - 11 puncte de interpolare");

%%
% e)
n = 10;
X = linspace(a, b, n + 1);
Y = f(X);
y = zeros(100, 1);
z = zeros(100, 1);
t = zeros(100, 1);
[y, z, t] = SplineC_Vector(X, Y, fpa, fpb, div); 


figure
plot(div, f(div), 'r');
hold on 
plot(div, y, '*g');
plot(X, Y, 'ok');
title("Plotul functiei SplineC vector");

figure 
plot(div, df(div), 'r');
hold on
plot(div, z, '*g');
title("Plotul derivatei SplineC vector");

figure 
plot(div, ddf(div), 'r');
hold on
plot(div, t, '*g');
title("Plotul celei de-a doua derivate SplineC vector");


%%%%%%%%%%%%%%
% Functii
%%%%%%%%%%%%%%

%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%
% a)
function [y,z] = SplineP(X, Y, fpa, x)

n = length(X);

a = Y; 
b = zeros(n, 1);
c = zeros(n, 1);

b(1) = fpa;
for i = 2:n
  b(i) = 2*(Y(i) - Y(i-1))/(X(i) - X(i-1)) - b(i-1);
end

for i = 1:n-1
    c(i) = (Y(i+1) - Y(i) - b(i)*(X(i+1) - X(i)))/((X(i+1) - X(i)).^2)
end

y = 0; 
for j = 1:n-1
   if (x >= X(j) && x <= X(j+1))
    y = a(j) + b(j)*(x-X(j)) + c(j)*(x-X(j))^2;
    break;
   end
end

z = 0;
for j = 1:n-1
    if (x >= X(j) && x <= X(j+1))
      z = b(j) + 2*c(j)*(x-X(j));
      break;
    end
end

end

% d)
function [y,z] = SplineP_Vector(X, Y, fpa, x)

n = length(X);

a = Y; 
b = zeros(n, 1);
c = zeros(n, 1);

b(1) = fpa;
for i = 2:n
  b(i) = 2*(Y(i) - Y(i-1))/(X(i) - X(i-1)) - b(i-1);
end

for i = 1:n-1
    c(i) = (Y(i+1) - Y(i) - b(i)*(X(i+1) - X(i)))/((X(i+1) - X(i)).^2)
end

m = length(x)
y = zeros(m, 0); 
for j = 1:n-1
    indexes = find(x >= X(j) & x <= X(j+1));
    y(indexes) = a(j) + b(j)*(x(indexes)-X(j)) + c(j)*(x(indexes)-X(j)).^2;
end

z = zeros(m, 0);
for j = 1:n-1
    indexes = find(x >= X(j) & x <= X(j+1));
    z(indexes) = b(j) + 2*c(j)*(x(indexes)-X(j));
end

end

%%%%%%%%%%%%%%
% Exercitiul 3
%%%%%%%%%%%%%%
% a)
function [y,z,t] = SplineC(X, Y, fpa, fpb, x)

n = length(X);
h = X(2) - X(1);

a = Y; 
b = zeros(n, n);
c = zeros(n, 1);
d = zeros(n, 1);

b(1, 1) = 1;
b(n, n) = 1;

sol = zeros(n, 1);
sol(1) = fpa;
sol(n) = fpb;

for i = 2:(n-1)
  b(i, i-1) = 1;
  b(i, i) = 4;
  b(i, i+1) = 1;
  sol(i) = 3*(Y(i+1) - Y(i-1))/h;
end

eps = 10^(-8);
[b_sol, iter] = MetJacobiDDL(b, sol, eps);

for i = 1:(n-1)
    c(i) = 3*(Y(i+1) - Y(i))/(h^2) - (b_sol(i+1) + 2*b_sol(i))/h;
    d(i) = -2*(Y(i+1) - Y(i))/(h^3) + (b_sol(i+1) + b_sol(i))/(h^2);
end

y = 0; 
for j = 1:(n-1)
   if (x >= X(j) && x <= X(j+1))
    y = a(j) + b_sol(j)*(x-X(j)) + c(j)*((x-X(j))^2) + d(j)*((x-X(j))^3);
    break;
   end
end

z = 0;
for j = 1:(n-1)
    if (x >= X(j) && x <= X(j+1))
      z = b_sol(j) + 2*c(j)*(x-X(j)) + 3*d(j)*((x-X(j))^2);
      break;
    end
end

t = 0;
for j = 1:(n-1)
    if (x >= X(j) && x <= X(j+1))
      t = 2*c(j) + 6*d(j)*(x-X(j));
      break;
    end
end

end

function [y,z,t] = SplineC_Vector(X, Y, fpa, fpb, x)

n = length(X);
h = X(2) - X(1);

a = Y; 
b = zeros(n, n);
c = zeros(n, 1);
d = zeros(n, 1);

b(1, 1) = 1;
b(n, n) = 1;

sol = zeros(n, 1);
sol(1) = fpa;
sol(n) = fpb;

for i = 2:(n-1)
  b(i, i-1) = 1;
  b(i, i) = 4;
  b(i, i+1) = 1;
  sol(i) = 3*(Y(i+1) - Y(i-1))/h;
end

eps = 10^(-8);
[b_sol, iter] = MetJacobiDDL(b, sol, eps);

for i = 1:(n-1)
    c(i) = 3*(Y(i+1) - Y(i))/(h^2) - (b_sol(i+1) + 2*b_sol(i))/h;
    d(i) = -2*(Y(i+1) - Y(i))/(h^3) + (b_sol(i+1) + b_sol(i))/(h^2);
end

m = length(x);
y = zeros(m, 1); 
for j = 1:(n-1)
   indexes = find(x >= X(j) & x <= X(j+1));
   y(indexes) = a(j) + b_sol(j)*(x(indexes)-X(j)) + c(j)*((x(indexes)-X(j)).^2) + d(j)*((x(indexes)-X(j)).^3);
end

z = zeros(m,1);
for j = 1:(n-1)
    indexes = find(x >= X(j) & x <= X(j+1));
    z(indexes) = b_sol(j) + 2*c(j)*(x(indexes)-X(j)) + 3*d(j)*((x(indexes)-X(j)).^2);
end

t = zeros(m,1);
for j = 1:(n-1)
    indexes = find(x >= X(j) & x <= X(j+1));
    t(indexes) = 2*c(j) + 6*d(j)*(x(indexes)-X(j));
end

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
q = norm(B, inf);

while true
    nr_iteratii = nr_iteratii + 1;
    x_curent = B * x + b;
    if ((q^nr_iteratii / (1-q)) * norm(x_curent - x, inf) < eps)
        break;
    end
    x = x_curent;
end

x = x_curent;
end