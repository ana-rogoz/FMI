net = perceptron;

net = configure(net,[0;0;0],0);

net.IW{1} = [0 1 0];
net.b{1} = 0;
net.layers{1}.transferFcn = 'hardlims';

view(net);