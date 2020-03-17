% mai multe drepte, un grafic + legenda 
figure, hold on;
plot([-1:0.1:1], [-2:0.1:0]);
plot([-2:0.1:0], [-1:0.1:1], 'r');
plot([-3:0.1:-1], [-1:0.1:1], 'g');
legend('dreapta 1', 'dreapta 2', 'dreata 3');

% 1 - definiti o retea si antrenati pana cand mse <= 0.012
net1 = feedforwardnet(10);
net1 = configure(net1, input, output);
net1.trainFcn = 'traingdm';
net1.inputs{1}.processFcns = {};
net1.outputs{2}.processFcns = {};
net1.trainParam.goal = 0.012;
[net1,antrenare1] = train(net1, input, output);

net2 = feedforwardnet(5);
net2 = configure(net2, input, output);
net2.trainFcn = 'traingda';
net2.inputs{1}.processFcns = {};
net2.outputs{2}.processFcns = {};
net2.trainParam.goal = 0.012;
[net2,antrenare2] = train(net2, input, output);

net3 = feedforwardnet(15);
net3 = configure(net3, input, output);
net3.trainFcn = 'traingdx';
net3.inputs{1}.processFcns = {};
net3.outputs{2}.processFcns = {};
net3.trainParam.goal = 0.012;
[net3,antrenare1] = train(net3, input, output);

% 2 - plotati pentru fiecare arhitectura mse
figure, hold on;
plot(antrenare1.perf, 'k');
plot(antrenare2.perf, 'r');
plot(antrenare3.perf, 'b');
legend('Gradient descent with momentum backpropagation',
        'Gradient descent with adaptive learning rate backpropagation',
        Gradient descent with momentum and adaptive learning rate backpropagation);
        
% 3 - perturbati datele
input = input + rand(size(input,1), size(input,2));

% 4 impartiti datele de la 3 in antrenare 50%, validare 20%, 30 testare
net1.divideFcn = 'dividernd';
net1.divideParam.trainRatio =  0.5;
net1.divideParam.valRatio =  0.3;
net1.divideParam.trainRatio =  0.2;

net2.divideFcn = 'dividernd';
net2.divideParam.trainRatio =  0.5;
net2.divideParam.valRatio =  0.3;
net2.divideParam.trainRatio =  0.2;

net3.divideFcn = 'dividernd';
net3.divideParam.trainRatio =  0.5;
net3.divideParam.valRatio =  0.3;
net3.divideParam.trainRatio =  0.2;

% 5
[net1,antrenare1] = train(net1, input, output);
[net2,antrenare2] = train(net2, input, output);
[net3,antrenare3] = train(net3, input, output);

figure, hold on;
plot(antrenare1.perf, 'k');
plot(antrenare2.perf, 'r');
plot(antrenare3.perf, 'b');
legend('Gradient descent with momentum backpropagation',
        'Gradient descent with adaptive learning rate backpropagation',
        Gradient descent with momentum and adaptive learning rate backpropagation);
        
% 6

