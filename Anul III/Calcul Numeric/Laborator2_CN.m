f = @(x) x.^3 - 7*x.^2 + 14 * x - 6
eps = 10 ^ (-5)
x = linspace(0,4, 100)
plot(x, f(x), 'Linewidth', 2, 'Color', 'g')
hold on
line(xlim, [0 0])
line([0,0], ylim)

xaprox1 = MetBisectiei(f, 0, 1, eps)
xaprox2 = MetBisectiei(f, 1, 3.2, eps)
xaprox3 = MetBisectiei(f, 3.2, 4, eps)

plot([xaprox1, xaprox2, xaprox3], [f(xaprox1),f(xaprox2),f(xaprox3)], 'or', 'MarkerSize', 10)


function y = MetBisectiei(f, a, b, eps) 
    k = floor (log2((b-a)/eps))
    A = zeros(1, k + 1);
    B = zeros(1, k + 1);
    X = zeros(1, k + 1);
    A(1) = a;
    B(1) = b;
    X(1) = (a+b) / 2;
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
    y = X(k)
end
