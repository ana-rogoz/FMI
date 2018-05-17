%%
% functia initiala 
netf = feedforwardnet(2); 
%definim reteaua netf
netf.layers{1:2}.transferFcn = 'logsig';
netf.inputs{1}.processFcns = {};
%eliminam faza de preprocesare: scalare, etc.
netf.outputs{2}.processFcns = {};
%eliminam faza de postprocesare: scalare, etc
netf = configure(netf,0,0);
netf.IW{1,1} = [10 10]';
netf.b{1} = [-5 5]';
netf.LW{2,1} = [1 1];
netf.b{2} = -1;
p = -2:0.1:2;
t = netf(p);

% rata variabila + moment
net = feedforwardnet(2);
net.layers{1:2}.transferFcn = 'logsig';
net.inputs{1}.processFcns = {};
%eliminam faza de preprocesare: scalare, etc.
net.outputs{2}.processFcns = {};
%eliminam faza de postprocesare: scalare, etc
net = configure(net,0,0);
net.trainFcn= 'traingdx';
net.trainParam.show = 50; 
net.trainParam.lr = 0.05; 
net.trainParam.mc = 0.9; 
net.trainParam.lr_inc = 1.05;
net.trainParam.lr_dec = 0.7;
net.trainParam.max_perf_inc = 1.04;
net.trainParam.epochs = 1000; 
net.trainParam.goal = 1e-5; 

[net,tr]=train(net,p,t);
t1 = sim(net, p);
figure, hold on;
plot(p,t);
plot(p,t1);
%%

%Ex 3
p = [0 0 0 0 1 1 1 1;
     0 0 1 1 0 0 1 1;
     0 1 0 1 0 1 0 1];
t = [0 1 1 0 1 0 0 1];
net = patternnet([3,10,10]);
net.inputs{1}.processFcns ={};
net.outputs{2}.processFcns = {};
net.divideFcn = '';
net.trainFcn = 'traingdx';
net = train(net, p, t);
net.layers{4}.transferFcn = 'hardlim';
t1 = net(p);

%%
% Ex 4 
p = -2:0.1:2;
t = sin(p);
net = feedforwardnet([3,10,10]);
net.inputs{1}.processFcns ={};
net.outputs{2}.processFcns = {};
net.divideFcn = '';
net.trainFcn = 'traingdx';
net = train(net, p, t);
t1 = net(p);
figure, hold on;
plot(p,t);
plot(p,t1);

p = -12:0.1:12;
t = sin(p);
net = feedforwardnet([3,10,10]);
net.inputs{1}.processFcns ={};
net.outputs{2}.processFcns = {};
net.divideFcn = '';
net.trainFcn = 'traingdx';
net = train(net, p, t);
t1 = net(p);
figure, hold on;
plot(p,t);
plot(p,t1);

p = -100:0.1:100;
t = sin(p);
t1 = net(p);
figure, hold on;
plot(p,t);
plot(p,t1);

%%
%Ex 5
p = -5:0.1:5; 
%adauga zgomot
t = sin(2*pi*p)+0.25*randn(size(p));

plot(p,t,'ob');
net = feedforwardnet([25 25 25]);
net.inputs{1}.processFcns ={};
net.outputs{2}.processFcns = {};

net1 = net;
net2 = net;
net1.divideFcn = '';
net1.trainFcn = 'traincgb';
net1 = train(net1, p, t);
net2.divideFcn = 'dividerand';
net2.trainFcn = 'traincgb';
net2 = train(net2, p, t);
t1 = net1(p);
t2 = net2(p);
figure, hold on;
plot(p,t,'b');
plot(p,t1,'r');
plot(p, t2, 'g');

