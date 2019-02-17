% Titlu: Tema 11
% Autor: Ana-Cristina Rogoz
% Grupa: 332

%%%%%%%%%%%%%%
% Exercitiul 1
%%%%%%%%%%%%%%
% b)
f = @(x) sin (x)
syms xsym
df = matlabFunction(diff(f(xsym)));

a = 0;
b = pi;
m = 100;
x = linspace(a,b,m-1);
x = [a-(x(2) - x(1)) x b+(x(2) - x(1))];
y = f(x);
% Diferente finite progresive  
dy_dfp = DerivNum(x,y, 'dfp');
figure 
plot(x(2:m), dy_dfp, 'r');
hold on
plot(x(2:m), df(x(2:m)), 'ob');
title('Diferente finite progresive');

% Diferente finite regresive
dy_dfr = DerivNum(x,y, 'dfr');
figure 
plot(x(2:m), dy_dfr, 'r');
hold on
plot(x(2:m), df(x(2:m)), 'ob');
title('Diferente finite regresive');

% Diferente finite centrale
dy_dfc = DerivNum(x,y, 'dfc');
figure 
plot(x(2:m), dy_dfc, 'r');
hold on
plot(x(2:m), df(x(2:m)), 'ob');
title('Diferente finite centrale');
%%
% c)
df_adevarat = df(x(2:m));
eroare_dfp = abs(dy_dfp - df_adevarat);
eroare_dfr = abs(dy_dfr - df_adevarat);
eroare_dfc = abs(dy_dfc - df_adevarat);
figure
plot(sort(eroare_dfp, 'desc'), '*r');
title('Eroare diferente finite progresive');
figure
plot(sort(eroare_dfr, 'desc'), '*g');
title('Eroare diferente finite regresive');
figure
plot(sort(eroare_dfc, 'desc'), '*b');
title('Eroare diferente finite centrale');

%% 
%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%
% b)
a = 0;
b = pi;
f = @(x) sin (x);
syms Xsym
df = matlabFunction(diff(f(Xsym)));
x = linspace(a,b,100);
h = x(2) - x(1);

n = 4;
df_4 = zeros(1,100);
for i = 1:100 
    df_4(i) = MetRichardson(f, x(i), h, n);  
end
figure 
plot(x, df_4, '*');
hold on 
plot(x, df(x), 'r');
title('Metoda Richardson pentru n = 4');

n = 6;
df_6 = zeros(1,100);
for i = 1:100 
    df_6(i) = MetRichardson(f, x(i), h, n);  
end
figure 
plot(x, df_6, '*');
hold on 
plot(x, df(x), 'r');
title('Metoda Richardson pentru n = 6');

n = 8;
df_8 = zeros(1,100);
for i = 1:100 
    df_8(i) = MetRichardson(f, x(i), h, n);  
end
figure 
plot(x, df_8, '*');
hold on 
plot(x, df(x), 'r');
title('Metoda Richardson pentru n = 8');

% c)
df_adevarat = df(x);
eroare_4 = abs(df_4 - df_adevarat);
eroare_6 = abs(df_6 - df_adevarat);
eroare_8 = abs(df_8 - df_adevarat);
figure
plot(sort(eroare_4, 'desc'), '*r');
title('Eroare Metoda Richardson pentru n = 4');
figure
plot(sort(eroare_6, 'desc'), '*g');
title('Eroare Metoda Richardson pentru n = 6');
figure
plot(sort(eroare_8, 'desc'), '*b');
title('Eroare Metoda Richardson pentru n = 8');

%% 
% e)
ddf = matlabFunction(diff(df(Xsym)));
n = 4;
d2f_4 = zeros(1,100);
for i = 1:100 
    d2f_4(i) = MetRichardson_2(f, x(i), h, n);  
end
figure 
plot(x, d2f_4, '*');
hold on 
plot(x, ddf(x), 'r');
title('Metoda Richardson derivata de ordinul doi pentru n = 4');

n = 6;
d2f_6 = zeros(1,100);
for i = 1:100 
    d2f_6(i) = MetRichardson_2(f, x(i), h, n);  
end
figure 
plot(x, d2f_6, '*');
hold on 
plot(x, ddf(x), 'r');
title('Metoda Richardson derivata de ordinul doi pentru n = 6');

n = 8;
d2f_8 = zeros(1,100);
for i = 1:100 
    d2f_8(i) = MetRichardson_2(f, x(i), h, n);  
end
figure 
plot(x, d2f_8, '*');
hold on 
plot(x, ddf(x), 'r');
title('Metoda Richardson derivata de ordinul doi pentru n = 8');

%%%%%%%%%%%%%%
% Functii
%%%%%%%%%%%%%%

%%%%%%%%%%%%%%
% Exercitiul 1
%%%%%%%%%%%%%%
% a)
function [dy] = DerivNum(x, y, metoda)
 
m = length(x) - 1;
dy = zeros(1,m+1);
switch metoda
    case 'dfp'
        dy = (y(2:m) - y(1:m-1))./(x(3:m+1) - x(2:m));
    case 'dfr'
        dy = (y(2:m) - y(1:m-1))./(x(2:m) - x(1:m-1));
    case 'dfc'
        dy = (y(3:m+1) - y(1:m-1))./(x(3:m+1) - x(1:m-1));
end

end

%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%
% a)
function df = MetRichardson(f, x, h, n)

Q = zeros(n,n);
teta = @(x_fct,h) (f(x_fct+h) - f(x_fct))/h;
for i = 1:n 
    Q(i, 1) = teta(x, h/(2^(i-1)));
end

for i = 2:n
    for j = 2:i 
        Q(i,j) = Q(i, j-1) + (Q(i,j-1) - Q(i-1, j-1))/(2^(j-1) - 1);
    end 
end

df = Q(n,n);
end 

% d) 
function d2f = MetRichardson_2(f, x, h, n)

Q = zeros(n,n);
teta = @(x_fct,h) (f(x_fct+h) - 2*f(x_fct) + f(x_fct - h))/(h^2);
for i = 1:n-1 
    Q(i, 1) = teta(x, h/(2^(i-1)));
end

for i = 2:n-1
    for j = 2:i 
        Q(i,j) = Q(i, j-1) + (Q(i,j-1) - Q(i-1, j-1))/(2^(j-1) - 1);
    end 
end

d2f = Q(n-1,n-1);
end 
