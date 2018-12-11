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

y = MetSpline(X,Y,Xsym);
figure 
plot (div, f(div));
hold on
plot(div, subs(y, Xsym, div), '*r');

%%
figure
[H,dH] = MetHermiteDD(X, Y, Z, Xsym);
plot(div, f(div));
hold on
plot(div, subs(H, Xsym, div), '*r');
figure, hold on
plot(div, df(div));
plot(div, subs(dH, Xsym, div), '*k');

%%

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

function y = MetSpline(X,Y,x)

n = length(X);

a = zeros(1,n);
b = zeros(1,n);

for j = 1:n-1
    a(j) = Y(j);
    b(j) = (Y(j+1) - Y(j)) / (X(j+1) - X(j));
end

S = sym(0)
for j = 1:n-1
    if (int(x) >= X(j) && int(x) <= X(j+1))
        S = a(j) + b(j)*(x-X(j));
        break;
    end
end

y = S;
end