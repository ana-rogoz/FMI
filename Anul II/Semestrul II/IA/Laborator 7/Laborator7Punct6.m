m = [10, 50, 100, 250, 500];
deplasare = [0.5, 0.3, 0.1, 0.01, -0.1, -0.3];

net = perceptron;
net = configure(net,[0;0],0);
net.layers{1}.transferFcn = 'hardlims';
net.trainParam.epochs = 100;

for i = 1:5
  epociNecesare = zeros(1,6);
  for j = 1:6
      Puncte = rand(2,m(i)) * 2 - 1;
      Etichete = zeros(1,m(i));
      Etichete = Puncte(1,:) < Puncte(2,:);
      Etichete = Etichete * 2 - 1;
      Puncte(2,:) = Puncte(2,:) + Etichete*deplasare(j);
      net = init(net);
      [net, antrenare] = train(net, Puncte, Etichete);
      epociNecesare(j) = antrenare.num_epochs;
  end
  figure
  plot(deplasare, epociNecesare);
end
