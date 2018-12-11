% Titlu: Tema 8
% Autor: Ana-Cristina Rogoz
% Grupa: 332

%%%%%%%%%%%%%%
% Exercitiul 5
%%%%%%%%%%%%%%

% 2) 
n = 3;
a = -pi/2;
b = pi/2;
div = linspace(a,b,100);
syms Xsym
f = @ (x) sin (x)

X = linspace(a, b, n + 1);
Y = f(X);

% MetNeville
figure
y = MetNeville(X,Y,Xsym);
rez_Neville = subs(y, Xsym, div);
plot(div, f(div));
hold on
plot(div, rez_Neville, '*r');
title('Plot metoda Neville');

% MetNDD
figure
y = MetNDD(X,Y,Xsym);
rez_NDD = subs(y, Xsym, div);
plot(div, f(div));
hold on
plot(div, rez_NDD, '*g');
title('Plot metoda Newton cu diferente divizate');

% MetHermite
df = matlabFunction(diff(f(Xsym)));
Z = df(X);
[H,dH] = MetHermite(X, Y, Z, Xsym);
rez_Hermite = subs(H, Xsym, div);

figure
plot(div, f(div));
hold on
plot(div, rez_Hermite, '*b');
title('Plot metoda Hermite');

figure
plot(div, df(div));
hold on
plot(div, subs(dH, Xsym, div), '*k');

% 3) 
y = f(div);
figure
plot(sort(abs(y - rez_Neville), 'desc'), 'or');
figure 
plot(sort(abs(y - rez_NDD), 'desc'), '*b');

%%%%%%%%%%%%%%
% Functii
%%%%%%%%%%%%%%

%%%%%%%%%%%%%%
% Exercitiul 5
%%%%%%%%%%%%%%
% 1)
% a)
function y = MetNeville(X,Y,x)

n = length(X);
Q = sym(zeros(n,n));
Q(:,1) = Y;

for j = 2:n
    for i = j:n
        Q(i,j) = ((x-X(i-j+1))*Q(i,j-1) - (x-X(i))*Q(i-1,j-1))/(X(i) - X(i-j+1));
    end
end

y = Q(n,n);
end

% b)
function y = MetNDD(X,Y,x)

n = length(X);
Q = sym(zeros(n,n));
Q(:,1) = Y;

for j = 2:n
    for i = j:n
        Q(i,j) = (Q(i,j-1) - Q(i-1,j-1))/(X(i) - X(i-j+1));
    end
end

y = 0;
for i = 1:n
    term = Q(i,i);
    prod = 1;
    for j = 1:i-1
        prod = prod * (x-X(j));
    end
    y = y + term * prod;
end

end

% c)
function [H, dH] = MetHermite(X, Y, Z, Xsym)

H = sym(0);
n = length(X);
for k = 1:n
   L = sym(1);
   for i = 1:n
     if i ~= k
        L = L * (Xsym - X(i)) / (X(k) - X(i));
     end
   end
   dL = diff(L);

   dLk = subs(dL, Xsym, X(k));
   HK = (1-2*dLk*(Xsym - X(k)))*L^2; 
   K = (Xsym - X(k))*L^2; 
   H = H + HK * Y(k) + K*Z(k);
end


dH = diff(H);
end