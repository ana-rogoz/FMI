% a) Generam multimea S cu 40 puncte.
S = [-3 + (3 + 3)*rand(2,40); zeros(1, 40)];
S(3,:) = (S(1,:) + S(2,:)) > 0; 
save('Desktop/Sgenerat.mat', 'S');

% b) Impartim S in S1 si S2.
coloanaImpara = [1:2:39];
coloanaPara = [2:2:40];
S1 = S(:, coloanaImpara);
S2 = S(:, coloanaPara);
save('Desktop/S1generat.mat', 'S1');
save('Desktop/S2generat.mat', 'S2');

% c) Reprezentare puncte
temp = load('S.mat');
S = temp.S;
temp = load('S1.mat');
S1 = temp.S1;
temp = load('S2.mat');
S2 = temp.S2;

figure(1), hold on;
clasa0 = find(S1(3,:) == 0);
clasa1 = find(S1(3,:) == 1);
plot(S1(1, clasa0), S1(2, clasa0), '+');
plot(S1(1, clasa1), S1(2, clasa1), 'o');
axis([-3 3 -3 3]);

% d) Perceptronul de tip Rosenblatt.
R = perceptron;
R.layers{1}.transferFcn = 'hardlim';
R = configure(R, S1(1:2,:), S1(3,:));
R.InputWeights{1}.initFcn = 'initzero';
R.InputWeights{1}.learnFcn = 'learnp';
R.biases{1}.initFcn = 'initzero';
R.biases{1}.learnFcn = 'learnp';
R.trainParam.epochs = 100;

[R, antrenare] = train(R, S1(1:2,:), S1(3,:));

% e) Plotati curba de separare.
figure(1), hold on;
plotpc(R.IW{1}, R.b{1});

% f) Plotati eroarea de antrenare de la finalul fiecarei epoci.
figure(2);
plot(antrenare.perf);

% g) Carei clase apartine (-1,1).
Punct = [-1; 1];
eticheta = sim(R, Punct);
display(eticheta);

% h) Clasificati toate punctele din S2. 
% Calculati rata de misclasare.
claseS2 = sim(R, S2(1:2,:));
rataExempleMisclasificate = sum(abs(claseS2 - S2(3,:))) / size(S2,2);
display(rataExempleMisclasificate);
% Este posibil ca rata de misclasificare sa fie diferita de 0, intrucat 
% numarul de exemple din S1 pe care perceptronul este antrenat este 
% destul de mic, iar dreapta de separare ce o gaseste perceptronul se poate
% sa nu fie cea de-a doua bisectoare (dreapta dupa care am impartit 
% punctele in S1 si S2 initial). 
% Astfel, pot exista puncte din S2 care sa fie clasificate gresit de catre
% perceptronul antrenat pe multimea S1.

% i) Perceptron de tip Adaline antrenat cu Widrow-Hoff. 
S3(1:2, :) = S1(1:2, :);
S3(3, :) = S1(3, :) * 2 -1; % formez etichete -1 1 pentru S3.
                            % pentru a folosi Widrow-Hoff. 
net = linearlayer;
net.layers{1}.transferFcn = 'purelin';
net = configure(net, S3(1:2,:), S3(3, :));
net.trainFcn = 'trainb';
net.inputWeights{1}.initFcn = 'initzero';
net.inputWeights{1}.learnFcn = 'learnwh';
net.inputWeights{1}.learnParam.lr = 0.005;
net.biasConnect = 0; % Biasul mereu zero pentru ca dreapta sa nu fie transpusa.
net.trainParam.epochs = 1000;

[net, antrenareNet] = train(net, S3(1:2,:), S3(3,:));

claseS2 = sim(net, S2(1:2,:));
S2(3, :) = S2(3, :) * 2 -1 ; % modific si etichetele din S2
                             % din 1 si 0 in -1 si 1.
% Deoarece purelin returneaza o valoare continua 
% trebuie normalizate valorile negative in -1 si cele pozitive in 1.
for i = 1:20 
    if (claseS2(i) < 0)
        claseS2(i) = -1;
    else
        claseS2(i) = 1;
    end
end 

rataExempleMisclasificate2 = sum(abs(claseS2 - S2(3,:))) / size(S2,2);
display(rataExempleMisclasificate2);
