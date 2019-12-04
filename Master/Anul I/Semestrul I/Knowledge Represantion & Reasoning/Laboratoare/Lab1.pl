parent(ion,maria).
parent(ana,maria).
parent(ana,dan).
parent(maria,elena).
parent(maria,radu).
parent(elena,nicu).
parent(radu,george).
parent(radu,dragos).

child(X,Y) :- parent(Y,X).
brother(X,Y) :- parent(Z,X), parent(Z,Y).
grandparent(X,Y) :- parent(X,Z), parent(Z,Y).

% 1) 
max(X,Y,Z) :- X > Y, Z=X; Y > X, Z=Y. 

% 2)
member([H|[]], X) :- H==X.
member([H|T], X) :- H==X; member(T,X).

concatenare([], X, X).
concatenare([H|T], X,[H|Result]) :- concatenare(T,X,Result).

% 3)
alternate_sum([], 0).
alternate_sum([X|[]],X).
alternate_sum([H1,H2|T], S) :- alternate_sum(T,Aux), S is Aux + H1 - H2. 

% 4)
elimina([],_,[]).
elimina([H|T],X,Result) :- H == X, elimina(T,X,Aux), Result=Aux; elimina(T,X,Aux), Result=[H|Aux].

% 5)
reverse([],[]).
reverse([H|T],Result) :- reverse(T,Aux), concatenare(Aux, [H], Result). 

permutare(_,[],[]).
permutare(Left,[H|Right],Perm) :- concatenare(Left, [H], Aux), permutare(Aux, Right, PermAux), concatenare(Right,Aux,Aux2), Perm = [Aux2|PermAux].

% 6)
frecventa([],_, 0).
frecventa([H|T], X, C) :- H==X, frecventa(T, X, Y), C is Y+1; frecventa(T,X,C).

% 7)
insert([],X,_,[X]).
insert(L, X, 0, [X|L]).
insert([H|T], X, N, Res) :- Aux is N-1, insert(T, X, Aux, ResAux), Res = [H|ResAux].

% 8) 
merge([], L, L).
merge(L, [], L).
merge([H1|T1], [H2|T2], Res) :- H1 < H2, merge(T1, [H2|T2], Aux), Res=[H1|Aux];
                                merge([H1|T1], T2, Aux), Res=[H2|Aux].
