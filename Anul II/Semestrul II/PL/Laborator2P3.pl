fib(1,X) :- X is 1.
fib(0,X) :- X is 0.

fib(X,Y) :- N1 is X-1, N2 is X-2, fib(N1,A), fib(N2,B), Y is A+B.   


fib2(0, 0).
fib2(X, Y):- X > 0, fib2(X, Y, _).
fib2(1, 1, 0).
fib2(X, Y1, Y2) :- X > 1,
             X1 is X - 1,
             fib2(X1, Y2, Y3),
             Y1 is Y2 + Y3.


fib3(1,Val,Last) :- Val is 1, Last is 0.
fib3(2,Val,Last) :- Val is 1, Last is 1.
fib3(N,Val,Last) :- N>2, N1 is N-1, fib3(N1, Last, Last1), Val is Last + Last1.

