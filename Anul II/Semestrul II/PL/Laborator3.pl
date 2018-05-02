equal([],[]).
equal([Head|Tail1],[Head|Tail2]) :- equal(Tail1, Tail2).

numarElemente([],[]).
numarElemente([_|Tail1],[_|Tail2]) :- numarElemente(Tail1, Tail2).

lungimeLista([], 0). % sau lungimeLista([], X) :- X is 0.
lungimeLista([_|Tail], Lungime) :- lungimeLista(Tail,Lungime1), Lungime is Lungime1 + 1.

% Exercitiul 1 a).
all_a([]).
all_a(['a'|Tail]) :- all_a(Tail).
all_a(['A'|Tail]) :- all_a(Tail).

% Exercitiul 1 b).
trans_a_b([],[]).
trans_a_b([a|Tail1],[b|Tail2]) :- trans_a_b(Tail1,Tail2).

% Exercitiul 2 a).
scalarMult(_,[],[]).
scalarMult(X, [Head1|Tail1], [Head2|Tail2]) :- scalarMult(X, Tail1, Tail2), Head2 is X*Head1.

% Exercitiul 2 b).
dot([],[],0).
dot([Head1|Tail1],[Head2|Tail2], Result) :- dot(Tail1, Tail2, ResultX), Result is (ResultX + Head1*Head2).

% Exercitiul 2 c).
max([],0).
max([Head|Tail], Max) :- max(Tail, Max2), Max is max(Head,Max2).

% Exercitiul 3.
myReverse([],[]).
myReverse([Head|Tail],X) :- myReverse(Tail, X1), append(X1, [Head], X).

palindrom(X) :- myReverse(X,L), equal(X,L).

% Exercitiul 4.               
%removeDuplicates([],[]).
%removeDuplicates([Head|Tail],List) :- member(Head,Tail), removeDuplicates(Tail,PrevList), PrevList=List.
% ^ liniile de sus merg oricand.
% prima varianta - removeDuplicates([Head|Tail],[Head1|Tail1]) :- not(member(Head,Tail)), removeDuplicates(Tail,Tail1), Head=Head1.
% a doua varianta - removeDuplicates([Head|Tail],[Head1|Tail1]) :- not(member(Head,Tail)), removeDuplicates(Tail,PrevList), Head=Head1, PrevList=Tail1.
% a 3-a varianta removeDuplicates([Head|Tail],List) :- not(member(Head,Tail)), removeDuplicates(Tail,PrevList), append([Head],PrevList,List).

% varianta initiala in care am schimbat prevList in PrevList si Head trebuie sa fie transformat in lista, deci [Head].
removeDuplicates([],[]).
removeDuplicates([Head|Tail], List) :- 
       ( 
         member(Head,Tail), 
         removeDuplicates(Tail, PrevList),        
         append([], PrevList, List)
       );
       (
         not(member(Head,Tail)), 
         removeDuplicates(Tail,PrevList),
         append([Head], PrevList, List)
       ).

  


