import Numeric.Natural

import Data.List (genericIndex)

produsRec :: [Integer] -> Integer
produsRec = undefined

produsFold :: [Integer] -> Integer
produsFold = undefined

prop_produs :: [Integer] -> Bool
prop_produs = undefined

andRec :: [Bool] -> Bool
andRec = undefined

andFold :: [Bool] -> Bool
andFold = undefined

prop_and :: [Bool] -> Bool
prop_and = undefined

concatRec :: [[a]] -> [a]
concatRec = undefined

concatFold :: [[a]] -> [a]
concatFold = undefined

prop_concat :: Eq a => [[a]] -> Bool
prop_concat = undefined

rmChar :: Char -> String -> String
rmChar = undefined

rmCharsRec :: String -> String -> String
rmCharsRec = undefined
 
test_rmchars :: Bool
test_rmchars = rmCharsRec ['a'..'l'] "fotbal" == "ot"

rmCharsFold :: String -> String -> String
rmCharsFold = undefined

prop_rmChars :: String -> String -> String
prop_rmChars = undefined

foldr_ :: (a -> b -> b) -> b -> ([a] -> b)
foldr_ op unit = f
  where
    f []     = unit
    f (a:as) = a `op` f as

sumaPatrateImpare :: [Integer] -> Integer
sumaPatrateImpare []     = 0
sumaPatrateImpare (a:as)
  | odd a = a * a + sumaPatrateImpare as
  | otherwise = sumaPatrateImpare as

sumaPatrateImpareFold :: [Integer] -> Integer
sumaPatrateImpareFold = foldr op unit
  where
    unit = 0
    a `op` suma
      | odd a     = a * a + suma
      | otherwise = suma

map_ :: (a -> b) -> [a] -> [b]
map_ f []     = []
map_ f (a:as) = f a : map_ f as

mapFold :: (a -> b) -> [a] -> [b]
mapFold f = foldr op unit
  where
    unit = []
    a `op` l = f a : l

filter_ :: (a -> Bool) -> [a] -> [a]
filter_ p [] = []
filter_ p (a:as)
  | p a       = a : filter_ p as
  | otherwise = filter_ p as

filterFold :: (a -> Bool) -> [a] -> [a]
filterFold p = foldr op unit
  where
    unit = []
    a `op` filtered
      | p a       = a : filtered
      | otherwise = filtered

semn :: [Integer] -> String
semn = undefined

test_semn :: Bool
test_semn = semn [5, 10, -5, 0] == "+-0" -- 10 este ignorat

semnFold :: [Integer] -> String
semnFold = foldr op unit
  where
    unit = undefined
    op = undefined

medie :: [Double] -> Double
medie l = f l 0 0
  where
    f :: [Double] -> Double -> Double-> Double
    f [] n suma = suma / n
    f (a:as) n suma = f as (n + 1) (suma + a)

medieFold :: [Double] -> Double
medieFold l = (foldr op unit l) 0 0  -- paranteze doar pentru claritate
  where
    unit :: Double -> Double -> Double
    unit n suma = suma / n
    op :: Double -> (Double -> Double -> Double) -> (Double -> Double -> Double)
    (a `op` r) n suma = r (n + 1) (suma + a)

pozitiiPare :: [Integer] -> [Int]
pozitiiPare l = pozPare l 0 -- al doilea argument tine minte pozitia curenta
  where
    pozPare [] _ = []
    pozPare (a:as) i
      | even a = i:pozPare as (i+1)
      | otherwise = pozPare as (i+1)

test_pozitiiPare :: Bool
test_pozitiiPare = pozitiiPare [5, 10, -5, 0] == [1,3]

pozitiiPareFold :: [Integer] -> [Int]
pozitiiPareFold l = (foldr op unit l) 0
  where
    unit :: Int -> [Int]
    unit = undefined
    op :: Integer -> (Int -> [Int]) -> (Int -> [Int])
    (a `op` r) p = undefined

zipFold :: [a] -> [b] -> [(a,b)]
zipFold as bs = (foldr op unit as) bs
  where
    unit :: [b] -> [(a,b)]
    unit = undefined
    op :: a -> ([b] -> [(a,b)]) -> [b] -> [(a,b)]
    op = undefined

logistic :: Num a => a -> a -> Natural -> a
logistic rate start = f
  where
    f 0 = start
    f n = rate * f (n - 1) * (1 - f (n - 1)) 

logistic0 :: Fractional a => Natural -> a
logistic0 = logistic 3.741 0.00079

ex1 :: Natural
ex1 = undefined

ex20 :: Fractional a => [a]
ex20 = [1, logistic0 ex1, 3]
 
ex21 :: Fractional a => a
ex21 = head ex20
 
ex22 :: Fractional a => a
ex22 = ex20 !! 2
 
ex23 :: Fractional a => [a]
ex23 = drop 2 ex20
 
ex24 :: Fractional a => [a]
ex24 = tail ex20

ex31 :: Natural -> Bool
ex31 x = x < 7 || logistic0 (ex1 + x) > 2
 
ex32 :: Natural -> Bool
ex32 x = logistic0 (ex1 + x) > 2 || x < 7

ex33 :: Bool
ex33 = ex31 5
 
ex34 :: Bool
ex34 = ex31 7
 
ex35 :: Bool
ex35 = ex32 5
 
ex36 :: Bool
ex36 = ex32 7

findFirst :: (a -> Bool) -> [a] -> Maybe a
findFirst = undefined

findFirstNat :: (Natural -> Bool) -> Natural
findFirstNat p = n
  where Just n = findFirst p [0..]

ex4b :: Natural
ex4b = findFirstNat (\n -> n * n >= 12347)

inversa :: Ord a => (Natural -> a) -> (a -> Natural)
inversa = undefined

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

catalan :: Natural -> Natural
catalan 0 = 1
catalan n = sum [catalan i * catalan (n - 1 - i) | i <- [0..n-1]]

conway :: Natural -> Natural
conway 1 = 1
conway 2 = 1
conway n = conway (conway (n - 1)) + conway (n - conway (n - 1))

