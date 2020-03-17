function [Xn, Tn] = genereazaMultimeAntrenare(n) 

coloanaDeUnu = ones(n, 1);
exempleClasa0 = zeros(n*n, n);
for i = 1:n 
    if(i == 1)
        formeazaExemplu = [coloanaDeUnu; zeros(n*(n-1), 1)];
    end
    if(i == n)
        formeazaExemplu = [zeros(n*(n-1), 1); coloanaDeUnu];
    end
    if( i > 1 && i < n)
        liniiZeroInainte = zeros((i-1)*n, 1);
        liniiZeroDupa = zeros((n-i)*n, 1);
        formeazaExemplu = [liniiZeroInainte; coloanaDeUnu; liniiZeroDupa]; 
    end   
    exempleClasa0(:,i) = formeazaExemplu;
end

exempleClasa1 = zeros(n*n, n);
for i = 1:n
    formeazaExemplu = zeros(1, n*n);
    for j = 1:n
        formeazaExemplu(1, (j-1)*n + i) = 1;
    end
    exempleClasa1(:, i) = formeazaExemplu;
end 
    

Xn = [exempleClasa0 exempleClasa1];
Tn = [zeros(1, n) ones(1, n)];

end
