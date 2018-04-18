Puncte = [0 0 1 1; 0 1 0 1];
clasaOR = Puncte(1,:)|Puncte(2,:);
figure, hold on;
plot(Puncte(1,clasaOR),Puncte(2,clasaOR),'og'); 
plot(Puncte(1,~clasaOR),Puncte(2,~clasaOR),'xr'); 

net = perceptron; 
net = configure(net, [0;0], 0);
net.layers{1}.transferFcn = 'hardlim';

net = train(net, Puncte, clasaOR);
net.IW{1}
net.b{1}

eticheteAdevarate = clasaOR;
etichetePrezise = sim(net,Puncte);
isequal(eticheteAdevarate, etichetePrezise)