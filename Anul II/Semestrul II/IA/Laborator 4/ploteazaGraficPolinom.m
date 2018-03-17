function ploteazaGraficPolinom(P, culoare)

x = 0:0.001:1;
y = polyval(P, x);
plot(x,y,culoare);
axis([0,1, -2, 2]);

end

