Complexitate timp: O(nlogn) \
Complexitate spatiu: O(n) 

Input: n - numarul de activitati, urmat de perechi lungime_activitate - termen_limita pana la care activitatea respectiva se poate desfasura

Output: ordinea de desfasurare a activitatilor, incluzand intervalul orar de desfasurare si penalizarea minima in urma tuturor celor n evenimente

Corectitudine: 

Principala idee a problemei este faptul ca tot ce conteaza este modul de sortare.
Astfel, o sortare ce reuseste sa obtina penalizarea minima este sortarea crescatoare dupa timpul limita al fiecarei activitati.
La egalitatea timpului limita, nu se tine cont de lungimea activitatii intrucat, daca doua(mai multe) activitati au acelasi timp limita, durata in care cele doua(mai multe) se vor desfasura este aceeasi, indiferent de ordinea in care se executa, iar penalizarea de asemenea nu este influentata de ordine.

Aceasta abordare reuseste sa obtina penalizarea minima, deoarece incearca ca pentru fiecare moment de timp sa obtina penalizarea minima.


Subpunctul b) si subpunctul c) sunt tratate in fisierul cu ExempleSiContraExemple.
Pentru subpunctul b), contraexemplul este insusi exemplul din tema, iar pentru subpunctul c), a fost gasit un alt contraexemplu.

Din acest motiv, nici subpunctul b) si nici subpunctul c) nu reprezinta o modalitate potrivita de sortare. 
