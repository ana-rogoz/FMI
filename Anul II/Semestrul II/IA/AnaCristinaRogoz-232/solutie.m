% a
X2 = [1 1 0 0;
      1 0 0 1;
      0 1 1 0;
      0 0 1 1];

t2 = [0 1 0 1];

% b
netPerceptron = perceptron;
netPerceptron = configure(netPerceptron, X2, t2);
netPerceptron.InputWeights{1}.initFcn = 'initzero';
netPerceptron.InputWeights{1}.learnFcn = 'learnp';
netPerceptron.biases{1}.initFcn = 'initzero';
netPerceptron.biases{1}.learnFcn = 'learnp';
netPerceptron.trainParam.epochs = 1000;

[netPerceptron, antrenarePerceptron] = train(netPerceptron, X2, t2);

% c
clasePerceptron = sim(netPerceptron, X2); 
% Multimea X2 nu este liniar separabila, deoarece oricum am incerca sa
% separam cele doua exemple ale unei clase printr-o dreapta, am include si un 
% exemplu din cealalta clasa. 

% d
net = patternnet(4); % am incercat si cu 2 si 3 perceptroni. 
net.layers{1}.transferFcn = 'logsig';
net.layers{2}.transferFcn = 'softmax';
net.divideFcn = '';
net = configure(net, X2, t2);
net.inputs{1}.processFcns = {};
net.outputs{2}.processFcns = {};
[net, antrenare] = train(net, X2, t2);

clase = sim(net, X2);
eroare = sum(abs(clase - t2)); % eroare este deja foarte mica
for i = 1:4
    if clase(i) <= 0.5
        clase(i) = 0;
    else
        clase(i) = 1;
    end
end

isequal(clase,t2) % true

% e
% genereazaMultimeAntrenare

% f
% perturbaExemple

%g 
n = 25; 
[Xn, Tn] = genereazaMultimeAntrenare(n); %50 exemple
% Generez pana la 500 exemple
XnPerturbat1 = perturbaExemple(Xn, 0.1);
XnPerturbat2 = perturbaExemple(Xn, 0.1);
XnPerturbat3 = perturbaExemple(Xn, 0.1);
XnPerturbat4 = perturbaExemple(Xn, 0.1);
XnPerturbat5 = perturbaExemple(Xn, 0.1);
XnPerturbat6 = perturbaExemple(Xn, 0.1);
XnPerturbat7 = perturbaExemple(Xn, 0.1);
XnPerturbat8 = perturbaExemple(Xn, 0.1);
XnPerturbat9 = perturbaExemple(Xn, 0.1);


multimeAntrenare = [Xn XnPerturbat1 XnPerturbat2 XnPerturbat3 XnPerturbat4 XnPerturbat5 XnPerturbat6 XnPerturbat7 XnPerturbat8 XnPerturbat9];
targetsAntrenare = [Tn Tn Tn Tn Tn Tn Tn Tn Tn Tn];

netFinal = patternnet(n);
netFinal.layers{1}.transferFcn = 'logsig';
netFinal.layers{2}.transferFcn = 'softmax';
netFinal = configure(netFinal, multimeAntrenare, targetsAntrenare);
netFinal.divideFcn = 'dividerand';
netFinal.divideParam.trainRation = 0.7;
netFinal.divideParam.valRatio = 0.3;
netFinal.divideParam.testRatio = 0.3;
netFinal.trainFcn = 'traingdx';
netFinal.trainParam.lr = 0.05; 
netFinal.trainParam.mc = 0.9; 
netFinal.trainParam.lr_inc = 1.05;
netFinal.trainParam.lr_dec = 0.7;
netFinal.trainParam.max_perf_inc = 1.04;
netFinal.trainParam.epochs = 1000; 
netFinal.trainParam.goal = 1e-3; 
[netFinal,antrenareFinal] = train(netFinal, multimeAntrenare, targetsAntrenare);

% Rata de misclasare a exemplelor de antrenare a exemplelor neperturbate? 
claseExempleNeperturbate = sim(netFinal, Xn);
rataDeMisclasare = sum(abs(Tn-claseExempleNeperturbate)) / 50;
