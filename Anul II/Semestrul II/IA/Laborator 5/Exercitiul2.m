net = perceptron;

net = configure(net,[0;0;0],0);

net.IW{1} = [0 1 0];
net.b{1} = 0;
net.layers{1}.transferFcn = 'hardlims';

view(net);

X = rand(3,10) * 2 - 1; % 3 linii pentru fiecare caracteristica 
                        % fructe: shape texture weight 
clasePrezise = sim(net,X);
claseAdevarate = (X(2,:) > 0)*2 - 1;

isequal(claseAdevarate,clasePrezise)