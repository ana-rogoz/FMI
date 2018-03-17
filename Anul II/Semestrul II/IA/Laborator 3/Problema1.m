function Problema1(c) 

figure, hold on;

x = 0:0.1:4*c;
y = x ./ (x+c);

plot(x,y);

end