n = 10;
f = inline('sin(2*pi*x)','x');
sigma = 0.2;
S = genereazaExemple(n, sigma, f); % multimea de antrenare
ploteazaExemple(S);
axis([0 1 -2 2]);
culori = {'b','m','r','k','y','c','g','b','m','r'}; 
T = genereazaExemple(n,sigma,f); % multime de testare

for N = 0:9
    P = gasestePolinomOptim(S,N); % gaseste polinom optim pentru multimea
    hold on;                      % de antrenare
    ploteazaGraficPolinom(P,culori{N+1});
    ES(N+1) = calculeazaEroare(P,S);
    ET(N+1) = calculeazaEroare(P,T);
end

figure, plot(ES,'b');
hold on; plot(ET, 'r');

legend('eroare antrenare', 'eroare testare');
axis([0 10 0 25]);


