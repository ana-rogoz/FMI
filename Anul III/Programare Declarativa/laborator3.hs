import Data.List
import Test.QuickCheck 

-- (L3.1)
-- 1
factori :: Int -> [Int] 
factori n = [x | x <- [1..n], n `rem` x == 0]

-- 2
prim :: Int -> Bool
prim n
  | length (factori n) == 2 = True 
  | otherwise = False

-- 3
numerePrime n = [x|x<-[2..n], prim x == True]

-- 4
ciur [] = []
ciur (x:xs) = x : ciur t
               where t = [y | y <- xs, y `rem` x /= 0]

numerePrimeCiur :: Int -> [Int]
numerePrimeCiur n = ciur [2..n] 

prop_prime :: Int -> Property 
prop_prime n = n >= 0 && n <= 20 ==> numerePrime n == numerePrimeCiur n

-- (L3.2)
myzip3 :: [Int] -> [Int] -> [Int] -> [(Int, Int, Int)]
myzip3 (a:at) (b:bt) (c:ct) = (a, b, c):myzip3 at bt ct
myzip3 _      _      _ = []

-- (L3.3)
-- 1
ordonataNat [] = True
ordonataNat [x] = True
ordonataNat (x:xs) = and [a < b | (a,b) <- zip (x:xs) xs]

-- 2 
ordonataNat1 [] = True
ordonataNat1 [x] = True
ordonataNat1 [x, y] = x < y
ordonataNat1 (x:y:xs) = ordonataNat1 (y:xs) == True && x < y 

prop_ordonataNat :: [Int] -> Bool 
prop_ordonataNat l = ordonataNat l == ordonataNat1 l

-- (L3.4)
-- 1 

ordonata :: [a] -> (a -> a -> Bool) -> Bool
ordonata [] f = True
ordonata [x] f = True
ordonata (x:y:xs) f = f x y == True && ordonata (y:xs) f
-- 2
-- ex. ordonata [1,2,3,4,5] (\x y -> x `mod` y == 0) 
-- ex. ordonata [1,2,3,4,5] (<) 

-- 3 

(*<*) :: (Integer, Integer) -> (Integer, Integer) -> Bool
(*<*) (a,b) (c,d) = a < c && b < d


-- L(3.5)
-- 1
firstEl :: [(a,b)] -> [a]
firstEl l = map (fst) l

-- 2
sumList :: [[Integer]] -> [Integer]
sumList l = map sum l

-- 3
prel2 :: [Integer] -> [Integer]
prel2 l = map (\x -> if x `mod` 2 == 0 then  x `div` 2 else  x * 2) l

-- 4
compuneList :: (b->c) -> [(a->b)] -> [(a->c)]
compuneList f l = map (f.) l

aplicaList :: a -> [a->b] -> [b]
aplicaList x l = map ($x) l

-- 5
myzip3_v2 :: [Integer] -> [Integer] -> [Integer] -> [(Integer, Integer, Integer)]
myzip3_v2 a b c = map (\((a,b),c)-> (a,b,c)) (zip (zip a b) c)   

-- L(3.6) 
-- 1
caracterInSir :: Char -> [[Char]] -> [[Char]]
caracterInSir a x = filter (elem a) x

-- 2
patrateImpare :: [Integer] -> [Integer]
patrateImpare x = map (^2) (filter odd x)

-- 3
patratePozitiiImpare :: [Integer] -> [Integer]
patratePozitiiImpare x = map (\(x,y)->y^2) (filter (odd.fst) (zip [0..] x))

-- 4
numaiVocale :: [[Char]] -> [[Char]]
numaiVocale x = map (\a -> filter (`elem` "aeiouAEIOU") a) x

-- L(3.7)
mymap :: (a->b) -> [a] -> [b]
mymap f [] = []
mymap f (x:xs) = f x : mymap f xs

myfilter :: (a->Bool) -> [a] -> [a]
myfilter f [] = []
myfilter f (x:xs) | f x == True = x : t
                  | otherwise = t
                  where t = myfilter f xs 

-- 1 
mycaracterInSir :: Char -> [[Char]] -> [[Char]]
mycaracterInSir a x = myfilter (elem a) x

-- 2
mypatrateImpare :: [Integer] -> [Integer]
mypatrateImpare x = mymap (^2) (myfilter odd x)

-- 3 
mypatratePozitiiImpare :: [Integer] -> [Integer]
mypatratePozitiiImpare x = mymap (\(x,y)->y^2) (myfilter (odd.fst) (zip [0..] x))

-- 4 
mynumaiVocale :: [[Char]] -> [[Char]]
mynumaiVocale x = mymap (\a -> myfilter (`elem` "aeiouAEIOU") a) x

