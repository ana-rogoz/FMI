function [Puncte, Etichete] = genereazaPuncteDeplasateFataDePrimaBisectoare(m, deplasare) 

Puncte = rand(2,m) * 2 - 1;
Etichete = zeros(1,m);
Etichete = Puncte(1,:) < Puncte(2,:);
Etichete = Etichete * 2 - 1;

for i = 1:m
    if (Etichete(i) == 1)
        Puncte(2,i) = Puncte(2,i) + deplasare;
    else
        Puncte(2,i) = Puncte(2,i) - deplasare;
    end
end
