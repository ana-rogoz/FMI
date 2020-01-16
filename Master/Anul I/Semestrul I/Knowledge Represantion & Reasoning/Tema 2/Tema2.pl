ask(Question,Response) :-
         write(Question), nl, 
         read(Response), nl.

askQuestions(List) :- ask("What is patient temperature? (answer is a number)", Response1), 
	              	Response1 \= stop, 
                	ask("For how many days has the patient been sick? (answer is a number)", Response2),
    			Response2 \= stop,
    			ask("Has patient cough? (answer is yes/no)", Response3),
    			Response3 \= stop,
    			makeAnsList(Response1, Response2, Response3, List). 

makeAnsList(Response1, Response2, Response3, Ans) :- 
    Response1 >= 38, Response2 >= 2, Response3 == yes, Ans = [[temperature], [sick], [cough]], !. 
makeAnsList(Response1, Response2, Response3, Ans) :- 
    Response1 >= 38, Response2 >= 2, Response3 == no, Ans = [[temperature], [sick]], !. 
makeAnsList(Response1, Response2, Response3, Ans) :- 
    Response1 >= 38, Response2 < 2, Response3 == yes, Ans = [[temperature], [cough]], !. 
makeAnsList(Response1, Response2, Response3, Ans) :- 
    Response1 < 38, Response2 >= 2, Response3 == yes, Ans = [[sick], [cough]], !. 
makeAnsList(Response1, Response2, Response3, Ans) :- 
    Response1 >= 38, Response2 < 2, Response3 == no, Ans = [[temperature]], !.
makeAnsList(Response1, Response2, Response3, Ans) :- 
    Response1 < 38, Response2 >= 2, Response3 == no, Ans = [[sick]], !.
makeAnsList(Response1, Response2, Response3, Ans) :- 
    Response1 < 38, Response2 < 2, Response3 == yes, Ans = [[cough]], !.
makeAnsList(Response1, Response2, Response3, Ans) :- 
    Response1 < 38, Response2 < 2, Response3 == no, Ans = [], !.

solveBackwardChaining :- askQuestions(List), open('inputB.txt', read, Str), read(Str, Clauses0), close(Str), union(List, Clauses0, FullKB), 
    					 backwardChaining([pneumonia], FullKB, Ans), write("Backward chaining result: "), write(Ans), nl, 
    					 solveBackwardChaining.

backwardChaining([], _, "YES") :- !.
backwardChaining(Literals, KB, Ans) :- forClause(Literals, KB, KB, Ans), !.

forClause(_, [], _, "NO") :- !.
forClause([HLit|TLit], [Hkb|_], KB, Ans) :- member(HLit, Hkb), !, select(HLit, Hkb, Aux1), !,  
                                     	makeNewList(TLit, Aux1, Res),!, backwardChaining(Res, KB, Ans), !.
forClause([HLit|TLit], [Hkb|Tkb], KB, Ans) :- \+member(HLit, Hkb), !, forClause([HLit|TLit], Tkb, KB, Ans). 
                                                                                                        
makeNewList(TLit, [], TLit) :- !. 
makeNewList(TLit, [n(A)|T], [A|Res]) :- makeNewList(TLit, T, Res).  

solveForwardChaining :- askQuestions(List), open('inputF.txt', read, Str), read(Str, Clauses0), close(Str), 
			union(List, Clauses0, FullKB), forwardChaining([pneumonia], [], FullKB, Ans), 
			write("Forward chaining result: "), write(Ans), nl,
                        solveForwardChaining.
 
forwardChaining(Goal, SolvedLiterals, _, "YES") :- checkUnitCase(Goal, SolvedLiterals).
forwardChaining(Goal, SolvedLiterals, KB, Ans) :- forClauseForward(Goal, SolvedLiterals, KB, KB, Ans). 

forClauseForward(_, _, [], _, "NO") :- !. 
forClauseForward(Goal, SolvedLiterals, [[H|T]|_], KB, Ans) :- \+member(H, SolvedLiterals), checkClause(SolvedLiterals, T), !, 
    								union([H], SolvedLiterals, Res),!,	
                                                          	forwardChaining(Goal, Res, KB, Ans), !. 
forClauseForward(Goal, SolvedLiterals, [_|Tkb], KB, Ans) :- forClauseForward(Goal, SolvedLiterals, Tkb, KB, Ans).

checkClause(_, []) :- !.
checkClause(SolvedLiterals, [n(H)|T]) :- member(H, SolvedLiterals), !, checkClause(SolvedLiterals, T), !.
               
checkUnitCase([], _) :- !.                                                              
checkUnitCase([H|T], SolvedLiterals) :- member(H, SolvedLiterals), !, checkUnitCase(T, SolvedLiterals).         



 
askQuestionsWM(List) :- ask("What is patient temperature? (answer is a number)", Response1), 
                	Response1 \= stop,
                	ask("For how many days has the patient been sick? (answer is a number)", Response2),
    			Response2 \= stop,
    			ask("Has patient muscle pain? (answer is yes/no)", Response3),
    			Response3 \= stop,
    			ask("Has patient cough? (answer is yes/no)", Response4),
    			Response4 \= stop,
    			makeAnsListWM(Response1, Response2, Response3, Response4, List). 

makeAnsListWM(Response1, Response2, Response3, Response4, Ans) :- 
    Response1 >= 38, Response2 >= 2, Response3 == yes, Response4 == yes, Ans = [temperature, sick, musclepain, cough], !.
makeAnsListWM(Response1, Response2, Response3, Response4, Ans) :- 
    Response1 >= 38, Response2 >= 2, Response3 == yes, Response4 == no, Ans = [temperature, sick, musclepain], !.
makeAnsListWM(Response1, Response2, Response3, Response4, Ans) :- 
    Response1 >= 38, Response2 >= 2, Response3 == no, Response4 == yes, Ans = [temperature, sick, cough], !. 
makeAnsListWM(Response1, Response2, Response3, Response4, Ans) :- 
    Response1 >= 38, Response2 >= 2, Response3 == no, Response4 == no, Ans = [temperature, sick], !. 
makeAnsListWM(Response1, Response2, Response3, Response4, Ans) :- 
    Response1 >= 38, Response2 < 2, Response3 == yes, Response4 == yes, Ans = [temperature, musclepain, cough], !.
makeAnsListWM(Response1, Response2, Response3, Response4, Ans) :- 
    Response1 >= 38, Response2 < 2, Response3 == yes, Response4 == no, Ans = [temperature, musclepain], !.
makeAnsListWM(Response1, Response2, Response3, Response4, Ans) :- 
    Response1 >= 38, Response2 < 2, Response3 == no, Response4 == yes, Ans = [temperature, cough], !.
makeAnsListWM(Response1, Response2, Response3, Response4, Ans) :- 
    Response1 >= 38, Response2 < 2, Response3 == no, Response4 == no, Ans = [temperature], !.
makeAnsListWM(Response1, Response2, Response3, Response4, Ans) :- 
    Response1 < 38, Response2 >= 2, Response3 == yes, Response4 == yes, Ans = [sick, musclepain, cough], !. 
makeAnsListWM(Response1, Response2, Response3, Response4, Ans) :- 
    Response1 < 38, Response2 >= 2, Response3 == yes, Response4 == no, Ans = [sick, musclepain], !. 
makeAnsListWM(Response1, Response2, Response3, Response4, Ans) :- 
    Response1 < 38, Response2 >= 2, Response3 == no, Response4 == yes, Ans = [sick, cough], !.
makeAnsListWM(Response1, Response2, Response3, Response4, Ans) :- 
    Response1 < 38, Response2 >= 2, Response3 == no, Response4 == no, Ans = [sick], !.
makeAnsListWM(Response1, Response2, Response3, Response4, Ans) :- 
    Response1 < 38, Response2 < 2, Response3 == yes, Response4 == yes, Ans = [musclepain, cough], !.
makeAnsListWM(Response1, Response2, Response3, Response4, Ans) :- 
    Response1 < 38, Response2 < 2, Response3 == yes, Response4 == no, Ans = [musclepain], !.
makeAnsListWM(Response1, Response2, Response3, Response4, Ans) :- 
    Response1 < 38, Response2 < 2, Response3 == no, Response4 == yes, Ans = [cough], !.
makeAnsListWM(Response1, Response2, Response3, Response4, Ans) :- 
    Response1 < 38, Response2 < 2, Response3 == no, Response4 == no, Ans = [], !.

solveForwardChainingWM :-  askQuestionsWM(WM), 
    			open('inputWM.txt', read, Str), read(Str, Clauses0), close(Str),
    			forwardChainingWM(WM, Clauses0, WM), !, nl, 
    			solveForwardChainingWM.

forwardChainingWM(WM, Rules, InitWM) :- recognize(WM, Rules, ConflictSet),
                                resolve(ConflictSet, WM, Ans),
                                forwardChainingWM([Ans|WM], Rules, InitWM), !. 
forwardChainingWM(WM, Rules, InitWM) :- recognize(WM, Rules, ConflictSet), !,
                                \+resolve(ConflictSet, WM, _), 
				open('outputWM.txt', write, Str1), 
				write(Str1, "The initial working memory is empty."), nl(Str1), 
				write(Str1, "The working memory after asking questions is the following: "), write(Str1, InitWM), nl(Str1),                               
				write(Str1, "The final working memory is the following: "), write(Str1, WM), nl(Str1), close(Str1), 
                                checkPneumonia(WM), nl.

checkPneumonia(WM) :- member(pneumonia, WM), write("YES. The patient has pneumonia.").
checkPneumonia(WM) :- \+member(pneumonia, WM), write("NO. The patient doesn't have pneumonia.").

resolve([], _, _) :- false. 
resolve([H|_], WM, H) :- \+member(H, WM).
resolve([H|T], WM, Res) :- member(H, WM), resolve(T, WM, Res).
        
recognize(_, [], []).
recognize(WM, [[Causes|[[Effect|_]|_]]|T], [Effect|Res]) :- canBeInferred(Causes, WM), recognize(WM, T, Res).
recognize(WM, [[Causes|_]|T], Res) :- \+canBeInferred(Causes, WM), recognize(WM, T, Res).

canBeInferred([], _). 
canBeInferred([H|T], WM) :- member(H, WM), canBeInferred(T, WM). 

