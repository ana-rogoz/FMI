multime = load('S.mat');
inputs = multime.inputs;
targets = multime.targets;

%a 
plot(inputs, targets, '+r');

%b
net = feedforwardnet(5);
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'purelin';
net = configure(net, inputs, targets);
net.trainFcn = 'trainscg';

%c
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 0.7;
net.divideParam.valRatio = 0.15;
net.divideParam.testRatio = 0.15;

%d
[net, antrenare] = train(net, inputs, targets);

%e 
plotperform(antrenare);

%f 
targetsRetea = sim(net, inputs);
figure, hold on;
plot(inputs, targets, 'b');
plot(inputs, targetsRetea, 'r');

%g 
net2 = feedforwardnet(15);
net2 = configure(net2, inputs, targets);
net2.layers{1}.transferFcn = 'tansig';
net2.layers{2}.transferFcn = 'purelin';
net2.trainFcn = 'trainlm';


net2.divideFcn = 'dividerand';
net2.divideParam.trainRatio = 0.7;
net2.divideParam.valRatio = 0.15;
net2.divideParam.testRatio = 0.15;

[net2, antrenare2] = train(net2, inputs, targets);


plotperform(antrenare2);

targetsRetea = sim(net, inputs);
figure, hold on;
plot(inputs, targets, 'b');
plot(inputs, targetsRetea, 'r');