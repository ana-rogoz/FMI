function Xp = genereazaLiterePerturbate(X,n,sigma)

Xp = repmat(X,1,n) + max(min(randn(size(X,1),n)*sigma,1),0);

