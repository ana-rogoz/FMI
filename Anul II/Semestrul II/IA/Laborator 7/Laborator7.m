X = [0 0 0 0.5 0.5 0.5 1 1;0 0.5 1 0 0.5 1 0 0.5];
T = [1 1 1 1 -1 -1 -1 -1];
figure(1), hold on;
eticheta1 = find(T==1);
etichetaMinus1 = find(T==-1);
plot(X(1,eticheta1),X(2,eticheta1),'or');
plot(X(1,etichetaMinus1),X(2,etichetaMinus1),'xg');
axis([-2 2 -2 2]);

net = perceptron;
net.layers{1}.transferFcn = 'hardlims';
net = configure(net,X,T);
net.inputWeights{1}.initFcn = 'rands';
net.biases{1}.initFcn = 'rands';
net = init(net);
net.trainParam.epochs = 1;
epocaCurenta = 1;

while(epocaCurenta <= 100)
    wOld = net.IW{1};
    bOld = net.b{1};
    net = train(net, X, T);
    figure(gcf), plotpc(net.IW{1}, net.b{1});
    %pause(3);
    epocaCurenta = epocaCurenta + 1;
    if (isequal(wOld, net.IW{1}) && isequal(bOld, net.b{1}))
        break;
    end
end    
    


%pct 4
X = [0 0 0 0.5 0.5 0.5 1 1 -50;0 0.5 1 0 0.5 1 0 0.5 90];
T = [1 1 1 1 -1 -1 -1 -1 1];
net = perceptron;
net = configure(net,X,T);
net.layers{1}.transferFcn = 'hardlims';
net.trainParam.epochs = 1000;
net.inputWeights{1}.learnFcn = 'learnpn'; % learnp normalized x / norma(x)
% pct 5 net.biases{1}.learnFcn = 'learnpn';
net = init(net);
net = train(net,X,T);

% pct 8
net.trainFcn = 'trainb';