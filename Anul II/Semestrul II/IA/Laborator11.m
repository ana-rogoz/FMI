net = patternnet(2);
X = [0 0 1 1; 0 1 0 1];
t = [0 1 1 0];
net.layers{1:2}.transferFcn = 'logsig';
net.inputs{1}.processFcns = {};
net.outputs{2}.processFcns = {};
net.divideFcn =''; % nu mai imparte multimea in antrenare, validare, testare
net.trainParam.goal = 0.0001;
view(net);
[net,info] = train(net, X, t);


% net.divideFcn dividerand imparte multimea mare in 
% train, validare si test
% train - 70%
% validare - 15%
% test - 15%
% Validation checks -> se realizeaza pe multimea de validare
% default: validation checks = 6 -- daca dupa 6 iteratii consecutive 
% nu se imbunatateste validarea atunci se opreste
% Reteaua se poate opri pentru ca gradientul(derivata) a devenit f mic, 
% a ajuns la un punct de minim local; nu pentru ca a ajuns la

% Tema ex 1

%nnd11fa -> se leaga de underfitting
%nnd11gn -> overfitting 

netf = feedforwardnet(2);
netf.layers{1:2}.transferFcn = 'logsig';
netf.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
netf.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc
netf = configure(netf,0,0);
netf.IW{1,1} = [10 10]';
netf.b{1} = [-5 5]';
netf.LW{2,1} = [1 1];
netf.b{2} = -1;
view(netf);
%plotam functia implementata de retea
p = -2:0.001:2;
t = sim(netf,p);
figure,hold on;
plot(p,t,'b');
%luam numai cateva puncte
p = -2:0.1:2;
t = sim(netf,p);
figure, hold on;
plot(p,t,'xr');
keyboard;
%definim reteaua pentru a fi antrenata
net = feedforwardnet(2);
net.layers{1:2}.transferFcn = 'logsig';
net.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
net.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc
net = configure(netf,0,0);
%definim parametri de antrenare
net.trainFcn = 'traingd'; %antrenare cu batch gradient descend - coborare pe
gradient varianta batch
net.trainParam.lr = 0.05;%rata de invatare
net.trainParam.epochs = 1000; %nr de epoci
net.trainParam.goal = 1e-5;%valoarea erorii pe care vrem sa o atingem
[net,tr]=train(net,p,t); %antrenarea retelei
%plotperfm(tr);
p = -2:0.1:2;
t1 = sim(net, p);
plot(p,t1,'b');

% la probleme de regresie, folosim feedforwardnet
% la clasificare cu patternet