
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
separaX0 [x,y] = ([x],[y])
separaX0 (x:y:xs) = let (a,b) = separaX0 xs in (x:a,y:b)

test12 :: Bool
test12 =
  maxLista [[1,2,3], [4,5], [6], [7, 8, 9, 10], [11, 12, 13]]
  == [7, 8, 9, 10]

maxLista :: [[a]] -> [a]
maxLista l = maxListaAux l [] 0
  where
    maxListaAux [] l1 maxL = l1
    maxListaAux (x:xs) l1 maxL = if length x > maxL then maxListaAux xs x (length x) else maxListaAux xs l1 maxL

test130, test13X :: Bool
test130 =
  grupeazaUnite (sort [(1,3),(2,4),(0,2),(1,4),(1,2),(1,0)])
  == [[(0,2)],[(1,0)],[(1,2),(1,3),(1,4)],[(2,4)]]
test13X =
  grupeazaUnite (sort [(2,2),(2,3),(3,5),(2,1),(2,0),(3,1)])
  == [[(2,0),(2,1),(2,2),(2,3)],[(3,1)],[(3,5)]]

grupeazaUnite :: Partida -> [Partida]
grupeazaUnite l = grupeaza l [] []
  where
    grupeaza [] l final = final ++ [l]
    grupeaza ((x,y):xs) [] final = grupeaza xs [(x,y)] final
    grupeaza ((x,y):xs) l final = let (a,b) = last l in
         if a == x && y == b+1
         then  grupeaza xs (l++[(x,y)]) final
         else grupeaza xs [(x,y)] (final ++ [l])

test14 :: Bool
test14 =
  maxInLinie exemplu1 == ([(2,0),(2,1),(2,2),(2,3)], [(1,2),(1,3),(1,4)])

maxInLinie :: Partida -> (Partida, Partida)
maxInLinie p = let
  (l1,l2) = separaX0 p
  l11 = grupeazaUnite (sort l1)
  l22 = grupeazaUnite (sort l2)
  in (maxLista l11, maxLista l22)

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
plimbare dir Gol = Nothing
plimbare [] (Nod s r d) = Just r
plimbare (Stanga:dir) (Nod s rad d) = plimbare dir s
plimbare (Dreapta:dir)(Nod s r d) = plimbare dir d

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
cauta k Gol = return Nothing
cauta k (Nod s (k1,v1) d)
  | k < k1 = do
      tell "Stanga; "
      cauta k s
  | k == k1 = return (Just v1)
  | k > k1 = do
      tell "Dreapta; "
      cauta k d
