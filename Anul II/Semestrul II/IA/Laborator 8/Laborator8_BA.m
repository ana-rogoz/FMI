X = [-2 -2 -1 -1  0  0  0  0  1  1  2  2  3  3  3  3   4  4  5  5;...
      2  3  1  4  0  1  2  3  0  1  1  2 -1  0  1  2  -2  1 -1  0];
T = [-1 -1 -1 -1 -1 -1 -1 -1  1 -1  1 -1  1  1  1  1   1  1  1  1];

%punctul 1
eticheta1 = find(T==1);
etichetaMinus1 = find(T==-1);
figure(1), hold on;
plot(X(1,eticheta1),X(2,eticheta1),'or');
plot(X(1,etichetaMinus1),X(2,etichetaMinus1),'xb');
axis([min(X(1,:))-1 max(X(1,:))+1 min(X(2,:))-1 max(X(2,:))+1]);

%punctul 2 solutia ecuatiei generale
M = [ones(1,size(X,2)); X];
beta = (M*M')\M *T'; % sau inv(X*X')*X*d
bstar = beta(1);
wstar = beta(2:end);
figure(1);
dreaptaSolutieGlobala = plotpc(wstar',bstar);
set(dreaptaSolutieGlobala,'color','m','linewidth',6);

%punctul 3
%creare perceptron cu functia de transfer purelin
net = perceptron;
net.layers{1}.transferFcn = 'purelin';
net = configure(net,X,T);
%antrenare batch pentru cazul general
net.trainFcn = 'trainb';
net.inputWeights{1}.initFcn = 'initzero';
net.inputWeights{1}.learnFcn = 'learnwh';
net.inputWeights{1}.learnParam.lr = 0.005;
net.biases{1}.initFcn = 'initzero';
net.biases{1}.learnFcn = 'learnwh';
net.biases{1}.learnParam.lr = 0.005;
net.trainParam.epochs = 1000;

net = train(net,X,T);

dreaptaSolutieInvatata = plotpc(net.IW{1},net.b{1});
set(dreaptaSolutieInvatata,'color','k','linewidth',2);

title('Reprezentarea exemplelor si a dreptelor de separare');
legend('exemplele din clasa 1','exemplele din clasa -1','dreapta de separare data de Beta','dreapta de separare invatata');

%punctul 4
%reprezentare 3D
P = [-2 -2 -1 -1 0 0 0 0 1 1 2 2 3 3 3 3 4 4 5 5;...
      2  3  1  4 0 1 2 3 0 1 1 2 -1 0 1 2 -2 1 -1 0;...
     -1 -1 -1 -1 -1 -1 -1 -1 1 -1  1 -1 1 1 1 1 1 1 1 1];
 figure(2), plot3(P(1,:),P(2,:),P(3,:),'sr');hold on;
 [x, y] = meshgrid(-5:0.5:5);
 z = beta(1) + beta(2)*x + beta(3)*y;
 figure(gcf),mesh(x,y,z);

%retea fara bias 
%punctul 5: solutia ecuatiei generale
figure(3), hold on;
plot(X(1,eticheta1),X(2,eticheta1),'or');
plot(X(1,etichetaMinus1),X(2,etichetaMinus1),'xb');
axis([min(X(1,:))-1 max(X(1,:))+1 min(X(2,:))-1 max(X(2,:))+1]);
wstar = (X*X')\ X*T';
bstar = 0;
figure(1);
dreaptaSolutieGlobalaB0 = plotpc(wstar',bstar);
set(dreaptaSolutieGlobalaB0,'color','m','linewidth',6);

%punctul 6
%creare perceptron cu functia de transfer purelin
net = perceptron;
net.layers{1}.transferFcn = 'purelin';
net = configure(net,X,T);
%antrenare batch pentru cazul particular b =0
net.inputWeights{1}.learnFcn = 'learnwh';
net.inputWeights{1}.learnParam.lr = 0.005;
net.biasConnect = 0;
net.trainFcn = 'trainb';
net.trainParam.epochs = 1000;

net = train(net,X,T);
figure(1), hold on;
dreaptaSolutieInvatataB0Batch = plotpc(net.IW{1},0);
set(dreaptaSolutieInvatataB0Batch,'color','r','linewidth',2);

%punctul 7
%reprezentare functie eroare J
figure(3), hold on; 
a1 = -0.7:0.01:0.7;
a2 = -0.7:0.01:0.7;
[A1,A2] = meshgrid(a1,a2);
W = [A1(:) A2(:)];
J = 0.5*sum((W * X - repmat(T,size(W,1),1)).^2,2);
J = reshape(J,length(a1),length(a2));
%sau
J1 = zeros(size(A1));
for i =1:size(J1,1)
    for j = 1:size(J1,2)
        J1(i,j) = 0.5 * sum(([A1(i,j) A2(i,j)] * X - T).^2);
    end
end
figure(3), hold on
surf(a1,a2,J1);
caxis([min(J1(:))-.5*range(J1(:)),max(J1(:))]);
axis([-0.7 0.7 -0.7 0.7 0 max(J1(:))+0.1])
xlabel('x1'); ylabel('x2'); zlabel('Functia criteriu J');

%punctul 8 - antrenare de tip batch cu memorare lui w^k
clear net
net = perceptron;
net.layers{1}.transferFcn = 'purelin';
net = configure(net,X,T);
net.inputWeights{1}.learnFcn = 'learnwh';
net.inputWeights{1}.learnParam.lr = 0.005;
net.biasConnect = 0;
net.trainFcn = 'trainb';
net.trainParam.epochs = 1;
net.trainParam.showWindow = 0;
net.IW{1} = [-0.6 -0.6];
epocaCurenta = 1;%
epocaMaxima = 200;
w1 = zeros(2,epocaMaxima);
J1 = zeros(1,epocaMaxima);
w1(:,epocaCurenta) = net.IW{1};
J1(epocaCurenta) = 0.5* sum((w1(:,epocaCurenta)'*X - T).^2);
epocaCurenta = 2;

while(epocaCurenta<=epocaMaxima)
    [net, antrenare1] = train(net,X,T);
    w1(:,epocaCurenta) = net.IW{1};
    J1(epocaCurenta) = 0.5* sum((w1(:,epocaCurenta)'*X - T).^2);
    epocaCurenta = epocaCurenta+1;
end
figure(gcf);hold on;
%ploteaza primele 20 de iteratii
nrEpoci = 20;
for i=1:nrEpoci
    plot3([w1(1,i),w1(1,i+1)],[w1(2,i),w1(2,i+1)],[J1(i), J1(i+1)],'color',rand(1,3),'linewidth',2);
    drawnow;figure(gcf);
    pause(1);
    disp(['Epoca ' num2str(i)]);
end
%ultima epoca
i = 200;
plot3(w1(1,i),w1(2,i),J1(i),'or','MarkerSize',10);

%punctul 9
%creare perceptron cu functia de transfer purelin
net = perceptron;
net.layers{1}.transferFcn = 'purelin';
net = configure(net,X,T);
%antrenare incrementala cu prezentarea aleatoare a exemplelor
net.inputWeights{1}.initFcn = 'initzero';
net.inputWeights{1}.learnFcn = 'learnwh';
net.inputWeights{1}.learnParam.lr = 0.005;
net.biasConnect = 0;
net.trainFcn = 'trainr';
net.trainParam.epochs = 200;
net = train(net,X,T);
figure(1);hold on;
dreaptaSolutieInvatataB0OnlineAleator = plotpc(net.IW{1},0);
set(dreaptaSolutieInvatataB0OnlineAleator,'color',rand(1,3),'linewidth',2);

%
clear net
%net = newp([min(X(1,:)) max(X(1,:));min(X(2,:)) max(X(2,:))],1,'purelin');
net = perceptron;
net.layers{1}.transferFcn = 'purelin';
net = configure(net,X,T);
net.inputWeights{1}.learnFcn = 'learnwh';
net.inputWeights{1}.learnParam.lr = 0.005;
net.biasConnect = 0;
net.trainFcn = 'trainr';
net.trainParam.epochs = 1;
net.trainParam.showWindow = 0;
epocaCurenta = 1;
epocaMaxima = 200;
w2 = zeros(2,epocaMaxima);
J2 = zeros(1,epocaMaxima);
while(epocaCurenta<=epocaMaxima)
    [net, antrenare2] = train(net,X,T);
    w2(:,epocaCurenta) = net.IW{1};
    J2(epocaCurenta) = 0.5* sum((w2(:,epocaCurenta)'*X - T).^2);
    epocaCurenta = epocaCurenta+1;
end
figure(3);hold on;
%ploteaza primele 20 de iteratii
nrEpoci = 20;
for i=1:nrEpoci
    plot3([w2(1,i),w2(1,i+1)],[w2(2,i),w2(2,i+1)],[J2(i), J2(i+1)],'color',rand(1,3),'linewidth',2);
    pause(1);
end
%ultima epoca
i = 200;
plot3(w2(1,i),w2(2,i),J2(i),'xg','MarkerSize',10);


%punctul 10
%creare perceptron cu functia de transfer purelin
%net = newp([min(X(1,:)) max(X(1,:));min(X(2,:)) max(X(2,:))],1,'purelin');
net = perceptron;
net.layers{1}.transferFcn = 'purelin';
net = configure(net,X,T);
%antrenare incrementala cu prezentarea ciclica a exemplelor
net.inputWeights{1}.initFcn = 'initzero';
net.inputWeights{1}.learnFcn = 'learnwh';
net.inputWeights{1}.learnParam.lr = 0.005;
net.biasConnect = 0;
net.trainFcn = 'trainc';
net.trainParam.epochs = 200;
net = train(net,X,T);
figure(1);hold on;
dreaptaSolutieInvatataB0OnlineDeterminist = plotpc(net.IW{1},0);
set(dreaptaSolutieInvatataB0OnlineDeterminist,'color','b','linewidth',2);
title('Reprezentarea exemplelor si a dreptelor de separare pentru cazul retelei fara bias');
legend('exemplele din clasa 1','exemplele din clasa -1','dreapta de separare data de Beta','dreapta de separare pentru cazul batch',...
    'dreapta de separare pentru cazul incremental aleator', 'dreapta de separare pentru cazul incremental ciclic');

%
clear net
%net = newp([min(X(1,:)) max(X(1,:));min(X(2,:)) max(X(2,:))],1,'purelin');
net = perceptron;
net.layers{1}.transferFcn = 'purelin';
net = configure(net,X,T);
net.inputWeights{1}.learnFcn = 'learnwh';
net.inputWeights{1}.learnParam.lr = 0.005;
net.biasConnect = 0;
net.trainFcn = 'trainc';
net.trainParam.epochs = 1;
net.trainParam.showWindow = 0;
epocaCurenta = 1;
epocaMaxima = 200;
w3 = zeros(2,epocaMaxima);
J3 = zeros(1,epocaMaxima);
while(epocaCurenta<=epocaMaxima)
    [net, antrenare3] = train(net,X,T);
    w3(:,epocaCurenta) = net.IW{1};
    J3(epocaCurenta) = 0.5* sum((w3(:,epocaCurenta)'*X - T).^2);
    epocaCurenta = epocaCurenta+1;
end
figure(3);hold on;
%ploteaza primele 20 de iteratii
nrEpoci = 20;
for i=1:nrEpoci
    plot3([w3(1,i),w3(1,i+1)],[w3(2,i),w3(2,i+1)],[J3(i), J3(i+1)],'b','linewidth',2);
    pause(1);
end
%ultima epoca
i = 200;
plot3(w3(1,i),w3(2,i),J3(i),'db','MarkerSize',10);


%punctul 11
figure(4), hold on;
diferenta1 = zeros(epocaMaxima,1);
diferenta2 = zeros(epocaMaxima,1);
diferenta3 = zeros(epocaMaxima,1);
for i =1:epocaMaxima
    diferenta1(i) = norm(w1(:,i) - wstar,2);
    diferenta2(i) = norm(w2(:,i) - wstar,2);
    diferenta3(i) = norm(w3(:,i) - wstar,2);
end
plot(diferenta1,'r');
plot(diferenta2,'g');
plot(diferenta3,'b');
title('Convergenta algoritmilor de invatare');
legend('cazul batch','cazul incremental aleatoriu','cazul incremental ciclic'); 
