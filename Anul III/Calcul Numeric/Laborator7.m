f = @(x) x.^4 + 2*x.^2 - x - 3;
g = @(x) (3 + x - 2*x.^2).^(1/4);

a = -1;
b = 3/2;

% c)
figure
plot([a b b a a], [a a b b a], 'LineWidth', 3);
x = linspace(a,b,100);
hold on
plot(x, g(x), 'r');

plot(x,x, 'k');

% d)
figure
syms arg
dg = matlabFunction(diff(g(arg)));
plot(x, dg(x), '-b');
hold on
plot([a b], [-1 -1], '-k');
plot([a b], [1 1], '-k');
% nu putem aplica metoda pe tot [a,b], deoarece nu e toata derivata intre 
% -1 si 1; incercam pe alt interval: [0.8, 1.25]

a = 0.8;
b = 1.25;
figure
plot([a b b a a], [a a b b a], 'LineWidth', 3);
x = linspace(a,b,100);
hold on
plot(x, g(x), 'r');

plot(x,x, 'k');

figure
syms arg
dg = matlabFunction(diff(g(arg)));
plot(x, dg(x), '-b');
hold on
plot([a b], [-1 -1], '-k');
plot([a b], [1 1], '-k');

a = 0.8;
b = 1.27;
figure
plot([a b b a a], [a a b b a], 'LineWidth', 3);
x = linspace(a,b,100);
hold on
plot(x, g(x), 'r');

plot(x,x, 'k');

figure
syms arg
dg = matlabFunction(diff(g(arg)));
plot(x, dg(x), '-b');
hold on
plot([a b], [-1 -1], '-k');
plot([a b], [1 1], '-k');

x_sol = pctFix(g, 1, 10^(-4));
figure 
x = linspace(a,b, 100);
plot(x, f(x), '-b');
hold on
plot(x_sol, f(x_sol), 'og', 'MarkerSize', 10);


function x_sol = pctFix(g, x0, eps)
x1 = g(x0);
while (abs(x1 - x0) >= eps)
    x0 = x1;
    x1 = g(x0);
end
x_sol = x1;
end

% Tema ex3, ex 4 (la b) nu merge), nu facem 5), 

% facem 6 - indicatii: G = @(x,y) [G1(x,y), G2(x, y)]
% x1 = G(x0(1), x0(2))
% d) syms x y 
% F1 = x^2 - 10y + y^2 8
% fimplicit(F1, [0 1.5 0 1.5]);

% e)
% x_sol = ....
% plot(x_sol(1), x_sol(2), 'o');