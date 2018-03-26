X = [0 0 0 0.5 0.5 0.5 1 1; 0 0.5 1 0 0.5 1 0 0.5];
T = [1 1 1 1 -1 -1 -1 -1];
figure, hold on
ind1 = find(T==1);
plot(X(1,ind1),X(2,ind1), 'xr');
ind2 = find(T==-1);
plot(X(1,ind2),X(2,ind2), 'og');
[w,b,er] = algoritmRosenblattOnline(X,T,100)
plotpc(w',b);

% f) w = w+x * (t*2 - 1); 
%    b = b + (t*2 - 1);
% garantiile teoretice sunt pentru clasele 1 si -1 