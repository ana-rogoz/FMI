% Problema 1
la_dreapta(X,Y) :- X is Y + 1.
la_stanga(X,Y) :- la_dreapta(Y,X).
langa(X,Y) :- la_stanga(X,Y); la_dreapta(X,Y).

solutie(Strada, PosesorZebra, BeaApa) :- Strada = [casa(1,_,_,_,_,_), 
                                           casa(2,_,_,_,_,_), 
                                           casa(3,_,_,_,_,_),
		                   		 		   casa(4,_,_,_,_,_),
					  					   casa(5,_,_,_,_,_)],
				 				member(casa(_,englez,rosie,_,_,_), Strada),
				 				member(casa(_,spaniol,_,caine,_,_), Strada),
				 				member(casa(_,_,verde,_,cafea,_), Strada),
				 				member(casa(_,ucrainean,_,_,ceai,_), Strada),
				 				member(casa(X4,_,verde,_,_,_), Strada),
                                member(casa(Y4,_,bej,_,_,_), Strada),
				 				la_dreapta(X4,Y4),
				 				member(casa(_,_,_,melci,_,oldgold), Strada),
				 				member(casa(_,_,galben,_,_,kools), Strada),
			         			member(casa(3,_,_,_,lapte,_), Strada),
			         			member(casa(1,norvegian,_,_,_,_), Strada),
				 				member(casa(X1,_,_,_,_,chesterfields), Strada),
			         			member(casa(Y1,_,_,vulpe,_,_), Strada), 
				 				langa(X1,Y1),
                                member(casa(X2,_,_,_,_,kools), Strada),
				 				member(casa(Y2,_,_,cal,_,_), Strada),
				 				langa(X2,Y2),
				 				member(casa(_,_,_,_,sucdeportocale,luckystrike), Strada),
                                member(casa(_,japonez,_,_,_,parliament), Strada),
                                member(casa(X3,norvegian,_,_,_,_), Strada),
				 				member(casa(Y3,_,albastru,_,_,_), Strada),
				 				langa(X3,Y3),
				 				member(casa(_,PosesorZebra,_,zebra,_,_), Strada),
    							member(casa(_,BeaApa,_,_,apa,_), Strada).



					  
