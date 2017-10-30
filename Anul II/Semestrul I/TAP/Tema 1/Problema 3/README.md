Complexitate timp: O(nlogn)
Complexitate spatiu: O(n)

Input: se citeste n, cardinalul sirului, urmat de sirul de numere naturale

Output: se va afisa partitionare minima a sirului in subsiruri descrescatoare 

Corectitudine:
Inca de la citire, pentru fiecare nou element incercam sa-i gasim pozitia in subsirurile existente. Acest lucru se face printr-o cautare binara, pe capetele subsirurilor existente. Daca elementul curent nu poate contribui intr-un subsir descrescator deja existent, atunci formam un nou subsir cu acesta. Motivul pentru care putem cauta binar pe capetele subsirurilor este pentru ca acestea intotdeauna vor fi in ordine crescatoare, iar datorita acestui fapt, reusim sa pozitionam fiecare nou element pe prima pozitie, mai mare sau egala cu noua valoare (respectand cerinta enuntului, cum ca diferenta dintre ultimul element si cel nou adaugat trebuie sa fie minima. exemplu: subsir 1: 9 7 5   ,iar noua valoare este 3, atunci 3-ul va fi adaugat in primul subsir 
                                        subsir 2: 10 8 7
deoarece 5-3 < 7-3.

Punctul b) prezinta o solutie corecta, intrucat simuleaza efectiv gasirea tuturor subsirurilor din sirul dat intr-o maniera brute force, iar acest fapt duce la o complexitate O(n^2).


                                      
