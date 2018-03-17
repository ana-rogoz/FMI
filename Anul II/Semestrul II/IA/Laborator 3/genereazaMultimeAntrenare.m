function[x,y] = genereazaMultimeAntrenare(c,N)

x = zeros(1,N);
y = zeros(1,N);
x = 4*c*rand(1,N);

for i = 1:N
    p = x(i)/(x(i) + c);
    y(i)=binornd(1,p);
end
plot(x,y,'*');

end
