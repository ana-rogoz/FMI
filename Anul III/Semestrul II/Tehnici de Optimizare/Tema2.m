%%%%%%%%%%%%%%
% Bisectie
%%%%%%%%%%%%%%
% f este continua pe [a,b] si f(a)*f(b) < 0 
f2 = @(x) x.^3 - 7.*x.^2 + 14.*x - 6

eps = 10 ^ (-5)
x2 = linspace(0,4, 100)
plot(x2, f2(x2), 'Linewidth', 2, 'Color', 'g')
hold on
line(xlim, [0 0])
line([0,0], ylim)

xaprox1 = MetBisectiei(f2, 0, 1, eps)
xaprox2 = MetBisectiei(f2, 1, 3.2, eps)
xaprox3 = MetBisectiei(f2, 3.2, 4, eps)

plot([xaprox1, xaprox2, xaprox3], [f2(xaprox1),f2(xaprox2),f2(xaprox3)], 'or', 'MarkerSize', 10)

figure
fplot(@(x) (exp(x)-2), 'r');
axis([-5 5 -2 2]);
hold on
fplot(@(x) cos(exp(x) - 2), 'b');

f3 = @(x) exp(x) - 2 - cos(exp(x) -2); 
x_aproximativ = MetBisectiei(f3, 0.5, 1.5, eps);
line(xlim, [0,0]);
plot(x_aproximativ, f3(x_aproximativ), 'or');

f4 = @(x) x.^2 - 3
x_aproximativ = MetBisectiei(f4, -10, 10, eps); % = 1.73 
% Radical din 3: 1.73205080757

%%%%%%%%%%%%%%
% Newton-Rhapson
%%%%%%%%%%%%%%
% f continua si derivabila 
f6 = @(x) x.^3 - 7.*x.^2 + 14.*x - 6
df6 = @(x) 3.*x.^2 - 14.*x + 14
ddf6 = @(x) 6.*x - 14

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
% Secanta
%%%%%%%%%%%%%%
f8 = @(x) x.^3 - 18.*x - 10 

x = -5:0.1:5
figure 
plot(x, f8(x), 'Linewidth', 2, 'Color', 'r')
line(xlim, [0 0])
line([0 0], ylim)
 
eps = 1.e-4
solutie_1 = MetSecantei(f8, -5, -3, -5, -3, eps)
solutie_2 = MetSecantei(f8, -2, 2, -2, 2, eps)
solutie_3 = MetSecantei(f8, 3, 5, 3, 5, eps)
hold on
plot([solutie_1, solutie_2, solutie_3], [f8(solutie_1), f8(solutie_2),f8(solutie_3)], 'og', 'MarkerSize', 10, 'Linewidth', 3)

%%%%%%%%%
% Functii
%%%%%%%%%

% ne mutam in interval in functie de semn-ul lui f(a)*f(x) sau f(x)*f(b)
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
