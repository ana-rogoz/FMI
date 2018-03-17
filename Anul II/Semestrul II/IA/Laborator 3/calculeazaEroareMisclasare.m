function Eroare = calculeazaEroareMisclasare(x,y,c)

gstar = aplicaClasificatorBaesyan(x,c);

Eroare = sum(abs(gstar - y))/length(y);

end   