% Titlu: Tema 12
% Autor: Ana-Cristina Rogoz
% Grupa: 332

%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%
% b)
f = @(x) (sin (x))
a = 0;
b = pi;
m = 10;

If = integral(f,a,b);
% Dreptunghi
I = Integrare(f,a,b,10,'dreptunghi');
disp(abs(I-If));

% Trapez
I = Integrare(f,a,b,10,'trapez');
disp(abs(I-If));

% Simpson
I = Integrare(f,a,b,10,'Simpson');
disp(abs(I-If));

% Newton
I = Integrare(f,a,b,10,'Newton');
disp(abs(I-If));

%%%%%%%%%%%%%%
% Exercitiul 4
%%%%%%%%%%%%%%
%%
f = @(t,x) x*cos(t) + x.^2*cos(t);
tf = asin(log(2)) - 0.01;

% Rezolvarea problemei Cauchy(f, 0, 1) pe intervalul [0, arcsin(ln 2))
[T,X] = MetEuler(f, 0, tf, 1, 200);

% Solutia exacta phi0 pe acelasi interval
phi = @(t) (-exp(1).^(sin(t))/(exp(1).^(sin(t)) - 2)); 
y = zeros(1,201);
for i = 1:201
    y(i) = phi(T(i));
end

figure
plot(T, y);
hold on
plot(T,X,'*r');
legend('Solutia exacta', 'Solutia calculata');

% Spre capatul din dreapta al intervalului maximal solutia data de metoda 
% Euler aproximeaza mai slab, nereusind sa urmareasca cursul functie spre 
% infinit in punctul arcsin(ln(2)). Totusi, cu cat crestem N-ul incepe sa 
% aproximeze din ce in ce mai bine. Pentru N = 200 incepe sa se vada 
% tendinta graficului dat de solutia metodei Euler, iar pentru N = 2000 
% solutia calculata si solutia exacta aproape coincid. 

% Graficul erorii
eroare = abs(y - X);
figure
plot(sort(eroare, 'desc'), '*g');
title('Graficul erorii');

eroare_medie = mean(abs(y - X));
disp(eroare_medie);

% Solutia problemei Cauchy(f, 0, 1) folosind procedura predefinita ode45
tspan = [0, tf];
x0 = 1;
[t,x] = ode45(f, tspan, x0);
figure
plot(t,x,'-o');
title('Solutia problemei Cauchy');

y = zeros(53, 1);
for i = 1:53
    y(i) = phi(t(i));
end

eroare = abs(y - x);
plot(sort(eroare, 'desc'), '*g');
title('Graficul erorii ode45');

eroare_medie = mean(abs(y - x));
disp(eroare_medie);

%%%%%%%%%%%%%%
% Functii
%%%%%%%%%%%%%%

%%%%%%%%%%%%%%
% Exercitiul 2
%%%%%%%%%%%%%%
% a)
function I = Integrare(f, a, b, m, metoda) 
  switch metoda
      case 'dreptunghi'
          x = linspace(a, b, 2*m+1);
          h = x(2) - x(1);
          I = 2*h*sum(f(x(2:2:2*m)));
      case 'trapez'
          x = linspace(a, b, m+1);
          h = x(2) - x(1);
          suma = 2*sum(f(x(2:m)));
          
          I = h*(f(x(1)) + suma + f(x(m + 1)))/2;
      case 'Simpson'
          x = linspace(a,b,2*m+1);
          h = x(2) - x(1);
          suma_1 = sum(f(x(1:2:2*m-1)))/3;
          suma_2 = 4*sum(f(x(2:2:2*m)))/3;
          suma_3 = sum(f(x(3:2:2*m+1)))/3;
          
          I = h * (suma_1 + suma_2 + suma_3);
      case 'Newton' 
          x = linspace(a,b,3*m+1);
          h = x(2) - x(1);
          suma_1 = sum(f(x(1:3:3*m-2)));
          suma_2 = 3*sum(f(x(2:3:3*m-1)));
          suma_3 = 3*sum(f(x(3:3:3*m)));
          suma_4 = sum(f(x(4:3:3*m+1)));
          
          I = 3*h*(suma_1 + suma_2 + suma_3 + suma_4)/8;
  end        
end

%%%%%%%%%%%%%%
% Exercitiul 4
%%%%%%%%%%%%%%
function [t,x] = MetEuler(f, t0, tf, x0, N) 

  t = zeros(1,N);
  t(1) = t0;
  h = (tf - t0)/N;
  for i = 2:N+1
     t(i) = t(i-1) + h;
  end
  
  x = zeros(1,N);
  x(1) = x0;
  for i = 1:N
     x(i+1) = x(i) + h*f(t(i), x(i)); 
  end
end
