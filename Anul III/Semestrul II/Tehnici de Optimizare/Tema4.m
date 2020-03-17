% Titlu: Tema 4
% Autor: Ana-Cristina Rogoz
% Grupa: 332

%%%%%%%%%%%%%%%%
% Simplex dual
%%%%%%%%%%%%%%%%

%%
% Problema primala: 
% min (20x1 + 20x2) 
% x1 + 2x2 >= 1
% 2x1 + x2 >= 2
% 2x1 + 3x2 >= 3
% 3x1 + 2x2 >= 4
% x1 >= 0, x2 >= 0

x = optimvar('x','LowerBound',0,'UpperBound',inf);
y = optimvar('y','LowerBound',0,'UpperBound',inf);

prob = optimproblem('Objective', 20*x + 20*y, 'ObjectiveSense', 'min');
prob.Constraints.c1 = x + 2*y >= 1;
prob.Constraints.c2 = 2*x + y >= 2;
prob.Constraints.c3 = x >= 0;
prob.Constraints.c4 = y >= 0;
prob.Constraints.c5 = 2*x + 3*y >= 3;
prob.Constraints.c6 = 3*x + 2*y >= 4;

problem = prob2struct(prob);

[sol, fval, exitflag, output] = linprog(problem)
%% 
% Transformam in problema duala: 
% max x1 + 2x2 + 3x3 + 4x4
% x1 + 2x2 + 2x3 + 3x4 <= 20
% 2x1 + x2 + x3 + 2x4 <= 20
% x1...x4 >= 0

x = optimvar('x','LowerBound',0,'UpperBound',inf);
y = optimvar('y','LowerBound',0,'UpperBound',inf);
z = optimvar('z','LowerBound',0,'UpperBound',inf);
t = optimvar('t','LowerBound',0,'UpperBound',inf);

prob = optimproblem('Objective', x + 2*y + 3*z + 4*t, 'ObjectiveSense', 'max');
prob.Constraints.c1 = x + 2*y + 2*z + 3*t <= 20;
prob.Constraints.c2 = 2*x + y + z + 2*t  <= 20;
prob.Constraints.c3 = x >= 0;
prob.Constraints.c4 = y >= 0;
prob.Constraints.c5 = z >= 0;
prob.Constraints.c6 = t >= 0;

problem = prob2struct(prob);

[sol, fval, exitflag, output] = linprog(problem)