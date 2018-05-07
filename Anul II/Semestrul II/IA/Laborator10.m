%%
X = [0 1 0 1; 0 0 1 1]; %input-urile
t = [0 1 1 0]; % target-urile
net = patternnet(2);
view(net);
net.layers{1}.transferFcn = 'hardlim';%setam functiile de transfer
net.layers{2}.transferFcn = 'hardlim';%pentru ambele layere
view(net);
net.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
net.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc
net = configure(net,X,t);%configuram reteaua
view(net);
net.IW{1,1} = [-1 1; 1 -1]; %matricea de ponderi de pe primul strat
                            %stratul 1 primeste de la intrare
net.LW{2,1}=[1 1]; % matricea de ponderi de pe al doilea strat
                   % stratul 2 primeste de la stratul 1 
net.b{1} = [-0.5;- 0.5];
net.b{2} = -0.5; %bias-urile

a=sim(net,X)
isequal(a,t)
a = net(X) %similar cu sim
isequal(a,t)
 
%%
% Tema: de implementat XOR cu drepte ce separa in interior punctele 
% 1 0 si 0 1 (Ex. 3 PDF)

% 4) 
% prima dreapta: x - y + 1 = 0
% a doua dreapta: y = 0
% a 3-a dreapta: - x - y + 1 = 0 
net = patternnet(3);
net.layers{1:2}.transferFcn = 'hardlim';
net.inputs{1}.processFcns = {};
net.outputs{2}.processFcns = {};
net=configure(net, [0;0], 0);
net.IW{1,1} = [1 -1; 0 1; -1 -1];
net.b{1} = [1; 0; 1];
net.LW{2,1} = [1 1 1];
net.b{2} = -2.5;
p = rand(2, 20000) * 4 - 2;
t = net(p);

figure, hold on
ind1 = find(t==1); plot(p(1,ind1), p(2,ind1), 'xr');
ind0 = find(t==0); plot(p(1,ind0), p(2,ind0), 'og');
