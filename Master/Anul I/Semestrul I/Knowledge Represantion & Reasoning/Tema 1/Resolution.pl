% https://www.metalevel.at/logic/plres.pl
pl_resolution(Clauses0, Chain) :-
        maplist(sort, Clauses0, Clauses), % remove duplicates
        iterative_deepening([], Chain, Clauses).

iterative_deepening(Limit, Chain, Clauses0) :-
        (   same_length(Ts, Limit),
            phrase(pl_chain(Clauses0, _), Ts) ->
            (   same_length(Chain, Limit),
                phrase(pl_chain(Clauses0, Clauses), Chain),
                member([], Clauses) -> write("Nesatisfiabil")
            ;   iterative_deepening([_|Limit], Chain, Clauses0)
            )
        ;   write("Satisfiabil")
        ).

pl_chain(Cs, Cs) --> [].
pl_chain(Cs0, Cs) --> [Step],
        { pl_resolvent(Step, Cs0, Rs) },
        pl_chain([Rs|Cs0], Cs).

pl_resolvent((As0-Bs0) --> Rs, Clauses, Rs) :-
        member(As0, Clauses),
        member(Bs0, Clauses),
        select(Q, As0, As),
        select(not(Q), Bs0, Bs),
        append(As, Bs, Rs0),
        sort(Rs0, Rs), % remove duplicates
        maplist(dif(Rs), Clauses).

% Original 
negate(A,n(A)) :- !.
negate(n(A), A).

pl_filter_trivial([], []).
pl_filter_trivial([Clause|Clauses], Result) :-
	member(Lit, Clause),
	pl_negate(Lit, NegLit),
	member(NegLit, Clause),
	!,
	pl_filter_trivial(Clauses, Result).

pl_solve :- read(Clauses0), maplist(sort, Clauses0, Clauses), iterative_resolution(Clauses), !.
iterative_resolution([]) :- write("SATISFIABLE").
iterative_resolution(Clauses) :- member([], Clauses) -> write("UNSATISFIABLE"). 
iterative_resolution(Clauses) :- member(A0, Clauses),
                                 member(B0, Clauses),
    							 select(Lit, A0, A1), 
                                 select(n(Lit), B0, B1),
    							 union(A1, B1, Res), 
                                 delete(Clauses, A0, Clauses1),
                                 delete(Clauses1, B0, Clauses2), 
                                 append([Res],Clauses2, Clauses3), 
                                 iterative_resolution(Clauses3)
    							;
                                 member(A0, Clauses),
                                 member(B0, Clauses),
    							 select(Lit, A0, _), 
                                 \+select(n(Lit), B0, _)
                                 ->   write("SATISFIABLE").


%% fa combine_all 
%% merge pentru [[t], [n(t),c], [n(c),n(f),g], [f],[n(g)]], 
%% dar daca adaug inca 2 clauze nu mai merge 
%select returneaza o lista - nu neaparat cu un element si trb facut combine all intre toate 
%cu lit si n(lit) - vezi curs 3, pag 7]
%
%nu e bine sa aleg primele doua pentru ca pe cazul:
%[[t], [n(t), mb], [n(t),c], [n(c),n(f),g], [f],[n(g)]] combina [t] cu [n(t),mb] si nu mai ajunge 
%niciodata sa faca [t] cu [n(t),c] (vezi curs 3, pag 7) 


% la DP, 2 strategii:
% 1) max lit freq (poz si negativ)
% 2) abs(poz - neg) freq min pentru un lit
