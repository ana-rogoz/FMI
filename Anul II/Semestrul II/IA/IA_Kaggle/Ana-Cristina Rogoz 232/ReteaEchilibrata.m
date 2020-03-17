inputData = load('dataTrain.mat');
inputData = inputData.dataTrain;
labelData = load('labelTrain.mat');
labelData = labelData.labelTrain;
labelDataMatrix = zeros(10, 7454);

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

exemple0 = find(labelData == 0);
exemple1 = find(labelData == 1);
exemple2 = find(labelData == 2);
exemple3 = find(labelData == 3);
exemple4 = find(labelData == 4);
exemple5 = find(labelData == 5);
exemple6 = find(labelData == 6);
exemple7 = find(labelData == 7);
exemple8 = find(labelData == 8);
exemple9 = find(labelData == 9, 750);

inputDataEchilibrat = [inputData(:,exemple0) inputData(:,exemple1) inputData(:,exemple2) inputData(:,exemple3) inputData(:,exemple4) inputData(:,exemple5) inputData(:,exemple6) inputData(:, exemple7) inputData(:,exemple8) inputData(:,exemple9)];
labelDataEchilibrat = [repelem(0, 774) repelem(1, 767) repelem(2, 773) repelem(3, 708) repelem(4, 771) repelem(5, 711) repelem(6, 713) repelem(7, 772) repelem(8, 715) repelem(9, 750)];


for i = 1:7454
	if labelDataEchilibrat(i) == 0
		labelDataMatrix(:,i) = [1 0 0 0 0 0 0 0 0 0];  
    end
    if labelDataEchilibrat(i) == 1
		labelDataMatrix(:,i) = [0 1 0 0 0 0 0 0 0 0];
    end
	if labelDataEchilibrat(i) == 2
		labelDataMatrix(:,i) = [0 0 1 0 0 0 0 0 0 0];
    end
    if labelDataEchilibrat(i) == 3
		labelDataMatrix(:,i) = [0 0 0 1 0 0 0 0 0 0];
    end
    if labelDataEchilibrat(i) == 4
		labelDataMatrix(:,i) = [0 0 0 0 1 0 0 0 0 0];
    end
    if labelDataEchilibrat(i) == 5
		labelDataMatrix(:,i) = [0 0 0 0 0 1 0 0 0 0];
    end
    if labelDataEchilibrat(i) == 6
		labelDataMatrix(:,i) = [0 0 0 0 0 0 1 0 0 0];
    end
    if labelDataEchilibrat(i) == 7
		labelDataMatrix(:,i) = [0 0 0 0 0 0 0 1 0 0];
    end
    if labelDataEchilibrat(i) == 8
		labelDataMatrix(:,i) = [0 0 0 0 0 0 0 0 1 0];
    end
    if labelDataEchilibrat(i) == 9
		labelDataMatrix(:,i) = [0 0 0 0 0 0 0 0 0 1];
    end
end


net = patternnet([64,16]);
net.layers{1:2}.transferFcn = 'logsig';
net.layers{3}.transferFcn = 'softmax';
net = configure(net, inputDataEchilibrat, labelDataMatrix);
net.trainParam.lr = 0.008;
%net.trainParam.max_fail = 30;
net.trainParam.goal = 0.05;
net.trainParam.epochs = 2000;

net.divideFcn = '';
[net,antrenare] = train(net, inputDataEchilibrat, labelDataMatrix);
%{
[net,antrenare] = train(net, inputDataEchilibrat, labelDataMatrix);
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 0.8;
net.divideParam.valRatio = 0.2;
net.divideParam.testRatio = 0;
[net,antrenare] = train(net, inputDataEchilibrat, labelDataMatrix);
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 0.8;
net.divideParam.valRatio = 0.2;
net.divideParam.testRatio = 0;
[net,antrenare] = train(net, inputDataEchilibrat, labelDataMatrix);
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 0.8;
net.divideParam.valRatio = 0.2;
net.divideParam.testRatio = 0;
[net,antrenare] = train(net, inputDataEchilibrat, labelDataMatrix);
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 0.8;
net.divideParam.valRatio = 0.2;
net.divideParam.testRatio = 0;

%}

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


claseVarianta1 = csvread('solutieMAIB260.csv');

claseFinal = zeros(12400, 2);
for i = 1:12400
    claseFinal(i,1) = i;
    if claseVarianta1(i,2) == 9
        claseFinal(i,2) = claseVarianta1(i,2);
    end
    if claseVarianta1(i,2) ~= 9
        claseFinal(i,2) = clase(i,2);
    end
end

csvwrite('Desktop/IA/solutieEchilibrata.csv', claseFinal);