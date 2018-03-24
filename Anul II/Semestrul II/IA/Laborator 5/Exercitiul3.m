P = rand(2,1000) * 2 - 1;
clasa1 = P(1,:) >= P(2,:);
figure, hold on;
plot(P(1,clasa1),P(2,clasa1),'og'); 
plot(P(1,~clasa1),P(2,~clasa1),'xr'); 
line([-1 1],[-1 1],'color','k');

net = perceptron;
net = configure(net,[0;0],0);

%net.IW{1} = [1 -1];
%net.b{1} = 0;
net.layers{1}.transferFcn = 'hardlim';


etichetePrezise = sim(net,P);
eticheteAdevarate = clasa1;
isequal(etichetePrezise,eticheteAdevarate);

net = train(net, P, eticheteAdevarate);
net.IW{1}
net.b{1}