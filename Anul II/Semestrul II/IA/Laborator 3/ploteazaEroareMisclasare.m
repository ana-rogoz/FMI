function ploteazaEroare(c) 

n = [10 100 1000 10000 100000];
E = zeros(size(n));

for i = 1:length(n)
   [x,y] = genereazaMultimeAntrenare(c,n(i));
   E(i) = calculeazaEroareMisclasare(x,y,c);
end

figure
semilogx(n,E,'r');

end