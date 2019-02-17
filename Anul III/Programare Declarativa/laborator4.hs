import Data.List
import Numeric.Natural
import Test.QuickCheck

-- Ex. 1 
-- a) 
produsRec :: [Integer] -> Integer
produsRec [] = 1
produsRec (x:xs) = x * produsRec xs

-- b)
produsFold :: [Integer] -> Integer
produsFold l = foldr (*) 1 l 

-- c)
prop_produs :: [Integer] -> Bool
prop_produs x = produsRec x == produsFold x

-- Ex. 2
-- a) 
andRec :: [Bool] -> Bool
andRec [] = True
andRec (x:xs) = x && andRec xs

-- b)
andFold :: [Bool] -> Bool
andFold x = foldr (&&) True x

-- c) 
prop_and :: [Bool] -> Bool
prop_and x = andRec x == andFold x

-- Ex. 3
-- a)
concatRec :: [[a]] -> [a]
concatRec [] = []
concatRec (x:xs) = x ++ concatRec xs

-- b)
concatFold :: [[a]] -> [a]
concatFold x = foldr (++) [] x

-- c) 
prop_concat :: Eq a => [[a]] -> Bool
prop_concat ls = concatRec ls == concatFold ls

-- Ex. 4
-- a) 
rmChar :: Char -> String -> String
rmChar ch xs = filter (\x -> x /= ch) xs

-- b)
rmCharsRec :: String -> String -> String
rmCharsRec [] l = l
rmCharsRec (x:xs) l = rmCharsRec xs (rmChar x l)

test_rmchars :: Bool
test_rmchars = rmCharsRec ['a'..'l'] "fotbal" == "ot"

-- c)
rmCharsFold :: String -> String -> String
rmCharsFold xs l = foldr (rmChar) l xs

-- d)
prop_rmChars :: String -> String -> Bool
prop_rmChars xs l = rmCharsRec xs l == rmCharsFold xs l

-- Partea II
-- Ex. 1
-- a) 
semn :: [Integer] -> String
semn [] = []
semn (x:xs) 
          | x < 0 && x > -10 = '-':t
          | x == 0 = '0':t
          | x > 0 && x < 10 = '+':t
          | otherwise = t
          where t = semn xs

test_semn :: Bool
test_semn = semn [5,10,-5,0] == "+-0"

-- c)
semnFold :: [Integer] -> String
semnFold = foldr op unit
           where 
             unit = []
             x `op` sol
                       | x < 0 && x > -10 = '-':sol
                       | x == 0 = '0':sol
                       | x > 0 && x < 10 = '+':sol
                       | otherwise = sol

-- Ex. 2
-- a) 
pozitiiPare l = pozPare l 0
                where 
                pozPare [] _ = []
                pozPare (a:as) i
                             |even a = i:sol
                             |otherwise = sol
                             where sol = pozPare as (i+1)

-- b)
pozitiiPareFold :: [Integer] -> [Int]
pozitiiPareFold l = (foldr op unit l) 0
  where
    unit :: Int -> [Int]
    unit = \x -> []
    op :: Integer -> (Int -> [Int]) -> Int -> [Int]
    (a `op` r) p = if even a then p : (r (p + 1)) else r (p + 1)

{-
[1,2,3,4]
(1 op (2 op (3 op (4 op unit)))) 0
x = 1 
r = (2 op (3 op (4 op unit)))
poz = 0
x nu e par => (2 op (3 op (4 op unit))) 1 
x = 2 
r = (3 op (4 op unit)) 
poz = 1 
x e par => 1:(3 op (4 op unit)) 2 = [1,3]
x = 3 
r = 4 op unit
poz = 2
x nu e par => (4 op unit) 3 = [3]
x = 4 
r = unit
poz = 3
x e par => 3:unit 4 => 3:[] = [3]
-}
-- Ex. 3
zipFold :: [a] -> [b] -> [(a,b)]
zipFold as bs = (foldr op unit as) bs 
  where 
  unit :: [b] -> [(a,b)]
  unit _ = []
  op :: a -> ([b] -> [(a,b)]) -> [b] -> [(a,b)]
  (a `op` r) [] = r [] 
  (a `op` r) (x:xs) = (a,x):(r (xs)) 

-- Partea III
logistic :: Num a => a -> a -> Natural -> a
logistic rate start = f
  where
    f 0 = start
    f n = rate * f (n - 1) * (1 - f (n - 1)) 

logistic0 :: Fractional a => Natural -> a
logistic0 = logistic 3.741 0.00079

-- Ex. 1
ex1 :: Natural
ex1 = 10000

-- Ex. 2
ex20 :: Fractional a => [a]
ex20 = [1, logistic0 ex1, 3] -- dureaza 
 
ex21 :: Fractional a => a
ex21 = head ex20
 
ex22 :: Fractional a => a
ex22 = ex20 !! 2
 
ex23 :: Fractional a => [a]
ex23 = drop 2 ex20
 
ex24 :: Fractional a => [a]
ex24 = tail ex20 -- dureaza

-- Ex. 3
ex31 :: Natural -> Bool
ex31 x = x < 7 || logistic0 (ex1 + x) > 2
 
ex32 :: Natural -> Bool
ex32 x = logistic0 (ex1 + x) > 2 || x < 7

ex33 :: Bool
ex33 = ex31 5
 
ex34 :: Bool
ex34 = ex31 7 -- dureaza
 
ex35 :: Bool
ex35 = ex32 5 -- dureaza 
 
ex36 :: Bool
ex36 = ex32 7 -- dureaza

-- Ex. 4
-- a)
findFirst :: (a -> Bool) -> [a] -> Maybe a
findFirst _ [] = Nothing
findFirst f (x:xs) 
                  | f x == True = Just x
                  | otherwise = findFirst f xs 

findFirstNat :: (Natural -> Bool) -> Natural
findFirstNat p = n
  where Just n = findFirst p [0..]

ex4b :: Natural
ex4b = findFirstNat (\n -> n * n >= 12347)

inversa :: Ord a => (Natural -> a) -> (a -> Natural)
inversa f y = n where Just n = findFirst (\x -> f x >= y) [0..]

--  Ex. 5
memoize :: (Natural -> a) -> (Natural -> a)
memoize f = genericIndex tabela
  where    
    tabela = map f [0..]

fibonacci :: Natural -> Natural
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 1) + fibonacci (n - 2)

fibonacciM :: Natural -> Natural
fibonacciM = memoize f
  where
    f 0 = 0
    f 1 = 1
    f n = fibonacciM (n - 1) + fibonacciM (n - 2)

-- Ex. 7
catalan :: Natural -> Natural
catalan 0 = 1
catalan n = sum [catalan i * catalan (n-1-i) | i <- [0..n-1]]

-- b) 
catalanM :: Natural -> Natural
catalanM = memoize catalan 
           where
           catalan 0 = 1
           catalan n = sum [catalanM i * catalanM (n-1-i)| i<-[0..n-1]]

-- Ex. 8
conway :: Natural -> Natural
conway 1 = 1
conway 2 = 1
conway n = conway (conway (n-1)) + conway(n-conway(n-1))

conwayM :: Natural -> Natural
conwayM = memoize conway
          where
          conway 1 = 1
          conway 2 = 1
          conway n = conwayM (conwayM (n-1)) + conwayM(n-conwayM(n-1))

