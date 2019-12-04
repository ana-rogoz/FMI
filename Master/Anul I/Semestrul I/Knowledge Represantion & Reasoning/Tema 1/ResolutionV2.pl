% Original 
pl_solve :- read(Clauses0), sort(Clauses0, Clauses),iterative_resolution(Clauses), !.
iterative_resolution([]) :- write("SATISFIABLE").
iterative_resolution(Clauses) :- member([], Clauses) -> write("UNSATISFIABLE"). 
iterative_resolution(Clauses) :- member(A0, Clauses),
                                 member(B0, Clauses),
                                 select(Lit, A0, _),
                                 select(n(Lit), B0, _),!,
    							 select_clauses(Lit, Clauses, A1), !, 
                                 select_clauses(n(Lit), Clauses, B1), !, 
    							 combine_all(Lit, A1, B1, Res),!, 
                                 delete_all_selected(Clauses, A1, Clauses1),!,
                                 delete_all_selected(Clauses1, B1, Clauses2), 
                                 append(Res,Clauses2, Clauses3), 
                                 iterative_resolution(Clauses3)
    							;
                                 member(A0, Clauses),
                                 member(B0, Clauses),
    							 select(Lit, A0, _), 
                                 \+select(n(Lit), B0, _)
                                 ->   write("SATISFIABLE").

delete_all_selected([], _,[]).
delete_all_selected([X|Tail], L2, Result):- member(X, L2), !, delete_all_selected(Tail, L2, Result). 
delete_all_selected([X|Tail], L2, [X|Result]):- delete_all_selected(Tail, L2, Result).

select_clauses(_, [], []).
select_clauses(Lit, [H|L], Result) :- member(Lit, H),  
                                  select_clauses(Lit, L, ResultAux1),
                                  append([H], ResultAux1, Result);
                                  \+member(Lit, H),
                                  select_clauses(Lit, L, ResultAux2), 
                                  Result = ResultAux2.
    
combine_all([], _, []).
combine_all(Lit, [H1|T1], List2, Result) :- select(Lit, H1, H2),
    								   combine_one_to_many(n(Lit),H2, List2, ResultAux), !, 
                                       combine_all(T1, List2, ResultAux2), 
                                       append(ResultAux, ResultAux2, Result).

combine_one_to_many(_,_, [], []).
combine_one_to_many(Lit, C, [H|T], Result) :- select(Lit, H, H1),
    									 union(C, H1, R), 
                                         combine_one_to_many(Lit, C, T, RAux),
                                         append([R], RAux, Result).
    
%^ 
%% pare ca merge varianta de sus :)  