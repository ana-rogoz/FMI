Puncte = [0 0 1 1; 0 1 0 1];
clasaAND = Puncte(1,:)&Puncte(2,:);
figure, hold on;
plot(Puncte(1,clasaAND),Puncte(2,clasaAND),'og'); 
plot(Puncte(1,~clasaAND),Puncte(2,~clasaAND),'xr'); 

net = perceptron; 
net = configure(net, [0;0], 0);
net.layers{1}.transferFcn = 'hardlim';

net = train(net, Puncte, clasaAND);
net.IW{1}
net.b{1}

eticheteAdevarate = clasaAND;
etichetePrezise = sim(net,Puncte);
isequal(eticheteAdevarate, etichetePrezise)