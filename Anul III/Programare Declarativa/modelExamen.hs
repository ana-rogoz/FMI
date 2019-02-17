import Data.List (sort) 

-- Ex. 1

type Linie = Integer
type Coloana = Integer

type Partida = [(Linie, Coloana)]

exemplu1 :: Partida
exemplu1 = [(2,2), (1,3), (2,3),(2,4),(3,5),(0,2),(2,1),(1,4),(2,0),(1,2),(3,1),(1,0)]

-- 1.1
test11 :: Bool
test11 = separaXO exemplu1 == ([(2,2), (2,3), (3,5), (2,1), (2,0), (3,1)], 
                               [(1,3), (2,4), (0,2), (1,4), (1,2), (1,0)])

rezolva1 :: ([a],[a]) -> [a] -> Int -> ([a],[a])
rezolva1 (x,y) [] _ = (x,y)
rezolva1 (x,y) (ls:l) n 
                       |even n = rezolva1 (x++[ls],y) l (n+1)
                       |otherwise = rezolva1 (x, y++[ls]) l (n+1)

separaXO :: [a] -> ([a],[a])
separaXO l = (l1, l2) where (l1,l2) = rezolva1 ([],[]) l 0  

-- 1.2
test12 :: Bool
test12 = maxLista [[1,2,3],[4,5],[6],[7,8,9,10],[11,12,13]] == [7,8,9,10]

lungimeMaxLista :: [[a]] -> Int -> Int
lungimeMaxLista [] max_curent = max_curent
lungimeMaxLista (x:xs) max_curent 
                                 | (length x) > max_curent = lungimeMaxLista xs (length x)
                                 | otherwise = lungimeMaxLista xs max_curent

gasesteListMax :: [[a]] -> Int -> [a]
gasesteListMax (x:xs) l_max 
                           | (length x) == l_max = x
                           | otherwise = gasesteListMax xs l_max

maxLista :: [[a]] -> [a]
maxLista l = gasesteListMax l l_max where l_max = lungimeMaxLista l 0 

-- 1.3
test130, test13X :: Bool
test130 =
  grupeazaUnite (sort [(1,3),(2,4),(0,2),(1,4),(1,2),(1,0)])
  == [[(0,2)],[(1,0)],[(1,2),(1,3),(1,4)],[(2,4)]]
test13X =
  grupeazaUnite (sort [(2,2),(2,3),(3,5),(2,1),(2,0),(3,1)])
  == [[(2,0),(2,1),(2,2),(2,3)],[(3,1)],[(3,5)]]

grupeazaUnite :: Partida -> [Partida]
grupeazaUnite lp = grupeaza lp [] [] 
                   where 
                     grupeaza [] l1 final = final ++ [l1]
                     grupeaza ((l1,c1):l) [] final = grupeaza l [(l1,c1)] final
                     grupeaza ((l1,c1):l) l_curenta l_final   
                                                           |l1 == l2 && c1 == c2 + 1 = grupeaza l (l_curenta++[(l1,c1)]) l_final
                                                           |otherwise = grupeaza l [(l1,c1)] (l_final++[l_curenta])
                                                            where (l2,c2) = last l_curenta


-- 1.4 
test14 :: Bool
test14 = maxInLinie exemplu1 == ([(2,0),(2,1),(2,2),(2,3)], [(1,2),(1,3),(1,4)])

maxInLinie :: Partida -> (Partida, Partida) 
maxInLinie l = (maxJucator1, maxJucator2)
               where 
                (mutari_1, mutari_2) = separaXO l 
                maxJucator1 = maxLista (grupeazaUnite (sort (mutari_1)))
                maxJucator2 = maxLista (grupeazaUnite (sort (mutari_2)))

-- Ex. 2
data Binar a = Gol | Nod (Binar a) a (Binar a)
exemplu2 :: Binar (Int, Float)
exemplu2 =
   Nod 
       (Nod (Nod Gol (2, 3.5) Gol) (4, 1.2) (Nod  Gol (5, 2.4) Gol)) 
       (7, 1.9)
       (Nod Gol (9, 0.0) Gol)

data Directie = Stanga | Dreapta
type Drum = [Directie]


-- 2.1
test211, test212 :: Bool
test211 = plimbare [Stanga, Dreapta] exemplu2 == Just (5, 2.4)
test212 = plimbare [Dreapta, Stanga] exemplu2 == Nothing

plimbare :: Drum -> Binar a -> Maybe a
plimbare _ Gol = Nothing 
plimbare [] (Nod x y z) = Just y
plimbare (Stanga:xs) (Nod x1 y1 z1) = plimbare xs x1
plimbare (Dreapta:xs) (Nod x1 y1 z1) = plimbare xs z1
 

-- 2.2
type Cheie = Int
type Valoare = Float

newtype WriterString a = Writer { runWriter :: (a, String) }

instance Monad WriterString where 
  return x = Writer (x, "")
  ma >>= k = let (x, logx) = runWriter ma
                 (y, logy) = runWriter (k x)
             in Writer (y, logx ++ logy)

tell :: String -> WriterString () 
tell s = Writer ((), s)

instance Functor WriterString where 
  fmap f mx = do { x <- mx; return (f x)}

instance Applicative WriterString where
  pure = return 
  mf <*> ma = do { f <- mf; a <-ma; return (f a) }

test221, test222 :: Bool
test221 = runWriter (cauta 5 exemplu2) == (Just 2.4, "Stanga; Dreapta; ")
test222 = runWriter (cauta 8 exemplu2) == (Nothing, "Dreapta; Dreapta; ")

cauta :: Cheie -> Binar (Cheie, Valoare) -> WriterString (Maybe Valoare)
cauta cheie Gol = return Nothing
cauta cheie (Nod st (cheie', valoare) dr) 
                                         | cheie == cheie' = return (Just valoare)
                                         | cheie < cheie' = do 
                                                              tell "Stanga; "
                                                              cauta cheie st
                                         | otherwise = do
                                                         tell "Dreapta; "
                                                         cauta cheie dr

