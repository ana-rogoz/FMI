{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
import Data.Complex
import Control.Applicative

-- DEBUGGING PURE FUNCTIONS
-- intr-un limbaj pur functional, o functie poate citi doar parametri primiti si poate avea efect doar prin parametrii returnati
-- Ex.1
funct :: Float -> (Float, String)
funct x = (x*10, "S-a executat f.")

bind :: (Float -> (Float, String)) -> ((Float, String) -> (Float, String))
bind f (gx, gs) = let (fx,fs) = f gx in (fx, gs++fs)

-- Ex. 2
unit :: Float -> (Float, String)
unit x = (x, "")

lift :: (Float -> Float) -> Float -> (Float, String) 
lift f x = (f x, "") 


-- MULTIVALUED FUNCTIONS
-- Ex. 4
sqrt':: Complex Double -> [Complex Double] 
sqrt' x = [(sqrt x), -(sqrt x)]

bindMultiValued :: (Complex Double -> [Complex Double]) -> [Complex Double] -> [Complex Double]
bindMultiValued f glist = concat (map f glist) 

-- Ex. 5
unitMultiValued :: a -> [a]
unitMultiValued x = [x]


-- RANDOM NUMBERS
-- Ex. 7
bindRand :: (a -> StdGen -> (b, StdGen)) -> (StdGen -> (a, StdGen)) -> (StdGen -> (b, StdGen))
-- (a -> StdGen -> (b, StdGen)), ia o valoare a, un seed si intoarce b si noul seed
-- (StdGen -> (a, StdGen)), seed-ul initial care intoarce (a, StdGen) -> functia g doar ca fara x 
-- StdGen - seed initial pe care-l trimit in a doua paranteza ca sa aflu a,StGen ca sa trimit in prima
bindRand f x seed = f a seedA
                where 
                 (a, seedA) = x seed
-- x e rez. lui g, seed e generator a.i. iese (a, seedA) 
-- aplicam f cu (a, seedA)

-- Ex. 8
type StdGen = Int
unitRand :: a -> (StdGen -> (a, StdGen))
unitRand a seed = (a, seed)

-- MONADS
newtype Debuggable a = Writer {runWriter :: (a,String)}
type Multivalued a = [a]
type Randomised a = StdGen -> (a, StdGen)

-- tripletul obiectelor (m, unit, bind) = MONAD
-- bind f x - se scrie in Haskell x >>= f
-- unit - se numeste return in Haskell
-- Debuggable = Writer monad
-- MultiValued = List monad
-- Randomised = State monad

instance Monad Debuggable where
  return a = Writer (a, "")
  ma >>= k = let (a, log1) = runWriter ma 
                 (b, log2) = runWriter (k a)
             in Writer (b, log1 ++ log2)

instance Functor Debuggable where
  fmap f mx = do { x <- mx ; return (f x) }

instance Applicative Debuggable where
  pure = return
  mf <*> ma = do
               f <- mf 
               a <- ma
               return (f a)

