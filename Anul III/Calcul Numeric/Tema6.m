% Titlu: Tema 6
% Autor: Ana-Cristina Rogoz
% Grupa: 332

%%%%%%%%%%%%%%
% Exercitiul 3
%%%%%%%%%%%%%%
f = @(x) x.^4 + 2*x.^2 - x - 3;
g = @(x) (3 + x - 2*x.^2).^(1/4);

% a) 
% daca x* este punct fix pentru g => g(x) = x 
% (3 + x - 2*x.^2).^(1/4) = x - ridicam la puterea a patra
% => 3 + x - 2*x.^2 = x.^4 => x.^4 + 2*x.^2 - x - 3 = 0 => f(x) = 0, deci
% radacina pentru f 

% b) 
% functia g este definita daca 3 + x - 2*x.^2 >= 0. Deoarece coeficientul 
% lui x.^2 este negativ, g va lua valori pozitive intre radacini. 
% delta = 1 + 4 * 3 * 2 = 25 => x1 = - (-1 - 5) / 4 = 3 / 2, 
% x2 = - (-1 + 5) / 4 = -1 => g este definit pe intervalul [-1, 3/2]

% c) 
a = -1;
b = 3/2;
figure
plot([a b b a a], [a a b b a], 'LineWidth', 3);
x = linspace(a,b,100);
hold on
plot(x, g(x), 'r');

plot(x,x, 'k');
% Graficul lui g(x) pe intervalul [a,b] ramane in interiorul patratului;
% oricare x intre [-1, 3/2], g(x) intre [-1, 3/2] 

% d) 
figure
syms arg
dg = matlabFunction(diff(g(arg)));
plot(x, dg(x), '-b');
hold on
plot([a b], [-1 -1], '-k');
plot([a b], [1 1], '-k');

% Functia g pe intervalul [a,b] ia valori in interiorul patratului, dar nu 
% putem aplica metoda pe acest interval deoarece derivata functiei
% pe [-1, 3/2] nu este cuprinsa intre (-1, 1); 

% Consideram un alt interval [0.85, 1.25]
a = 0.85; 
b = 1.25;
figure
plot([a b b a a], [a a b b a], 'LineWidth', 3);
x = linspace(a,b,100);
hold on
plot(x, g(x), 'r');

plot(x,x, 'k');
% Pe [0.85, 1.25] functia g ia valori in acest interval.

figure 
plot(x, dg(x), '-b');
hold on
plot([a b], [-1 -1], '-k');
plot([a b], [1 1], '-k');
% Derivata functiei g pe [0.85, 1.25] este cuprinsa intre (-1, 1), asadar
% putem aplica metoda punctului fix. 

% e) 
x0 = 0.85;
eps = 10^(-5);
x_punct_fix = pctFix(g, x0, eps);

a = 0.85; 
b = 1.25;
figure
x = linspace(a,b,100);
plot(x, g(x), 'r');
hold on
plot(x_punct_fix, g(x_punct_fix), 'ob');
plot(x,x, 'k');

%%%%%%%%%%%%%%
% Exercitiul 4
%%%%%%%%%%%%%%
%%
% a) 
g = @(x) ((x + 3)./(x.^2 + 2)).^(1/2);

% Daca x* este punct fix pentru g => g(x) = x => 
% ((x + 3)/(x.^2 + 2)).^(1/2) = x, ridicam la puterea a doua
%  => (x + 3)/(x.^2 + 2) = x.^2 => x + 3 = x.^4 + 2*x.^2 => 
% x.^4 + 2*x.^2 - 3 - x = 0 => f(x) = 0, deci x* radacina pentru f.

% Functia g este definita atunci cand (x + 3)/(x.^2 + 2) >= 0. Numitorul
% este strict pozitiv, iar numaratorul este >= 0 cand x + 3 >= 0 => x >= -3
% Domeniul de definitie al functiei g este [-3, inf)

% Pentru a reprezenta patratul alegem o valoare mare pentru b in loc de
% infinit pentru a vedea cum se comporta functia g. La infinit g tinde la
% zero. 
a = -3;
b = 100;
figure
plot([a b b a a], [a a b b a], 'LineWidth', 3);
x = linspace(a,b,100);
hold on
plot(x, g(x), 'r');
plot(x, x);

figure 
syms arg
dg = matlabFunction(diff(g(arg)));
plot(x, dg(x), '-b');
hold on
plot([a b], [-1 -1], '-k');
plot([a b], [1 1], '-k');

% Graficul functiei g se afla in interiorul patratului astfel ca oricare x 
% din [-3, inf), g(x) intre [-3, inf)
% Insa, g'(x) pe [-3, inf) nu apartine (-1, 1), oricare x din interval. 
% Asadar, alegem un alt interval: [a,b] = [0, 2].

a = 0;
b = 2;
figure
plot([a b b a a], [a a b b a], 'LineWidth', 3);
x = linspace(a,b,100);
hold on
plot(x, g(x), 'r');
plot(x, x);

figure 
syms arg
dg = matlabFunction(diff(g(arg)));
plot(x, dg(x), '-b');
hold on
plot([a b], [-1 -1], '-k');
plot([a b], [1 1], '-k'); 

% Putem aplica teorema punctului fix.
x0 = 0;
eps = 10^(-5);
x_punct_fix = pctFix(g, x0, eps);

a = 0; 
b = 2;
figure
x = linspace(a,b,100);
plot(x, g(x), 'r');
hold on
plot(x_punct_fix, g(x_punct_fix), 'ob');
plot(x,x, 'k');



%% 
% b) 
g = @(x) ((x + 3 - x.^4)./2).^(1/2);

% Daca x* este punct fix pentru g => g(x) = x => 
% ((x + 3 - x.^4)./2).^(1/2) = x, ridicam la puterea a doua
% => (x + 3 - x.^4)./2 = x.^2 => x + 3 - x.^4 = 2 * x.^2 => 
% x.^4 + 2*x.^2 - 3 - x = 0 => f(x) = 0, deci x* radacina pentru f.

% Functia g este definita atunci cand (x + 3 - x.^4) >= 0 (intre radacini)  
% => x1 = -1.1640, x2 = 1.4526 radacini reale. 
% Domeniul de definitie al functiei g este [-1.1640, 1.4526]

a = -1.1640;
b = 1.4526;
figure
plot([a b b a a], [a a b b a], 'LineWidth', 3);
x = linspace(a,b,100);
hold on
plot(x, g(x), 'r');
plot(x, x);

figure 
syms arg
dg = matlabFunction(diff(g(arg)));
plot(x, dg(x), '-b');
hold on
plot([a b], [-1 -1], '-k');
plot([a b], [1 1], '-k');

% Graficul functiei g se afla in interiorul patratului astfel ca oricare x 
% din [-1.1640, 1.4526], g(x) intre [-1.1640, 1.4526]
% Insa, g'(x) pe [-1.1640, 1.4526] nu apartine (-1, 1), oricare x din 
% interval.

% g'(x) este cuprins intre (-1, 1) daca x apartine [-0.86, 1.1]. 
% De asemenea, intre [-0.5 si 1.1] aproximativ, g(x) > 1.1 adica valoarea 
% maxima pe care am putea-o lua pentru ca derivata sa fie intre (-1, 1).
% Daca am luat valori intre [-0.86, -0.5], g(x) pe acel interval este 
% pozitiv deci nu va intersecta prima bisectoare si de asemenea graficul
% nu va fi in interiorul patratului. Asadar, nu putem alege un interval 
% pentru a aplica metoda punctului fix, iar x* nu ar putea converge 
% niciodatala solutia pozitiva a lui f(x) = 0 (x = 1.1241), deoarece g'(x)
% este < -1 in acel punct. 

%% 
%%%%%%%%%%%%%%
% Exercitiul 6
%%%%%%%%%%%%%%

ec1 = @(x1, x2) x1.^2 - 10*x1 + x2.^2 + 8;
ec2 = @(x1, x2) x1*x2.^2 + x1 - 10*x2 + 8;

% a) 
% "=>" Fie x* = (x1, x2) solutie a sistemului neliniar, inseamna ca 
% x1.^2 - 10*x1 + x2.^2 + 8 = 0 si x1*x2.^2 + x1 - 10*x2 + 8 = 0 =>
% x1.^2 + x2.^2 + 8 = 10 * x1 si x1*x2.^2 + x1 + 8 = 10 * x2 =>
% (x1.^2 + x2.^2 + 8) / 10 = x1 si (x1*x2.^2 + x1 + 8) / 10 = x2 =>
% G(x1, x2) = (x1, x2) = x* punct fix
% "<=" Fie x* = (x1, x2) punct fix pentru G(x1, x2), inseamna ca 
% G(x1, x2) = (x1, x2) => (x1.^2 + x2.^2 + 8) / 10 = x1 => 
% => x1.^2 + x2.^2 + 8 - 10*x1 = 0 si (x1*x2.^2 + x1 + 8)/10 = x2 =>
% x1*x2.^2 + x1 + 8 - 10*x2 = 0, deci solutie pentru sistemul neliniar dat.

% b) functia G admite un singur punct fix pe domeniul D = {(x1, x2) | 0 <=
% x1, x2 <= 1.5} <=> 
% 1) oricare (x1, x2) din D, G(x1,x2) apartine lui D^2. 
%    * luam prima ramura (x1.^2 + x2.^2 + 8) / 10 si observam ca atinge
%    valoarea minima in (0,0) si anume  4 / 5 iar valoarea maxima in (1.5,
%    1.5) si anume (1.5^2 + 1.5^2 + 8) / 10 = 1.25. Asadar prima ramura
%    este cuprinsa intre (0, 1.5).
%    * luam cea de-a doua ramura (x1*x2.^2 + x1 + 8)/10 si observam ca
%    atinge valoarea minima in (0,0) si anume 8/10 = 4/5 iar valoarea
%    maxima in (1.5, 1.5) si anume (1.5 * 1.5^2 + 1.5 + 8) / 10 = 1.28.
%    Asadar si cea de-a doua ramura este cuprinsa (0, 1.5). 
% 2) |G'(x1, x2)| <= q < 1, oricare (x1, x2) din D^2 
%    * pentru prima ramura, derivam in functie de x1 si x2. 
%      G1(x1, x2)/dx1 = 2*x1/10 este cuprins in [0, 0.3] 
%      G1(x1, x2)/dx2 = 2*x2/10 este cuprins in [0, 0.3]
%    * pentru cea de-a doua ramura, derivam in functie de x1 si x2.
%      G2(x1, x2)/dx1 = (x2^2 + 1)/10 este cuprins in [0.1, 0.325]
%      G2(x1, x2)/dx2 = 2*x1*x2 / 10 este cuprins in [0, 0.45]
%     Asadar, modulul derivatelor este strict mai mic decat 1.
% => din 1) si 2) G(x1, x2) admite un unic punct fix pe domeniul D. 
 
% c) 
g1 = @(x1, x2) (x1.^2 + x2.^2 + 8)/10;
g2 = @(x1, x2) (x1*x2.^2 + x1 + 8)/10;
x0 = [0 0];
eps = 10^(-5)
x_punct_fix = pctFix2D(g1, g2, x0, eps);
%%
% d)
syms x1 x2
F1 = x1.^2 - 10.*x1 + x2.^2 + 8;
F2 = x1*x2.^2 + x1 - 10*x2 + 8;
figure
ez1 = ezplot(F1, [0, 1.5, 0, 1.5]);
hold on
ez2 = ezplot(F2, [0, 1.5, 0, 1.5])
grid on
axis equal
set(ez1, 'color', [0 0 1]);
plot(x_punct_fix(1), x_punct_fix(2), 'or');
title('Curbele celor doua ramuri');
legend('x1^2 - 10*x1 + x2^2 + 8', 'x1*x2^2 + x1 - 10*x2 + 8', 'Punct fix');
%% 
%%%%%%%%%%%%%%
% Functii 
%%%%%%%%%%%%%%

%%%%%%%%%%%%%%
% Exercitiul 3
%%%%%%%%%%%%%%
function x_sol = pctFix(g, x0, eps)
x1 = g(x0);
while (abs(x1 - x0) >= eps)
    x0 = x1;
    x1 = g(x0);
end
x_sol = x1;
end

%%%%%%%%%%%%%%
% Exercitiul 4
%%%%%%%%%%%%%%
function x_sol = pctFix2D(g1, g2, x0, eps)
x1 = zeros(2, 1);
x1 = [g1(x0(1), x0(2)), g2(x0(1), x0(2))]
while (norm(x1 - x0) >= eps)
    x0 = x1;
    x1 = [g1(x0(1), x0(2)), g2(x0(1), x0(2))];
end
x_sol = x1;
end

