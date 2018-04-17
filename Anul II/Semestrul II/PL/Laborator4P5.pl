born(jan, date(20,3,1977)).
born(jeroen, date(2,2,1992)).
born(joris, date(17,3,1995)).
born(jelle, date(1,1,2004)).
born(joan, date(24,12,0)).
born(joop, date(30,4,1989)).
born(jannecke, date(17,3,1993)).
born(jaap, date(16,11,1995)).

year(X,Person) :- born(Person, date(_,_,X)).
before(date(D1,M1,Y1),date(D2,M2,Y2)) :- Y1 < Y2; (Y1=Y2, M1<M2); (Y1=Y2, M1=M2, D1<D2).
older(X,Y) :- born(X,Data1), born(Y,Data2), before(Data1,Data2). 