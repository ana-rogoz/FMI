netf = feedforwardnet(2); %definim reteaua netf
netf.layers{1:2}.transferFcn = 'logsig';
netf.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
netf.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc
netf = configure(netf,0,0);
netf.IW{1,1} = [10 10]';
netf.b{1} = [-5 5]';
netf.LW{2,1} = [1 1];
netf.b{2} = -1;


%{
%ANTRENARE CU MOMENT

%Multimea de antrenare pentru reteaua net
p = -2:0.1:2;
t = sim(netf,p);

net = feedforwardnet(2);
net.layers{1:2}.transferFcn = 'logsig';
net.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
net.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc
net = configure(net,0,0);
%definim parametri de antrenare 
%antrenare cu batch gradient descend cu moment
net.trainFcn = 'traingdm';
net.trainParam.show = 50; 
net.trainParam.lr = 0.05; 
net.trainParam.mc = 0.9; 
net.trainParam.epochs = 1000; 
net.trainParam.goal = 1e-5;
net.divideFcn = '';
[net,tr]=train(net,p,t);
plotperform(tr);

%exercitiul 1
p= -2:0.001:2;
t = netf(p);
t1 = net(p);
figure, hold on;
plot(p,t,'r');
plot(p,t1,'b');
%}


%ANTRENARE CU RATA VARIABILA / RATA VARIABILA + MOMENT
%multimea de antrenare pentru reteaua net
p = -2:0.1:2;
t = sim(netf,p);
net = feedforwardnet(2);
net.layers{1:2}.transferFcn = 'logsig';
net.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
net.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc
net = configure(net,0,0);
 
%rata variabila - traingda
%rata vairaibila + moment - traingdx
net.trainFcn = 'traingdx';
net.trainParam.show = 50; 
net.trainParam.lr = 0.05; 
net.trainParam.mc = 0.9; 
net.trainParam.lr_inc = 1.05;
net.trainParam.lr_dec = 0.7;
net.trainParam.max_perf_inc = 1.04;
net.trainParam.epochs = 1000; 
net.trainParam.goal = 1e-5; 
net.divideFcn = '';
[net,tr]=train(net,p,t);
plotperform(tr);

%exercitiul 2
p= -2:0.001:2;
t = netf(p);
t1 = net(p);
figure, hold on;
plot(p,t,'r');
plot(p,t1,'b');



%exercitiul 3 cu biti
p = [0 0 0 0 1 1 1 1;0 0 1 1 0 0 1 1;0 1 0 1 0 1 0 1];
t = mod(sum(p),2);

net2 = patternnet([10,10]);
%net2.performFcn = 'mse';
net2.divideFcn = '';

net2.trainFcn = 'traingdx';
net2.trainParam.show = 50; 
net2.trainParam.lr = 0.05; 
net2.trainParam.mc = 0.9; 
net2.trainParam.lr_inc = 1.05;
net2.trainParam.lr_dec = 0.7;
net2.trainParam.max_perf_inc = 1.04;
net2.trainParam.epochs = 1000; 
net2.trainParam.goal = 1e-3; 
[net2,tr2]=train(net2,p,t);
plotperform(tr2);
t2 = sim(net2,p);
mean(abs(t2-t))

%exercitiul 4 cu sinus
p = -5:0.1:5;
t = sin(p);
net2 = feedforwardnet([3,10,10]);
%net2.layers{1:4}.transferFcn = 'logsig';
%net2.performFcn = 'mse';
net2.divideFcn = '';
net2.trainFcn = 'traingdx';
net2.trainParam.show = 50; 
net2.trainParam.lr = 0.05; 
net2.trainParam.mc = 0.9; 
net2.trainParam.lr_inc = 1.05;
net2.trainParam.lr_dec = 0.7;
net2.trainParam.max_perf_inc = 1.04;
net2.trainParam.epochs = 1000; 
net2.trainParam.goal = 1e-3; 
[net2,tr2]=train(net2,p,t);
plotperform(tr2);
t2 = sim(net2,p);
figure, hold on;
plot(p, t, 'b');
plot(p,t2, 'r');
mean(abs(t2-t))

close all;
figure, hold on;
plot(p,t,'b');
plot(p,t2,'g');


p = -2:.05:2; 
%adauga zgomot
t = sin(2*pi*p)+0.1*randn(size(p));
figure, plot(p,t,'ob');
net = feedforwardnet(20);
net.trainfcn = 'traincgb';%conjugate gradient
net.trainParam.show = 10; 
net.trainParam.epochs = 500; 
net.divideFcn = 'dividerand';
[net,tr]=train(net,p,t);

%exercitiul 5
p = -2:0.001:2;
t1 = sin(2*pi*p);
hold on, plot(p,t1,'b');hold on
t2 = net(p);
plot(p,t2,'r');


[alphabet,targets] = prprob();

for i=1:26
    figure, imagesc(reshape(alphabet(:,i),9,10)');
    pause(0.1);
end

n= 50;sigma = 0.3;
Xp = genereazaLiterePerturbate(alphabet(:,1),n,0.2);

for i=1:n
    figure, imagesc(reshape(Xp(:,i),9,10)');pause(1);close all;
end

X = alphabet;
T = targets;
nrExemple = 3*n;
[exemple, etichete] = genereazaAlfabetPerturbat(X,T,nrExemple,sigma);

net = patternnet(10);
net.trainFcn = 'traingdx';
net.inputs{1}.processFcns = {};
net.outputs{1}.processFcns = {};

permutare = randperm(size(exemple,2));
exemple = exemple(:,permutare);
etichete = etichete(:,permutare);

net.divideFcn = 'divideind';
net.divideParam.trainInd = permutare(1:round(0.4*nrExemple));
net.divideParam.valInd = permutare(round(0.4*nrExemple)+1:round(0.7*nrExemple));
net.divideParam.testInd = permutare(round(0.7*nrExemple)+1:end);


[net,tr] = train(net,exempleAntrenare,eticheteAntrenare);
plotperform(tr);

eticheteTestare = etichete(:,net.divideParam.testInd);
exempleTestare = exemple(:,net.divideParam.testInd);
T2 = compet(sim(net,exempleTestare));

clear eticheta etichetaPrezisa

for i =1:size(eticheteTestare,2)
    eticheta(i) = find(eticheteTestare(:,i)==1);
    etichetaPrezisa(i) = find(T2(:,i)==1);
end
matriceConfuzie = confusionmat(eticheta,etichetaPrezisa)


 

 