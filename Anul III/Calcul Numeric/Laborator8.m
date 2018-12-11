% Ex 1

% a)
f1 = @(x,y) x.^2 + y.^2 - 4
f2 = @(x,y) x.^2/8 - y

syms x y
j11_s(x,y) = diff(f1(x,y), x);
j12_s(x,y) = diff(f1(x,y), y);
j21_s(x,y) = diff(f2(x,y), x);
j22_s(x,y) = diff(f2(x,y), y);
j11 = matlabFunction(j11_s);
j12 = matlabFunction(j12_s);
j21 = matlabFunction(j21_s);
j22 = matlabFunction(j22_s);

% b)
figure
ezplot(f1, [-3 3 -3 3]);
hold on
ezplot(f2, [-3 3 -3 3]);

% c) 
x1 = [-2; 1];
eps = 10^(-3);
[x_aprox1, N1] = Newton(f1, f2, j11, j12, j21, j22, x1, eps);

x2 = [2; 1];
eps = 10^(-5);
[x_aprox2, N2] = Newton(f1, f2, j11, j12, j21, j22, x2, eps);

title("frumy laborator");
% d)
plot([x_aprox1(1) x_aprox2(1)], [x_aprox1(2) x_aprox2(2)], '*r'); 

%% 
% Ex 3)
f = @(x) sin(x)
n = 3
a = -pi/2
b = pi/2
x = linspace(a,b,n+1)';
y = f(x) 
div = linspace(a,b,100);
figure
plot(div, f(div));
hold on
plot(div, InterpLagrange(x,y, div), '*g');


% Functii
% Ex 3) 
function [y] = InterpLagrange(X, Y, x)

N = length(X) - 1;
A = ones(N + 1, 1);
for i = 2: (N+1)
    A = [A, X.^(i-1)]
end

a = A\Y;
y = 0;
for i = 1:(N+1) 
    y = y + a(i)*x.^(i-1);
end

end

% Ex1
function [xaprox, N] = Newton(f1, f2, j11, j12, j21, j22, x0, eps) 

N = 1; 
J = [j11(x0(1), x0(2)) j12(x0(1), x0(2)); j21(x0(1), x0(2)) j22(x0(1), x0(2))];
F = [f1(x0(1), x0(2)); f2(x0(1), x0(2))];

% J11 = F1(x + h, y) - F1(x,y) / h -> aproximare cu diferente finite
% intr-un spatiu finit dimensional, normele sunt echivalente (y) 

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
