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

Dupa sortare, initial inseram in coada primul interval, care ar trebui sa contina capatul 
stang ce trebuie acoperit, intrucat avem ramase doar segmente ce intersecteaza. Daca 
primul element ramas dupa sortare nu acopera capatul stang, atunci nu avem solutie. Altfel, 
introducem in stiva, primul interval. Setam capatul drept egal cu capatul drept al primului
interval si continuam astfel, de la intervalul 2, pana la finalul vectorului cu intervale
ramase. La fiecare pas, in primul rand verificam daca noul segment ar aduce o imbunatatire
capatului drept si ar mari acoperirea. Daca imbunatateste, atunci verificam pana cand mai 
avem minim 2 elemente in stiva, daca, scotand primul element din stiva, atunci penultimul
inca s-ar mai intersecta cu intervalul ce vrem sa-l adaugam. Daca da, atunci scoatem 
elementul din varful stivei si continuam procesul pana cand fie mai exista doar 1 element
in stiva, fie penultimul element din stiva si cel ce am vrea sa-l adaugam nu se intersecteaza
in absenta elementului din varf. 

Un caz special il reprezinta cel in care avem un interval ce porneste mai devreme, dar contine 
capatul stang de pornire si un interval ce incepe chiar de pe capatul stang. In cazul acesta, 
verificam de la inceput si pastram doar intervalul ce incepe de pe capatul stang de acoperire.
De asemenea, un al caz il reprezinta cel in care am ajuns cu capatul drept extins pana pe 
ultima pozitie ce trebuie acoperita. In acest moment, programul se va opri, chiar daca mai 
exista alte segmente ce ar putea obtine o mai mare acoperire, intrucat obiectivul a fost atins. 

In final, in stiva se vor afla doar intervalele ce constituie solutia pe care le vom afisa.

O alta modalitate de a demonstra corectitudinea abordarii este: http://varena.ro/job_detail/317577


