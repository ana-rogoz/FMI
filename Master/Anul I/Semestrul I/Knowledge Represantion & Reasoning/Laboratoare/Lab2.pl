la_dreapta(X,Y) :- X is Y + 1.
la_stanga(X,Y) :- la_dreapta(Y,X).
langa(X,Y) :- la_stanga(X,Y); la_dreapta(X,Y).

solutie(Strada, PosesorPeste) :- Strada = [casa(1,_,_,_,_,_), 
                                           casa(2,_,_,_,_,_), 
                                           casa(3,_,_,_,_,_),
		                   		 		   casa(4,_,_,_,_,_),
					  					   casa(5,_,_,_,_,_)],
				 				member(casa(_,englez,rosie,_,_,_), Strada),
				 				member(casa(X1,norvegian,_,_,_,_), Strada),
				 				member(casa(Y1,_, albastra,_,_,_), Strada),
				 				langa(X1,Y1),
                                member(casa(X2,_,verde,_,_,_), Strada),
                                member(casa(Y2,_, alb,_,_,_), Strada),
                                la_stanga(X2,Y2), 
                                member(casa(_,_,verde, cafea,_,_), Strada),
                                member(casa(3,_,_,lapte,_,_), Strada),
                                member(casa(_,_,galben,_,dunhill,_), Strada), 
                                member(casa(1,norvegian,_,_,_,_), Strada), 
                                member(casa(_,suedez,_,_,_,caine),Strada),
                                member(casa(_,_,_,_,pallmall,pasare), Strada),
                                member(casa(X3,_,_,_,marlboro,_), Strada),
                                member(casa(Y3,_,_,_,_,pisica), Strada),
                                langa(X3,Y3),
                                member(casa(_,_,_,bere,winfield,_), Strada),
                                member(casa(X4,_,_,_,_,cal), Strada),
                                member(casa(Y4,_,_,_,dunhill,_), Strada),
                                langa(X4,Y4),
                                member(casa(_,german,_,_,rothmans,_),Strada),
                                member(casa(X5, _,_,_,marlboro,_),Strada),
                                member(casa(Y5,_,_,apa,_,_), Strada),
                                langa(X5,Y5),
                            	member(casa(_,PosesorPeste,_,_,_,peste),Strada).    
        
% de pus variabile in locul _ pentru casa 1, 2,3,4,5 gen casa(1,A1,B1,C1,D1,E1), si dupa member(A1,[1,2,3,4,5]), member(A2,[1,2,3,4,5]),
					  
