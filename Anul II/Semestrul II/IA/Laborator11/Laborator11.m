% Ex 1 - antrenati retea corespunzatoare ex 4 din lab10
% Exercitiul cu triunghi

% Exercitiul 4, lab 10
net = patternnet(3);
net.layers{1:2}.transferFcn = 'hardlim';
net.inputs{1}.processFcns = {};
net.outputs{2}.processFcns = {};
net=configure(net, [0;0], 0);
net.IW{1,1} = [1 -1; 0 1; -1 -1];
net.b{1} = [1; 0; 1];
net.LW{2,1} = [1 1 1];
net.b{2} = -2.5;
p = rand(2, 2000) * 4 - 2;
t = net(p);
% Sfarsit exercitiu 4, lab 10


multimeDate = p; % Iau multimea de antrenare
multimeTarget = t; % Iau targeturile multimii

netTriunghi = patternnet(3);
netTriunghi.layers{1:2}.transferFcn = 'logsig';
netTriunghi.inputs{1}.processFcns = {};
netTriunghi.outputs{2}.processFcns = {};
netTriunghi = configure(netTriunghi, multimeDate, multimeTarget);
netTriunghi.divideFcn = ''; % Antrenez pe toata multimea
netTriunghi.trainParam.epochs = 5000;
netTriunghi.trainParam.goal = 0.001;
[netTriunghi, antrenare] = train(netTriunghi, multimeDate, multimeTarget);
netTriunghi.layers{2}.transferFcn = 'hardlim';
a = sim(netTriunghi, multimeDate);
isequal(a,multimeTarget);

% Exercitiul 2

% Plotam functia in trepte cu parametri dati.
netf = feedforwardnet(2);
netf.layers{1:2}.transferFcn = 'logsig';
netf.inputs{1}.processFcns = {};
netf.outputs{2}.processFcns = {};
netf = configure(netf,0,0);
netf.IW{1,1} = [10 10]';
netf.b{1} = [-5 5]';
netf.LW{2,1} = [1 1];
netf.b{2} = -1;
view(netf);
%plotam functia implementata de retea
p = -2:0.001:2; 
t = sim(netf,p);
figure(1),hold on;
plot(p,t,'b');

% Luam o multime mai mica de puncte si vrem sa antrenam o retea. 
p = -2:0.1:2;
t = sim(netf,p); %calculam targeturile pe baza retelei precedente. 
figure(2), hold on;
plot(p,t,'xr');

% Definim o noua retea pe care vrem sa o antrenam pentru a vedea cat 
% de mult se apropie de functia optima pe care ne-o dorim.
net = feedforwardnet(2);
net.layers{1:2}.transferFcn = 'logsig';
net.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
net.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc
net = configure(netf,0,0);
net.trainFcn = 'traingd'; %antrenare cu batch gradient descend - coborare pe
                          %gradient varianta batch
net.trainParam.lr = 0.05;%rata de invatare
net.trainParam.epochs = 1000; %nr de epoci
net.trainParam.goal = 1e-5;%valoarea erorii pe care vrem sa o atingem
[net,tr]=train(net,p,t); %antrenarea retelei

p = -2:0.001:2; %luam multimea mare pe care am obtinut functia optima
                % si aflam etichetele pe care i le da reteaua antrenata
                % pe setul de date mai mic. 
t1 = sim(net, p); 
figure(1), hold on; 
plot(p, t1, 'r');


