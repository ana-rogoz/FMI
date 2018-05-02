% Problema 3

% a)
symbol('I',Value) :- Value is 1.
symbol('V',Value) :- Value is 5.
symbol('X',Value) :- Value is 10.
symbol('L',Value) :- Value is 50.
symbol('C',Value) :- Value is 100.
symbol('D',Value) :- Value is 500.
symbol('M',Value) :- Value is 1000.

% b)
symbol2number([], []).
symbol2number([Head], [Result]) :- symbol(Head, Result).

/*
 * Varianta 1 - IF
 * 
 * symbol2number([Head1,Head2|Tail1], [Result|Tail2]) :- symbol(Head1,V1), 
    												  symbol(Head2,V2),   
    												  (V2 - V1 > 0 ->  
    												  Result is V2-V1,
                                                      symbol2number(Tail1, Tail2) 
                                                      ;                                        
                                                      Result is V1,
                                                      symbol2number([Head2|Tail1], Tail2)).

*/

/*
 * Varianta 2 - SAU
 * 
 * symbol2number([Head1,Head2|Tail1], [Result|Tail2]) :- symbol(Head1,V1), 
    												  symbol(Head2,V2),   
    												  V2 - V1 > 0,  
    												  Result is V2-V1,
                                                      symbol2number(Tail1, Tail2) 
                                                      ;                                        
                                                      symbol(Head1,V1), 
    												  symbol(Head2,V2),   
    												  V2 - V1 =< 0,  
    												  Result is V1,
                                                      symbol2number([Head2|Tail1], Tail2).
*/

/* 
 * Varianta 3
 *
*/
 
symbol2number([Head1,Head2|Tail1], [Result|Tail2]) :- symbol(Head1,V1), 
    												  symbol(Head2,V2),   
    												  V2 - V1 > 0,  
    												  Result is V2-V1,
                                                      symbol2number(Tail1, Tail2).

symbol2number([Head1,Head2|Tail1], [Result|Tail2]) :- symbol(Head1,V1), 
    												 symbol(Head2,V2),   
    												 V2 - V1 =< 0,  
    												 Result is V1,
                                                     symbol2number([Head2|Tail1], Tail2).


% c)
sum([], 0).
sum([Head|Tail], Sum) :- sum(Tail, SumRec), Sum is SumRec + Head. 

% d)
roman2arabic(Roman, Arabic) :- atom_chars(Roman, RomanChars), symbol2number(RomanChars, ArabicNumbers), 
    						   sum(ArabicNumbers, Arabic).	


