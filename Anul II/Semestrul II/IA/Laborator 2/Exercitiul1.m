x1 = [-5:0.1:2];
y1 = 2*x1+8;
figure, hold on
plot(x1,y1, '*g');
x2 = [2:0.1:5];
y2 = 3*x2.^2;
plot(x2,y2, 'om');
axis([-5 5 -10 100]);