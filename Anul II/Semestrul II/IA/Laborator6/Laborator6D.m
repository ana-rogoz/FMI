m = [10, 50, 100, 250, 500];
deplasare = [0.5, 0.3, 0.1, 0.01, -0.1, -0.3];

for i = 1:5
  epociNecesare = zeros(1,6);
  for j = 1:6
      [X,T] = genereazaPuncteDeplasateFataDePrimaBisectoare(m(i), deplasare(j));
      %figure, hold on
      ind1 = find(T==1);
     % plot(X(1,ind1),X(2,ind1), 'xr');
      ind2 = find(T==-1);
      %plot(X(1,ind2),X(2,ind2), 'og');
      [w,b,er,ep] = algoritmRosenblattOnline(X,T,100)
      %plotpc(w',b); hold on
      %plot([-1,1],[-1,1], 'm');
      epociNecesare(j) = ep;
  end
  figure
  plot(deplasare, epociNecesare);
end
