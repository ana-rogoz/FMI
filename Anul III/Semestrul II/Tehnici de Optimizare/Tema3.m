% Titlu: Tema 3
% Autor: Ana-Cristina Rogoz
% Grupa: 332

%%%%%%%%%%%%%%%%
% Simplex primal 
%%%%%%%%%%%%%%%%

%%
% min (2x1 + 20x2) 
% x1 + 2x2 >= 1
% 2x1 + x2 >= 2
% 2x1 + 3x2 >= 3
% 3x1 + 2x2 >= 4
% x1 >= 0, x2 >= 0
% in matricea A trebuie sa fie cu <= 
%% 
% Exemplul 1
A = [-1 -2
        -2 1
        -2 -3
        -3 -2 
        -1 0
        0 -1];

b = [-1 -2 -3 -4 0 0];
f = [20 20]

x = linprog(f, A, b);
display (x)

%%
% min -x(1) - x(2)/3
% x(1)+x(2)<=2
% x(1)+x(2)/4<=1
% x(1)−x(2)<=2
% −x(1)/4−x(2)<=1
% −x(1)−x(2)<=−1
% −x(1)+x(2)<=2
%%
% Exemplul 2
A = [1 1
    1 1/4
    1 -1
    -1/4 -1
    -1 -1
    -1 1
    -1 0
    0 -1];

b = [2 1 2 1 -1 2 0 0];
f = [-1 -1/3];

x = linprog(f, A, b);
display (x)