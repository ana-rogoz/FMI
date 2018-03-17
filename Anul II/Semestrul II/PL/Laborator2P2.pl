printline(1,Y) :- write(Y), nl.
printline(X,Y) :- write(Y), N is X-1, printline(N,Y).

printlines(1,Y,Z) :- printline(Y,Z).
printlines(X,Y,Z) :- printline(Y,Z), N is X-1, printlines(N,Y,Z).

square(X,Z) :- printlines(X,X,Z).
