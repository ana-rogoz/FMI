
import           Data.List     (sort)
 
type Linie = Integer
type Coloana = Integer


type Partida = [(Linie, Coloana)]
 
exemplu1 :: Partida
exemplu1 = [ (2, 2), (1, 3), (2, 3), (2, 4), (3, 5), (0, 2), (2, 1), (1, 4)
           , (2, 0), (1, 2), (3, 1), (1, 0)
           ]

test11 :: Bool
test11 = 
  separaX0 exemplu1
  ==  ( [(2,2),(2,3),(3,5),(2,1),(2,0),(3,1)]
      , [(1,3),(2,4),(0,2),(1,4),(1,2),(1,0)])
 
separaX0 :: [a] -> ([a], [a])
separaX0 x = (g $ filter (\y-> mod (snd y) 2 ==1) $ f x,g $ filter (\y-> mod (snd y) 2 ==0) $ f x)
		where
			f x = zip x [1..]
			g x = map fst x

test12 :: Bool
test12 = 
  maxLista [[1,2,3], [4,5], [6], [7, 8, 9, 10], [11, 12, 13]]
  == [7, 8, 9, 10]
 
maxLista :: [[a]] -> [a]
maxLista x = let m = maximum $ map length x in filter (\y -> length y == m ) x !! 0 


--[(0,2),(1,0),(1,2),(1,3),(1,4),(2,4)]

--[[(0,2)],[(1,0)],[(1,2),(1,3),(1,4)],[(2,4)]]


test130, test13X :: Bool
test130 =
  grupeazaUnite (sort [(1,3),(2,4),(0,2),(1,4),(1,2),(1,0)])
  == [[(0,2)],[(1,0)],[(1,2),(1,3),(1,4)],[(2,4)]]
test13X =
  grupeazaUnite (sort [(2,2),(2,3),(3,5),(2,1),(2,0),(3,1)])
  == [[(2,0),(2,1),(2,2),(2,3)],[(3,1)],[(3,5)]]

cate :: Partida -> Int
cate [] = 0
cate [x] = 1
cate ((a,b):(c,d):xs) = if a==c && b==d-1 then 1+ cate ((c,d):xs) else 1

grupeazaUnite :: Partida -> [Partida]
grupeazaUnite [] = []
grupeazaUnite x = let c = cate x in (take c x) : (grupeazaUnite $ drop c x) 


test14 :: Bool
test14 =
  maxInLinie exemplu1 == ([(2,0),(2,1),(2,2),(2,3)], [(1,2),(1,3),(1,4)])
 
maxInLinie :: Partida -> (Partida, Partida)
maxInLinie x = let (p1,p2) = separaX0 x in (maxLista $ grupeazaUnite $ sort p1, maxLista $ grupeazaUnite $ sort p2)

data Binar a = Gol | Nod (Binar a) a (Binar a)

exemplu2 :: Binar (Int, Float)
exemplu2 =
  Nod 
      (Nod (Nod Gol (2, 3.5) Gol) (4, 1.2) (Nod  Gol (5, 2.4) Gol)) 
      (7, 1.9)
      (Nod Gol (9, 0.0) Gol)

data Directie = Stanga | Dreapta
 
type Drum = [Directie]

test211, test212 :: Bool
test211 = plimbare [Stanga, Dreapta] exemplu2 == Just (5, 2.4)
test212 = plimbare [Dreapta, Stanga] exemplu2 == Nothing
 
plimbare :: Drum -> Binar a -> Maybe a
plimbare _ Gol = Nothing
plimbare [] (Nod st x dr)= Just x
plimbare (Stanga:xs) (Nod st x dr) = plimbare xs st
plimbare (Dreapta:xs) (Nod st x dr) = plimbare xs dr

type Cheie = Int
type Valoare = Float

newtype WriterString a = Writer { runWriter :: (a, String) }
 
instance Monad WriterString where
  return x = Writer (x, "")
  ma >>= k =  let (x, logx) = runWriter ma
                  (y, logy) = runWriter (k x)
              in  Writer (y, logx ++ logy)

tell :: String -> WriterString ()
tell s = Writer ((), s)
 
instance Functor WriterString where
  fmap f mx = do { x <- mx ; return (f x) }
 
instance Applicative WriterString where
  pure = return
  mf <*> ma = do { f <- mf ; a <- ma ; return (f a) }

test221, test222 :: Bool
test221 = runWriter (cauta 5 exemplu2) == (Just 2.4, "Stanga; Dreapta; ")
test222 = runWriter (cauta 8 exemplu2) == (Nothing, "Dreapta; Stanga; ")
 
cauta :: Cheie -> Binar (Cheie, Valoare) -> WriterString (Maybe Valoare)
cauta _ Gol = return Nothing
cauta c (Nod st (cheie,valoare) dr) 
	| c==cheie = return $ Just valoare
	| c<cheie = do 
					tell "Stanga"
					cauta c st
	| c>cheie = do 
					tell "Dreapta"
					cauta c dr
	
	
	
	
	
	
	
