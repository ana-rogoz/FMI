% Ex 1
netFeedforward = feedforwardnet();
view(netFeedforward);

% Ex 2
netPattern = patternnet();
view(netPattern);

% Exemplu
% XOR separat cu ajutorul dreptelor: 
% d1: -x + y - 0.5 = 0 si d2: x - y - 0.5 = 0;
X = [0 1 0 1; 0 0 1 1]; 
t = [0 1 1 0]; 
net = patternnet(2);
net.layers{1:2}.transferFcn = 'hardlim';
net.inputs{1}.processFcns = {};
net.outputs{2}.processFcns = {};
net = configure(net,X,t);
net.IW{1,1} = [-1 1; 1 -1]; 
net.LW{2,1}=[1 1]; 
net.b{1} = [-0.5;-0.5];
net.b{2} = -0.5; 
a=sim(net,X);
isequal(a,t);
a = net(X);
isequal(a,t);

% Ex 3
% XOR separat cu ajutorul dreptelor:
% d1: x + y - 0.5 = 0 si d2: -0.5x -0.5y + 0.75 = 0
X = [0 1 0 1; 0 0 1 1]; 
t = [0 1 1 0]; 
net2 = patternnet(2);
net2.layers{1}.transferFcn = 'hardlim';
net2.layers{2}.transferFcn = 'hardlim';
net2.inputs{1}.processFcns = {};
net2.outputs{2}.processFcns = {};
net2 = configure(net2, X, t);
net2.IW{1,1} = [1 1; -0.5 -0.5]; %fiecare linie corespunde unei drepte
net2.LW{2,1} = [1 1];
net2.b{1} = [-0.5; 0.75];
net2.b{2} = -1.5;
retea2 = sim(net2,X);
isequal(retea2, t);

% Ex 4
% a) Construiti reteaua care sa implementeze functia indicator a
% triunghiului dat de A(-1, 0), B(0,1), C(1,0);
% triunghiul in interior 1, in exterior 0
net = patternnet(3);
net.layers{1:2}.transferFcn = 'hardlim';
net.inputs{1}.processFcns = {};
net.outputs{2}.processFcns = {};
net=configure(net, [0;0], 0);
net.IW{1,1} = [1 -1; 0 1; -1 -1];
net.b{1} = [1; 0; 1];
net.LW{2,1} = [1 1 1];
net.b{2} = -2.5;
% b) Generati puncte test 2x20000 in patratul [-2,2] x [-2,2]
p = rand(2, 20000) * 4 - 2;
t = net(p);
figure, hold on
ind1 = find(t==1); plot(p(1,ind1), p(2,ind1), 'xr');
ind0 = find(t==0); plot(p(1,ind0), p(2,ind0), 'ob');

