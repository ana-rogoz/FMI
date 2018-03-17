function  S = genereazaExemple(n, sigma, f)

x = sort(rand(1,n));
zgomot = rand(1,n) * sigma; 
u = f(x) + zgomot;
S = [x;u];
end

