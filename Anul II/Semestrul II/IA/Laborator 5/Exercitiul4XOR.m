Puncte = [0 0 1 1; 0 1 0 1];
clasaXOR = xor(Puncte(1,:),Puncte(2,:));
figure, hold on;
plot(Puncte(1,clasaXOR),Puncte(2,clasaXOR),'og'); 
plot(Puncte(1,~clasaXOR),Puncte(2,~clasaXOR),'xr'); 

net = perceptron; 
net = configure(net, [0;0], 0);
net.layers{1}.transferFcn = 'hardlim';

net = train(net, Puncte, clasaXOR);
net.IW{1}
net.b{1}

eticheteAdevarate = clasaXOR;
etichetePrezise = sim(net,Puncte);
isequal(eticheteAdevarate, etichetePrezise)