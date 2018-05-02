% Problema 2
include('words.pl').

word_letters(Word, Letters) :- atom_chars(Word, Letters).


cover([],_).
cover([Head1|Tail1], List2) :- select(Head1,List2, List3), cover(Tail1, List3).

solution(ListLetters, Word, Length) :- word(Word), word_letters(Word,LettersWord), length(LettersWord, Length), cover(LettersWord,ListLetters). 

topsolution(Letters, Word, Lmax) :- length(Letters, N1), topsolutionCount(Letters, Word, Lmax, N1).

topsolutionCount(_, _,_,0).
topsolutionCount(Letters, Word, N, N) :- solution(Letters, Word, N).
topsolutionCount(Letters, Word,Lmax, N) :- N1 is N-1, topsolutionCount(Letters, Word, Lmax, N1).
