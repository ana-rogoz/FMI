element_at([Head|Tail],1,Result) :- Result=Head.
element_at([_|Tail],Nr, Result) :- Nr1 is Nr-1, element_at(Tail, Nr1, Result).