% Titlu: Tema 1
% Autor: Ana-Cristina Rogoz
% Grupa: 332

%%%%%%%%%%%%%%
% Exercitiul 1
%%%%%%%%%%%%%%
f1 = @(x) 8*x.^3 + 4.*x - 1

% k = 0;
a0 = 0;
b0 = 1;
x0 = (a0 + b0) / 2; % = 0.5
f1(a0); % = -1
f1(b0); % = 11 
f1(x0); % = 2

% f1(a0) * f1(x0) < 0
% k = 1
a1 = a0;
b1 = x0;
x1 = (a1 + b1) / 2; % = 0.25
f1(a1); % = -1
f1(b1); % = 2
f1(x1); % = 0.125

% f1(a1) * f1(x1) < 0
% k = 2
a2 = a1;
b2 = x1;
x2 = (a2 + b2) / 2; % = 0.125
f1(a2); % = -1
f1(b2); % = 0.125
f1(x2); % = -0.4844

% Solutia ecuatiei in intervalul [0,1] este: 0.2266988
% Eroarea de aproximare cand k = 2: |0.1250 - 0.2266| =  0.1016

%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%
f2 = @(x) x.^3 - 7.*x.^2 + 14.*x - 6

% b)
eps = 10 ^ (-5)
x2 = linspace(0,4, 100)
plot(x2, f2(x2), 'Linewidth', 2, 'Color', 'g')
hold on
line(xlim, [0 0])
line([0,0], ylim)

% c)
xaprox1 = MetBisectiei(f2, 0, 1, eps)
xaprox2 = MetBisectiei(f2, 1, 3.2, eps)
xaprox3 = MetBisectiei(f2, 3.2, 4, eps)

plot([xaprox1, xaprox2, xaprox3], [f2(xaprox1),f2(xaprox2),f2(xaprox3)], 'or', 'MarkerSize', 10)

%%%%%%%%%%%%%%
% Exercitiul 3
%%%%%%%%%%%%%%
% a) 
figure
fplot(@(x) (exp(x)-2), 'r');
axis([-5 5 -2 2]);
hold on
fplot(@(x) cos(exp(x) - 2), 'b');

% b) 
f3 = @(x) exp(x) - 2 - cos(exp(x) -2); 
x_aproximativ = MetBisectiei(f3, 0.5, 1.5, eps);
line(xlim, [0,0]);
plot(x_aproximativ, f3(x_aproximativ), 'or');

%%%%%%%%%%%%%%
% Exercitiul 4
%%%%%%%%%%%%%%
f4 = @(x) x.^2 - 3
x_aproximativ = MetBisectiei(f4, -10, 10, eps); % = 1.73 
% Radical din 3: 1.73205080757

%%%%%%%%%%%%%%
% Exercitiul 5
%%%%%%%%%%%%%%
f5 = @(x) x.^3 - 7.*x.^2 + 14.*x - 6
df5 = @(x) 3*x.^2 - 14.^x + 14
ddf5 = @(x) 6.*x - 14

x5 = -5:0.1:5;
figure
plot(x5, f5(x5), 'Color', 'b')
axis([-5 5 -2 3])
line(xlim, [0,0])
hold on
plot([0,2.5], [0,0], 'or')
plot([2], [0,0], '*g')

% Sirul generat de metoda Newton - Raphson 
% nu converge catre solutia intervalului dat 
% deoarece pe [0, 2.5] functia nu este monotona.
% (are punct de maxim local in x = ~1.4)

% x0 = 0.2 va converge catre solutia ecuatiei din 
% intervalul [0, 2.5], deoarece functia este 
% concava, f''(0.2) = -12.8 < 0 si f(0.2) = -3.47 < 0  

%%%%%%%%%%%%%%
% Exercitiul 6
%%%%%%%%%%%%%%
f6 = @(x) x.^3 - 7.*x.^2 + 14.*x - 6
df6 = @(x) 3.*x.^2 - 14.*x + 14
ddf6 = @(x) 6.*x - 14

% b)
figure
x6 = 0:0.1:10
plot(x6, f6(x6), 'Color', 'm');
axis([0 10 -5 5])
line(xlim, [0,0])
eps = 10.^(-3)

% [0, 2] si x0 = 0.2
% f(0) * f(2) < 0 si f(x0) * f''(x0) > 0
solutie_1 = MetNR(f6, df6, 0.2, eps);
% [2, 3.1] si x0 = 2.5
% f(2) * f(3.1) < 0 si f(x0) * f''(x0) > 0
solutie_2 = MetNR(f6, df6, 2.5, eps);
% [3.1, 4] si x0 = 3.5
% f(3.1) * f(4) < 0 si f(x0) * f''(x0) > 0
solutie_3 = MetNR(f6, df6, 3.5, eps);

%%%%%%%%%%%%%%
% Exercitiul 7
%%%%%%%%%%%%%%
% a) 
f7 = @(x) 8.*x.^3 + 4.*x - 1
df7 = @(x) 24 .* x.^2 + 4 % > 0, oricare x => functie strict crescatoare
f7(0); % = -1 < 0
f7(1); % = 11 > 0
% Cum f este strict crescatoare si are semn contrar in capetele 
% intervalului [0,1] => admite o unica solutie

x = -10:0.1:10
figure
plot(x, f7(x), 'Linewidth', 2, 'Color', 'g');
line(xlim, [0 0])

%b) 
eps = 1.e-3
x_aprox_NR = MetNR(f7, df7, 0, eps);
x_aprox_secanta = MetSecantei(f7, 0, 1, 0, 1, eps)
x_aprox_poz_false = MetPozFalse(f7, 0, 1, eps)

%%%%%%%%%%%%%%
% Exercitiul 8
%%%%%%%%%%%%%%
% a)
f8 = @(x) x.^3 - 18.*x - 10 

x = -5:0.1:5
figure 
plot(x, f8(x), 'Linewidth', 2, 'Color', 'r')
line(xlim, [0 0])
line([0 0], ylim)

% d) 
eps = 1.e-4
solutie_1 = MetSecantei(f8, -5, -3, -5, -3, eps)
solutie_2 = MetSecantei(f8, -2, 2, -2, 2, eps)
solutie_3 = MetSecantei(f8, 3, 5, 3, 5, eps)
hold on
plot([solutie_1, solutie_2, solutie_3], [f8(solutie_1), f8(solutie_2),f8(solutie_3)], 'og', 'MarkerSize', 10, 'Linewidth', 3)

% e) 
eps = 1.e-4
solutie_1 = MetPozFalse(f8, -5, -3, eps)
solutie_2 = MetPozFalse(f8, 0, 2, eps)
solutie_3 = MetPozFalse(f8, 3, 5, eps)
hold on
plot([solutie_1, solutie_2, solutie_3], [f8(solutie_1), f8(solutie_2),f8(solutie_3)], '*b', 'MarkerSize', 10)

%%%%%%%%%
% Functii
%%%%%%%%%

%%%%%%%%%%%%%%
% Exercitiul 2 
%%%%%%%%%%%%%%
% a) 
function [xaprox] = MetBisectiei(f, a, b, eps) 
    k = floor (log2((b-a)/eps))
    A = zeros(1, k + 1);
    B = zeros(1, k + 1);
    X = zeros(1, k + 1);
    A(1) = a;
    B(1) = b;
    X(1) = (a + b) / 2;
    for i = 1:k
        if (f(A(i)) * f(X(i)) < 0)
           B(i + 1) = X(i);
           A(i + 1) = A(i);
           X(i + 1) = (A(i + 1) + B(i + 1)) / 2;
        end
        if (f(X(i)) * f(B(i)) < 0)
            A(i + 1) = X(i);
            B(i + 1) = B(i);
            X(i + 1) = (A(i + 1) + B(i + 1)) / 2;
        end
        if (f(X(i)) == 0)
            X(i + 1) = X(i);
        end
    end
    xaprox = X(k)
end

%%%%%%%%%%%%%%
% Exercitiul 6 
%%%%%%%%%%%%%%
% a)
function xaprox = MetNR(f, df, x0, eps) 

while true
    xn = x0 - f(x0) / df(x0);
    if ((abs(xn - x0) / abs(x0)) < eps)
        break;
    end
    x0 = xn;
end
xaprox = x0;

end

%%%%%%%%%%%%%%
% Exercitiul 8 
%%%%%%%%%%%%%%
% b)
function xaprox = MetSecantei(f, a, b, x0, x1, eps)
    
    while true
       if abs(x1 - x0) < eps * abs(x0)
           break;
       end
       x2 = (x0 * f(x1) - x1 * f(x0)) / (f(x1) - f(x0));
       
       if (x2 < a || x2 > b)
        display "Introduceti alte valori pentru x0 si x1";
        break;
       end
       
       x0 = x1;
       x1 = x2;
    end
    xaprox = x1;
end

% c) 
function xaprox = MetPozFalse(f, a, b, eps)
    a0 = a;
    b0 = b;
    x0 = (a0 * f(b0) - b0 * f(a0)) / (f(b0) - f(a0))
    
    while true
        if (abs(f(x0)) < eps)
            break;
        end
        if f(a0) * f(x0) < 0
            b0 = x0;
            x0 = (a0 * f(b0) - b0 * f(a0)) / (f(b0) - f(a0));
        end
        if f(a0) * f(x0) > 0
            a0 = x0;
            x0 = (a0 * f(b0) - b0 * f(a0)) / (f(b0) - f(a0));
        end
    end
           
    xaprox = x0;
end