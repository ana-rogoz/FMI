% a) genereaza puncte uniform [-3,3]
S = [-3 + (3 + 3)*rand(2,40); zeros(1, 40)];

% clasifica puncte desupra/dedesubtul celei de a doua bisectoare
S(3,:) = (S(1,:) + S(2,:)) > 0;
%clasa0 = find(S(3,:) == 0);
%clasa1 = find(S(3,:) == 1);
%figure(1), hold on;
%plot(S(1,clasa0),S(2,clasa0), 'or');
%plot(S(1,clasa1),S(2,clasa1), 'xm');

% b) imparte punctele in S1 si S2
ordonataPozitiva = find(S(2,:) > 0);
ordonataNegativa = find(S(2,:) <= 0);
S1 = S(:, ordonataPozitiva);
S2 = S(:, ordonataNegativa);

% c) plotati punctele din S1
figure(2), hold on;
clasa0 = find(S1(3,:) == 0);
clasa1 = find(S1(3,:) == 1);
plot(S1(1, clasa0), S1(2, clasa0), '+');
plot(S1(1, clasa1), S1(2, clasa1), 'o');
axis([-3 3 -3 3]);

% d) perceptron Rosenblatt
R = perceptron;
R.layers{1}.transferFcn = 'hardlim';
R = configure(R, S1(1:2,:), S1(3,:));
R.trainFcn = 'trainb';
R.InputWeights{1}.initFcn = 'initzero';
R.InputWeights{1}.learnFcn = 'learnp';
R.biases{1}.initFcn = 'initzero';
R.biases{1}.learnFcn = 'learnp';
R.trainParam.epochs = 100;

[R, antrenare] = train(R, S1(1:2,:), S1(3,:));

% e) plot dreapta de antrenare
figure(2), hold on;
plotpc(R.IW{1},R.b{1});

% f) evolutia graficului de antrenare
figure(3)
plot(antrenare.perf);

% g) in ce clasa [-1, 1]
Punct = [-1; 1];
clasa = sim(R, Punct);
figure(2), hold on
plot(Punct(1), Punct(2), '*r');

% h)
claseS2 = sim(R, S2(1:2,:));
rezultat = isequal(claseS2, S2(3,:));
eroare = sum(abs(claseS2 - S2(3,:))) / size(S2,2);
