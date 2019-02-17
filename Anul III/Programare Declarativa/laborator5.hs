-- Timp de lucru: 1 ora
-- La sfarsitul fisierului gasiti o lista de functii ajutatoare  

import Data.Char
import Test.QuickCheck
 
type Cifra = Int
type Numar = [Cifra]

-- In acest test vom implementa cateva operatii pe numere mari.
-- O Cifra este un numar intreg intre 0 si 9.
-- Un Numar este o lista de Cifre. E.g., [2,1,4]
-- Numarul intreg reprezentat de un Numar n este obtinut
-- prin alipirea cifrelor lui n de la stanga la dreapta,
-- ignorand cifrele de 0 de la inceputul numarului.
-- E.g., numarul corespunzator lui [0, 0, 0, 2, 1, 4] este 214.
-- Prin conventie lista vida de cifre [] poate reprezenta nr. 0


-- 1a) Scrieti o functie care date fiind un Numar n si o lungime l,
-- adauga l cifre de 0 la stanga lui n.
-- E.g., lungimePlus [2, 1, 4] 3 = [0, 0, 0, 2, 1, 4]
lungimePlus :: Numar -> Int -> Numar
lungimePlus l 0 = l
lungimePlus l nr = lungimePlus (0:l) (nr-1)

-- 1b). Scrieti o functie care ia ca argument o pereche de numere
-- si calculeaza perechea de numere cu numar egal de cifre 
-- obtinuta prin adaugarea de zerouri la stanga numerelor date ca argument.
-- E.g., normalizeazaLungime ([1,2], [3,4,5,6]) = ([0,0,1,2], [3,4,5,6])
-- E.g., normalizeazaLungime ([1,2], []) = ([1,2], [0,0])
normalizeazaLungime :: (Numar, Numar) -> (Numar, Numar)
normalizeazaLungime (l1, l2) 
                            | n1 > n2 = (l1, lungimePlus l2 (n1-n2))
                            | n2 > n1 = (lungimePlus l1 (n2-n1), l2)
                            | otherwise = (l1, l2)
                            where 
                              n1 = length l1
                              n2 = length l2     


-- ==========================================

-- 2a) Scrieti o functie care ia doua Numere *de aceeasi lungime* ca argumente
-- si verifica daca primul Numar este mai mic sau egal cu al doilea.
-- Puteti folosi doar recursie si functii din categoria A
-- E.g., [1,2,3] `lteN` [1,2,1] = False
-- E.g., [0,2,3] `lteN` [1,2,1] = True
lteN :: Numar -> Numar -> Bool
lteN [] [] = True
lteN (x1:l1) (x2:l2) 
                    |x1 < x2 = True
                    |x1 == x2 = lteN l1 l2
                    |otherwise = False

-- 2b).  Scrieti o functie care ia doua Numere ca argumente
-- si verifica daca primul Numar este mai mic sau egal cu al doilea
lte :: Numar -> Numar -> Bool
lte l1 l2 = lteN l1N l2N 
            where 
              (l1N, l2N) = normalizeazaLungime (l1, l2) 
-- ==========================================
-- Puteti rezolva exercitiile urmatoare prin orice metoda doriti, 
-- dar recomandam  rezolvarea folosind functiile foldl si foldr

-- 3a) Scrieti o functie care primeste ca argument un Numar 
-- si calculeaza valoarea de tip Integer care corespunde  Numar-ului respectiv
-- E.g., numar [1,0,4,0,0] = 10400
numar :: Numar -> Int
numar nr = foldl (\n cif -> n*10+cif) 0 nr
-- Sugestie: folositi foldl


-- 3b) Scrieti o functie care primeste ca argument o Cifra c si un Numar n
-- si calculeaza Numarul obtinut prin inmultirea lui n cu c.
-- Atentie: rezultatul trebuie sa fie lista de cifre (fara depasiri peste 10)
-- E.g., 4 `mulC` [1,0,4] = [4,1,6]
-- E.g., 9 `mulC` [9,9] = [8,9,1]
checkRez rez 
            | head rez == 0 = tail rez
            |otherwise = rez

mulC :: Cifra -> Numar -> Numar
mulC cif l = checkRez rez 
             where 
             rez = foldr f [0] l 
               where 
                f x u = [rest,cat] ++ lista
                      where 
                       primul_elem = head(u)
                       lista = drop 1 u
                       cat = (x * cif + primul_elem) `mod` 10
                       rest = (x * cif + primul_elem) `div` 10 
  
-- 3c) Scrieti o functie care primeste ca argument doua Numere
-- si calculeaza suma lor
-- Atentie: rezultatul trebuie sa fie lista de cifre (fara depasiri peste 10)
-- E.g., [7,2,3] `plus` [4,5,7] = [1,1,8,0]
-- E.g., [7,3] `plus` [4,5,7] = [5,3,0]
plus :: Numar -> Numar -> Numar
plus nr1 nr2 = checkRez rez
               where 
               rez = foldr f [0] (zip lista1 lista2)
                 where
                   (lista1, lista2) = normalizeazaLungime (nr1,nr2) 
                   f (a,b) u = [rest, cat] ++ lista
                             where 
                               primul_elem = head(u) 
                               lista = drop 1 u
                               cat = (a+b+primul_elem) `mod` 10
                               rest = (a+b+primul_elem) `div` 10

{- Catcgoria A. Functii de baza
div, mod :: Integral a => a -> a -> a
even, odd :: Integral a => a -> Bool
(+), (*), (-), (/) :: Num a => a -> a -> a
(<), (<=), (>), (>=) :: Ord => a -> a -> Bool
(==), (/=) :: Eq a => a -> a -> Bool
(&&), (||) :: Bool -> Bool -> Bool
not :: Bool -> Bool
max, min :: Ord a => a -> a -> a
isAlpha, isAlphaNum, isLower, isUpper, isDigit :: Char -> Bool
toLower, toUpper :: Char -> Char
ord :: Char -> Int
chr :: Int -> Char
Intervale
[first..], [first,second..], [first..last], [first,second..last]
-}

{- Categoria B. Functii din biblioteci
sum, product :: (Num a) => [a] -> a        
sum [1.0,2.0,3.0] = 6.0                    
product [1,2,3,4] = 24                     

and, or :: [Bool] -> Bool
and [True,False,True] = False
or [True,False,True] = True

maximum, minimum :: (Ord a) => [a] -> a
maximum [3,1,4,2]  =  4                    
minimum [3,1,4,2]  =  1

reverse :: [a] -> [a]
reverse "goodbye" = "eybdoog"

concat :: [[a]] -> [a]                     
concat ["go","od","bye"]  =  "goodbye"     

(++) :: [a] -> [a] -> [a]
"good" ++ "bye" = "goodbye"

(!!) :: [a] -> Int -> a                    
[9,7,5] !! 1  =  7                         

length :: [a] -> Int
length [9,7,5]  =  3

head :: [a] -> a                           
head "goodbye" = 'g'                       

tail :: [a] -> [a]
tail "goodbye" = "oodbye"

init :: [a] -> [a]                         
init "goodbye" = "goodby"                  

last :: [a] -> a
last "goodbye" = 'e'

takeWhile :: (a->Bool) -> [a] -> [a]       
takeWhile isLower "goodBye" = "good"       

take :: Int -> [a] -> [a]
take 4 "goodbye" = "good"

dropWhile :: (a->Bool) -> [a] -> [a]       
dropWhile isLower "goodBye" = "Bye"        

drop :: Int -> [a] -> [a]
drop 4 "goodbye" = "bye"

elem :: (Eq a) => a -> [a] -> Bool         
elem 'd' "goodbye" = True                  

replicate :: Int -> a -> [a]
replicate 5 '*' = "*****"

zip :: [a] -> [b] -> [(a,b)]
zip [1,2,3,4] [1,4,9] = [(1,1),(2,4),(3,9)
-}

{- Categoria C. Map, Filter, Fold
map :: (a -> b) -> [a] -> [b]
map (+3) [1,2] = [4,5]

filter :: (a -> Bool) -> [a] -> [a]
filter even [1,2,3,4] = [2,4]

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr max 0 [1,2,3,4] = 4

(.) :: (b -> c) -> (a -> b) -> a -> c
($) :: (a -> b) -> a -> b
(*2) . (+3) $ 7 = 20

flip :: (a -> b -> c) -> b -> a -> c
flip (-) 2 3 = 1

curry :: ((a, b) -> c) -> a -> b -> c
curry snd 1 2 = 2
uncurry :: a -> b -> c -> (a, b) -> c
uncurry (*) (3,7) = 21
-}
