%{
Patternnet 
Media pe linii -> cu asta am luat 0.9017

Am incercat initializare parametri cu repartitie uniforma
in intervalul [-3*n^(-0.5); 3*n^(-0.5)]
%}

inputData = load('dataTrain.mat');
inputData = inputData.dataTrain;
labelData = load('labelTrain.mat');
labelData = labelData.labelTrain;
labelDataMatrix = zeros(10, 26700);

medie = zeros(1,30);
for linie = 1:30
    suma = 0;
    nrExemple = 0;
    for coloana = 1:26700 
        if ~isnan(inputData(linie, coloana))
            suma = suma + inputData(linie, coloana);
            nrExemple = nrExemple + 1;
        end
    end
    medie(linie) = suma / nrExemple;
end

for linie = 1:30
    for coloana = 1:26700
        if isnan(inputData(linie, coloana))
            inputData(linie,coloana) = medie(linie);
        end
    end
end

for i = 1:26700
	if labelData(i) == 0
		labelDataMatrix(:,i) = [1 0 0 0 0 0 0 0 0 0]; 
    end
    if labelData(i) == 1
		labelDataMatrix(:,i) = [0 1 0 0 0 0 0 0 0 0];
    end
	if labelData(i) == 2
		labelDataMatrix(:,i) = [0 0 1 0 0 0 0 0 0 0];
    end
    if labelData(i) == 3
		labelDataMatrix(:,i) = [0 0 0 1 0 0 0 0 0 0];
    end
    if labelData(i) == 4
		labelDataMatrix(:,i) = [0 0 0 0 1 0 0 0 0 0];
    end
    if labelData(i) == 5
		labelDataMatrix(:,i) = [0 0 0 0 0 1 0 0 0 0];
    end
    if labelData(i) == 6
		labelDataMatrix(:,i) = [0 0 0 0 0 0 1 0 0 0];
    end
    if labelData(i) == 7
		labelDataMatrix(:,i) = [0 0 0 0 0 0 0 1 0 0];
    end
    if labelData(i) == 8
		labelDataMatrix(:,i) = [0 0 0 0 0 0 0 0 1 0];
    end
    if labelData(i) == 9
		labelDataMatrix(:,i) = [0 0 0 0 0 0 0 0 0 1];
    end
end


net = patternnet([64,16]);
net.layers{1:2}.transferFcn = 'logsig';
net.layers{3}.transferFcn = 'softmax';
net = configure(net, inputData, labelDataMatrix);
net.trainParam.lr = 0.007;
net.trainParam.max_fail = 30;
net.trainParam.epochs = 1000;

valInit30 = 0.54;
valInit64 = 0.37;
valInit16 = 0.75;
valInit32 = 0.53;

%net.IW{1,1} = -valInit30 + 2*valInit30*rand(64,30);
%net.LW{2,1} = -valInit64 + 2*valInit64*rand(10, 64);
%net.LW{3,2} = -valInit16 + 2*valInit16*rand(10, 16);

permutare = zeros(26700, 1);
permutare = randperm(26700);

net.divideFcn = 'divideind';
% T1 in test: 1:2670
net.divideParam.valInd = permutare(1:2670);
net.divideParam.trainInd = permutare(2671:26700);
[net,antrenare] = train(net, inputData, labelDataMatrix);
display("Performanta fold 1 " + antrenare.best_perf);
pause

% T2 in test: 2671:5340
net.divideParam.valInd = permutare(2671:5340);
net.divideParam.trainInd = [permutare(1:2670), permutare(5341:26700)];
[net,antrenare] = train(net, inputData, labelDataMatrix);
display("Performanta fold 2 " + antrenare.best_perf);
pause

% T3 in test: 5341:8010
net.divideParam.valInd = permutare(5341:8010);
net.divideParam.trainInd = [permutare(1:5340), permutare(8011:26700)];
[net,antrenare] = train(net, inputData, labelDataMatrix);
display("Performanta fold 3 " + antrenare.best_perf);
pause

% T4 in test: 8011:10680
net.divideParam.valInd = permutare(8011:10680);
net.divideParam.trainInd = [permutare(1:8010), permutare(10681:26700)];
[net,antrenare] = train(net, inputData, labelDataMatrix);
display("Performanta fold 4 " + antrenare.best_perf);
pause

% T5 in test: 10681:13350
net.divideParam.valInd = permutare(10681:13350);
net.divideParam.trainInd = [permutare(1:10680), permutare(13351:26700)];
[net,antrenare] = train(net, inputData, labelDataMatrix);
display("Performanta fold 5 " + antrenare.best_perf);
pause

% T6 in test: 13351:16020
net.divideParam.valInd = permutare(13351:16020);
net.divideParam.trainInd = [permutare(1:13350), permutare(16020:26700)];
[net,antrenare] = train(net, inputData, labelDataMatrix);
display("Performanta fold 6 " + antrenare.best_perf);
pause

% T7 in test: 16021:18690
net.divideParam.valInd = permutare(16021:18690);
net.divideParam.trainInd = [permutare(1:16020), permutare(18691:26700)];
[net,antrenare] = train(net, inputData, labelDataMatrix);
display("Performanta fold 7 " + antrenare.best_perf);
pause

% T8 in test: 18691:21360
net.divideParam.valInd = permutare(18691:21360);
net.divideParam.trainInd = [permutare(1:18690), permutare(21361:26700)];
[net,antrenare] = train(net, inputData, labelDataMatrix);
display("Performanta fold 8 " + antrenare.best_perf);
pause

% T9 in test: 21361:24030
net.divideParam.valInd = permutare(21361:24030);
net.divideParam.trainInd = [permutare(1:21360), permutare(24031:26700)];
[net,antrenare] = train(net, inputData, labelDataMatrix);
display("Performanta fold 9 " + antrenare.best_perf);
pause

% T10 in test: 24031:26700
net.divideParam.valInd = permutare(24031:26700);
net.divideParam.trainInd = permutare(1:24030);
[net,antrenare] = train(net, inputData, labelDataMatrix);
display("Performanta fold 10 " + antrenare.best_perf);
pause

%[net,antrenare] = train(net, inputData, labelDataMatrix);

inputTest = load('dataTest.mat');
inputTest = inputTest.dataTest;

medie = zeros(1,30);
for linie = 1:30
    suma = 0;
    nrExemple = 0;
    for coloana = 1:12400 
        if ~isnan(inputTest(linie, coloana))
            suma = suma + inputTest(linie, coloana);
            nrExemple = nrExemple + 1;
        end
    end
    medie(linie) = suma / nrExemple;
end

for linie = 1:30
    for coloana = 1:12400
        if isnan(inputTest(linie, coloana))
            inputTest(linie,coloana) = medie(linie);
        end
    end
end

labelTest = sim(net, inputTest);
clase = zeros(12400, 2);

for i = 1:12400
    ansVector = labelTest(:,i);
	maxVector = max(ansVector);	
	pozMax = find(ansVector == maxVector);
	clase(i,1) = i;
	clase(i,2) = pozMax - 1;
end

csvwrite('Desktop/IA/solutie.csv', clase);


