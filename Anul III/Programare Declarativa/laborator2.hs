import Test.QuickCheck


---------------------------------------------
-------RECURSIE: FIBONACCI-------------------
---------------------------------------------

fibonacciCazuri :: Integer -> Integer
fibonacciCazuri n
  | n < 2     = n
  | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)

fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1
fibonacciEcuational n =
    fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)

{-| @fibonacciLiniar@ calculeaza @F(n)@, al @n@-lea element din secvența
Fibonacci în timp liniar, folosind funcția auxiliară @fibonacciPereche@ care,
dat fiind @n >= 1@ calculează perechea @(F(n-1), F(n))@, evitănd astfel dubla
recursie. Completați definiția funcției fibonacciPereche.
Indicație:  folosiți matching pe perechea calculată de apelul recursiv.
-}
fibonacciLiniar :: Integer -> Integer
fibonacciLiniar 0 = 0
fibonacciLiniar n = snd (fibonacciPereche n)
  where
    fibonacciPereche :: Integer -> (Integer, Integer)
    fibonacciPereche 1 = (0, 1)
    fibonacciPereche n = (first, second) 
      where 
        (firstInteger, secondInteger) = fibonacciPereche (n-1)
        first = secondInteger
        second = firstInteger + secondInteger


prop_fib :: Integer -> Property
prop_fib x = x >= 0 && x <= 20 ==> fibonacciEcuational x == fibonacciLiniar x

---------------------------------------------
----------RECURSIE PE LISTE -----------------
---------------------------------------------
semiPareRecDestr :: [Int] -> [Int]
semiPareRecDestr l
  | null l    = l
  | even h    = h `div` 2 : t'
  | otherwise = t'
  where
    h = head l
    t = tail l
    t' = semiPareRecDestr t

semiPareRecEq :: [Int] -> [Int]
semiPareRecEq [] = []
semiPareRecEq (h:t)
  | even h    = h `div` 2 : t'
  | otherwise = t'
  where t' = semiPareRecEq t

inInterval :: Integer -> Integer -> [Integer] -> [Integer]
inInterval a b [] = []
inInterval a b (h:t)
  | h >= a && h <= b = h:t'
  | otherwise = t'
  where t' = inInterval a b t
---------------------------------------------
----------DESCRIERI DE LISTE ----------------
---------------------------------------------
semiPareComp :: [Int] -> [Int]
semiPareComp l = [ x `div` 2 | x <- l, even x ]

prop_semiPare :: [Int] -> Bool
prop_semiPare l = semiPareRecEq l == semiPareComp l


-- L 2.4
inIntervalComp :: Integer -> Integer -> [Integer] -> [Integer]
inIntervalComp a b l = [x | x <- l, x >= a && x <= b]

-- L 2.5
pozitive :: [Integer] -> Int
pozitive [] = 0
pozitive (h:t) 
              | h > 0 = count + 1
              | otherwise = count
              where count = pozitive t

pozitiveComp :: [Integer] -> Int
pozitiveComp l = length [x| x<-l, x > 0]

testPozitive :: [Integer] -> Bool
testPozitive l = pozitive l == pozitiveComp l

-- L2.6

aux :: [Integer] -> Integer -> [Integer]
aux [] _ = [] 
aux (h:t) poz 
             | odd h = poz:sol
             | otherwise = sol
             where sol = aux t (poz+1)

pozitiiImpare :: [Integer] -> [Integer]
pozitiiImpare l = aux l 0 

pozitiiImpareComp :: [Integer] -> [Integer]
pozitiiImpareComp l = [y | (x,y) <- zip l [0..], odd x]

testPozitiiImpare :: [Integer] -> Bool
testPozitiiImpare l = pozitiiImpare l == pozitiiImpareComp l

-- 2.7 
data Directie = Nord | Est | Sud | Vest deriving (Eq, Show)
type Punct = (Integer, Integer)
origine :: Punct
origine = (0,0)
type Drum = [Directie]

nouPunct :: Punct -> Directie -> Punct
nouPunct (x,y) directie 
                | directie == Nord = (x, y + 1) 
                | directie == Est  = (x + 1, y) 
                | directie == Sud = (x, y - 1)
                | otherwise = (x - 1, y) 

miscare :: Punct -> Drum -> Punct
miscare (x,y) [] = (x,y)
miscare (x,y) (directie:t) = miscare (nouPunct (x,y) directie) t  

eqDrum :: Drum -> Drum -> Bool
eqDrum d1 d2 = miscare origine d1 == miscare origine d2 




