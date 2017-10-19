http://varena.ro/problema/acoperire

Complexitate timp: O(nlogn) 
Complexitate spatiu: O(n)

Input:
a b - intervalul ce trebuie acoperit cu minim de segmente
n - numarul de segmente
x1 y1 
.
.
xn yn - n segmente cu date de capetele stanga-dreapta

Output:
numarul_minim_de_segmente_pentru_acoperire (pe varena)
segmentele necesare pentru a acoperi intregul interval a b, pe cate o linie

Corectitudine:

Inca de la citire, vom elimina segmentele ale caror capat dreapta este mai mic decat a 
si cele ale caror capat stanga este mai mare decat b, deoarece acele segmente nu vor 
intra cu siguranta in solutie. 

Apoi sortam crescator dupa capatul de inceput, pentru a ne asigura ca cel putin capatul 
stang va fi acoperit, iar la egalitatea capatului stang, sortam descrescator dupa 
capatul drept, intrucat, daca avem doua intervale egale in stanga, este mai folositor
cel ce ne permite sa ne extindem cat mai mult in dreapta. 

Dupa sortare, initial inseram in coada primul interval. 

*TBD*
