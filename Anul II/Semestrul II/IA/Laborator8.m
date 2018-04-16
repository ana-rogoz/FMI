P = [-2 -2 -1 -1 0 0 0 0 1 1 2 2 3 3 3 3 4 4 5 5;
      2 3 1 4 0 1 2 3 0 1 1 2 -1 0 1 2 -2 1 -1 0];
T = [-1 -1 -1 -1 -1 -1 -1 -1 1 -1 1 -1 1 1 1 1 1 1 1 1];

ind1 = find(T == 1);
ind2 = find(T == -1);

figure, hold on;
plot(P(1,ind1),P(2,ind1), 'xg');
plot(P(1,ind2),P(2,ind2), 'or');

axis([-5 5 -5 5]);

% 2
X = [ones(1, size(P,2)); P];
d = T';
beta = inv(X*X')*X*d; %solutia 

figure(gcf), plotpc(beta(2:3)', beta(1));
             %[w1*, w2*]         b*
             % nu e dreapta de separare; 
             % eroarea este suma de la dreapta la -1, 1 
             
             
% 4
P = [-2 -2 -1 -1 0 0 0 0 1 1 2 2 3 3 3 3 4 4 5 5;...
 2 3 1 4 0 1 2 3 0 1 1 2 -1 0 1 2 -2 1 -1 0;...
 -1 -1 -1 -1 -1 -1 -1 -1 1 -1 1 -1 1 1 1 1 1 1 1 1];
figure, plot3(P(1,:),P(2,:),P(3,:),'sr');hold on;
[x y] = meshgrid(-5:0.5:5);
z = beta(1) + beta(2)*x + beta(3)*y;
figure(gcf),mesh(x,y,z);
% eroare este suma de la plan la -1, 1 


% 3
P = [-2 -2 -1 -1 0 0 0 0 1 1 2 2 3 3 3 3 4 4 5 5;
      2 3 1 4 0 1 2 3 0 1 1 2 -1 0 1 2 -2 1 -1 0];
T = [-1 -1 -1 -1 -1 -1 -1 -1 1 -1 1 -1 1 1 1 1 1 1 1 1];
net = perceptron;
net.layers{1}.transferFcn = 'purelin';
net = configure(net, P, T);
net.inputWeights{1}.learnFcn = 'learnwh';
net.biases{1}.learnFcn = 'learnwh';
net.trainFcn = 'trainb';
net.trainParam.epochs = 1000;
net.trainParam.lr = 0.005;
net = train(net, P, T);
net.b{1}
net.IW{1}

% 5
d = T';
beta2 = inv(P*P')*P*d; %solutia
P = [-2 -2 -1 -1 0 0 0 0 1 1 2 2 3 3 3 3 4 4 5 5;
      2 3 1 4 0 1 2 3 0 1 1 2 -1 0 1 2 -2 1 -1 0];
T = [-1 -1 -1 -1 -1 -1 -1 -1 1 -1 1 -1 1 1 1 1 1 1 1 1];
net = perceptron;
net.layers{1}.transferFcn = 'purelin';
net = configure(net, P, T);
net.inputWeights{1}.learnFcn = 'learnwh';
net.biases{1}.learnFcn = 'learnwh';
net.trainFcn = 'trainb';
net.trainParam.epochs = 1000;
net.trainParam.lr = 0.005;
net.biasConnect = 0;
net = train(net, P, T);
net.IW{1}
net.b{1}


% 3
P = [-2 -2 -1 -1 0 0 0 0 1 1 2 2 3 3 3 3 4 4 5 5;
      2 3 1 4 0 1 2 3 0 1 1 2 -1 0 1 2 -2 1 -1 0];
T = [-1 -1 -1 -1 -1 -1 -1 -1 1 -1 1 -1 1 1 1 1 1 1 1 1];

[X,Y] = meshgrid(-0.7 : 0.01 : 0.7);
J = zeros(size(X));
for i = 1:size(X,1)
    for j = 1:size(X,2)
        J(i,j) = 0.5 * sum(([X(i,j),Y(i,j)]*P - T).^2);
    end
end

figure, surf(X,Y,J);

