function [x,y] = genereazaMultimeAntrenare2(c,N)

% X are repartitie exponentiala.

x = zeros(1,N);
y = zeros(1,N);

mu = c;                                         
x = exprnd(mu, 1, N);                         

for i = 1:N
    p = x(i)/(x(i) + c);
    y(i)=binornd(1,p);
end
plot(x,y,'*');

end

