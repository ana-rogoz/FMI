times([],_,[]).
times([x|List1],List2,Result) :- times(List1, List2, X), append(List2, X, Result).