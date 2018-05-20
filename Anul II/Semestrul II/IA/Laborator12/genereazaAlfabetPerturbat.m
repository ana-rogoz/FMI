function [Xp, Tp] = genereazaAlfabetPerturbat(X,T,n,sigma)

Xp = zeros(size(X,1),n*size(X,2));
Tp = zeros(size(T,1),n*size(T,2));
for i=1:26
    Xp(:,(i-1)*n+1:i*n) = genereazaLiterePerturbate(X(:,i),n,sigma);
    Tp(:,(i-1)*n+1:i*n) = repmat(T(:,i),1,n);
end
    