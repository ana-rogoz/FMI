%{
Patternnet 
Media pe linii 

Incercari:

solutieVarianta9 -> 263 performance, 0.028984 validation
parametrii: 64 16, logsig, regularization 0.0005, normalization standard
lr 0.008 sau 0.009 -> cu asta am luat 0.89811

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
net.trainParam.lr = 0.008;
net.trainParam.max_fail = 30;
net.trainParam.epochs = 2000;
net.performParam.regularization = 0.0005;
net.performParam.normalization = 'standard';

[net,antrenare] = train(net, inputData, labelDataMatrix);

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


