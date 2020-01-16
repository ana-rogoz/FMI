% Resolution 
% citesc, elimin dubluri daca exista, filtrez clauzele triviale cu lit si n(lit), apelez recursivitatea 
pl_solve_resolution :- read(Clauses0), sort(Clauses0, Clauses), filter_trivial_clauses(Clauses, Clauses1), iterative_resolution(Clauses1), !.
iterative_resolution([]) :- write("SATISFIABLE"). % daca am ajuns cu mt vida de clauze -> satisfiabila  
iterative_resolution(Clauses) :- member([], Clauses) -> write("UNSATISFIABLE"). % daca avem [] printre clauze -> nesat
iterative_resolution(Clauses) :- member(A0, Clauses), % alegem doua clauze, A0, B0 din Clauses, 
                                 member(B0, Clauses),
                                 select(Lit, A0, _), % a.i. A0 sa aiba Lit si B0 negatia lui Lit
                                 select(n(Lit), B0, _),!,
                                 A0 \== B0, % verificam ca A0 si B0 sa fie diferite 
    							 select_clauses(Lit, Clauses, A1), !, %alegem in A1 toate clauzele care il au pe Lit
                                 select_clauses(n(Lit), Clauses, B1), !, % alegem in B1 toate clauzele care il au pe n(Lit)
    							 combine_all(Lit, A1, B1, Res),!, % reuniune intre toate clauzele din A1 si cele din B1 (fara Lit si n(Lit))
                                 delete_all_selected(Clauses, A1, Clauses1),!, % eliminam din Clauses vechile clauze cu Lit si n(Lit)
                                 delete_all_selected(Clauses1, B1, Clauses2), 
                                 append(Res,Clauses2, Clauses3), % atasam la Clauses noile clauze reiesite din reuniune 
                                 sort(Clauses3, Clauses4), % eliminam eventuale duplicate 
    							 filter_trivial_clauses(Clauses4, NextClauses),!, % filter trivial clauses iar
                                 iterative_resolution(NextClauses) % trecem la pasul urmator 
    							;
                                 member(A0, Clauses), % nu mai putem gasi doua clauze a.i. sa existe Lit si n(Lit) deci nu mai avem
                                 member(B0, Clauses), % cum sa facem rez
    							 select(Lit, A0, _), 
                                 \+select(n(Lit), B0, _)
                                 ->   write("SATISFIABLE")
    							;   
                                 member(A0, Clauses), % nu mai putem gasi doua clauze a.i. sa existe Lit si n(Lit) deci nu mai avem
                                 member(B0, Clauses), % cum sa facem rez 
                                 select(n(Lit), B0, _), 
                                 \+select(Lit, A0, _)
                                 ->   write("SATISFIABLE").

select_clauses(_, [], []).
select_clauses(Lit, [H|L], Result) :- member(Lit, H),  % verificam daca Lit face parte din clauza curenta
                                  select_clauses(Lit, L, ResultAux1), %daca da, il eliminam si o atasam la rez
                                  append([H], ResultAux1, Result);
                                  \+member(Lit, H), % daca nu face parte din clauza curenta, nu atasam H 
                                  select_clauses(Lit, L, ResultAux2), 
                                  Result = ResultAux2.
    
combine_all(_, [], _, []).
combine_all(Lit, [H1|T1], List2, Result) :- select(Lit, H1, H2), % eliminam Lit din H1 
    								   combine_one_to_many(n(Lit), H2, List2, ResultAux), !, % reunesc H1 fara Lit cu toate clauzele din List2 
                                       combine_all(Lit, T1, List2, ResultAux2), !,
                                       append(ResultAux, ResultAux2, Result).

combine_one_to_many(_,_, [], []).
combine_one_to_many(Lit, C, [H|T], Result) :- select(Lit, H, H1), % elimin n(Lit) si fac union 
    									 union(C, H1, R),
                                         combine_one_to_many(Lit, C, T, RAux), % apelez recursiv 
                                         append([R], RAux, Result).
    
delete_all_selected([], _,[]). 
delete_all_selected([X|Tail], L2, Result):- member(X, L2), !, delete_all_selected(Tail, L2, Result). % daca X - element din clauses se gaseste in clauzele cu lit/cu n(lit), nu il includem 
delete_all_selected([X|Tail], L2, [X|Result]):- delete_all_selected(Tail, L2, Result). % il includem 

filter_trivial_clauses([], []). 
filter_trivial_clauses([H|L], Result) :- member(Lit, H), % daca o clauza are si lit si n(lit) nu o adaugam 
                                         member(n(Lit), H), !, 
                                         filter_trivial_clauses(L, Result).
filter_trivial_clauses([H|L], [H|Result]) :- filter_trivial_clauses(L, Result).

% Davis Putnam 
% alegem Lit cu freq max 
pl_solve_dp_max_frequencies :- read(Clauses0), sort(Clauses0, Clauses), 
    preprocess_literals(Clauses, Literals), 
    sort(0, @>=, Literals, SortedLiterals), 
    get_values(SortedLiterals, Values),
    dp_recursive(Clauses, Values, Solution, Ans), 
    write(Ans), write("\n"), write(Solution).

pl_solve_dp_min_frequencies :- read(Clauses0), sort(Clauses0, Clauses), 
    preprocess_literals(Clauses, Literals), 
    sort(0, @=<, Literals, SortedLiterals), 
    get_values(SortedLiterals, Values),
    dp_recursive(Clauses, Values, Solution, Ans), 
    write(Ans), write("\n"), write(Solution).

dp_recursive([], Lit , Result, "YES") :- make_true_remaining_literals(Lit, Result), !.
dp_recursive(ClausesIn, _, _, "NO") :- member([], ClausesIn), !.             
dp_recursive(ClausesIn, [Head|Tail], [(Head, "True")|Result], "YES") :- 
    												select_clauses(n(Head), ClausesIn, T1),   
                                                    delete_literal(n(Head), T1, R1), 
                                                    get_clauses_without_literal(ClausesIn, Head, U1),  
                                                    union(R1, U1, Z1),
                                                    dp_recursive(Z1, Tail, Result, "YES"), !.
dp_recursive(ClausesIn, [Head|Tail], [(Head, "False")|Result], "YES") :- 
    												select_clauses(Head, ClausesIn, T0), 
                                                    delete_literal(Head, T0, R0), 
    												get_clauses_without_literal(ClausesIn, Head, U0), 
                                                    union(R0, U0, Z0),
                                                    dp_recursive(Z0, Tail, Result, "YES"), !. 
dp_recursive(_, _, [], "NO").

preprocess_literals(Clauses, Literals) :- find_all_literals(Clauses, Literals0), 
    remove_duplicates(Literals0, UniqueLiterals), 
    make_positive(UniqueLiterals, PositiveLiterals), 
    find_frequencies(Clauses, PositiveLiterals, Literals).

find_frequencies(_, [], []):-!.
find_frequencies(Clauses, [H|T], [(N, H)|Result]) :- find_literal_frequency(Clauses, H, N), 
                                                     find_frequencies(Clauses, T, Result).
find_literal_frequency([], _, 0):- !.
find_literal_frequency([H|T], Lit, N) :- member(Lit, H), find_literal_frequency(T, Lit, N1), !, N is N1 + 1.
find_literal_frequency([H|T], Lit, N) :- member(n(Lit), H), find_literal_frequency(T, Lit, N1), !, N is N1 + 1.
find_literal_frequency([H|T], Lit, N) :- \+member(Lit, H), \+member(n(Lit), H), find_literal_frequency(T, Lit, N), !.

make_true_remaining_literals([], []) :- !.
make_true_remaining_literals([H, T], [(H, "True")|R]) :- make_true_remaining_literals(T, R).

get_values([], []). 
get_values([(_, Lit)|T],[Lit|Result]) :- get_values(T, Result).

get_clauses_without_literal([], _, []).
get_clauses_without_literal([H|T], Lit, [H|Result]) :- \+member(Lit, H), \+member(n(Lit),H), get_clauses_without_literal(T, Lit, Result), !.
get_clauses_without_literal([_|T], Lit, Result) :- get_clauses_without_literal(T, Lit, Result).

delete_literal(_,[], []).            
delete_literal(Lit, [H|T], [Aux|Result]) :- select(Lit, H, Aux), !, delete_literal(Lit, T, Result).
                                                    
make_positive([],[]).
make_positive([n(Head)|Tail], [Head|Result]) :- make_positive(Tail, Result), !.
make_positive([Head|Tail], [Head|Result]) :- make_positive(Tail, Result).

find_all_literals([], []).
find_all_literals([H|T], Result) :- find_all_literals(T, ResultAux),
                                    union(H, ResultAux, Result).
pl_negate(n(A), A) :- !.
pl_negate(A, n(A)).

remove_duplicates([], []).
remove_duplicates([H|T], [H|Result]) :- pl_negate(H, NegH), 
                            member(NegH, T), 
                            select(NegH, T, Aux), 
                            remove_duplicates(Aux, Result), !.
remove_duplicates([H|T], [H|Result]) :- pl_negate(H, NegH), 
                            \+member(NegH, T),
                            remove_duplicates(T, Result), !.