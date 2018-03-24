n = 10;
f = inline('sin(2*pi*x)','x');
sigma = 0.2;
multimeExemple = genereazaExemple(n,sigma,f);
ploteazaExemple(multimeExemple);


permutare = randperm(n);
antrenare = [];
testare = [];

axis([0 1 -2 2]);
culori = {'b','m','r','k','y','c','g'}; 

for i = 1:7
    antrenare(1,i) = multimeExemple(1,permutare(i));
    antrenare(2,i) = multimeExemple(2,permutare(i));
end

for i = 8:10
    testare(1,i) = multimeExemple(1,permutare(i));
    testare(2,i) = multimeExemple(2,permutare(i));
end

for N = 0:6
    P = gasestePolinomOptim(antrenare,N); % gaseste polinom optim pentru multimea
    hold on;                      % de antrenare
    ploteazaGraficPolinom(P,culori{N+1});
    ES(N+1) = calculeazaEroare(P,antrenare);
    ET(N+1) = calculeazaEroare(P,testare);
end

figure, plot(ES,'b');
hold on; plot(ET, 'r');

legend('eroare antrenare', 'eroare testare');
axis([0 10 0 25]);

