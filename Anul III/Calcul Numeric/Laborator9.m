n = 3;
a = -pi/2;
b = pi/2;
div = linspace(a,b,100);
syms Xsym
f = @ (x) sin (x)

df = matlabFunction(diff(f(Xsym)));
X = linspace(a, b, n + 1);
Y = f(X);
Z = df(X);

figure
[H,dH] = MetHermite(X, Y, Z, Xsym);
plot(div, f(div));
hold on
plot(div, subs(H, Xsym, div), '*r');
figure, hold on
plot(div, df(div));
plot(div, subs(dH, Xsym, div), '*k');


function [H, dH] = MetHermite(X, Y, Z, Xsym)

H = sym(0)
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