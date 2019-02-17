module Logger where
import Data.Char
import Test.QuickCheck

type Logger a = (a,String)

-- Given a function, debug produces a function logging information 
-- about the computed value for each argument
debug :: (Show a, Show b) =>  (a -> b) -> (a -> Logger b)
debug f x = (y, show x ++ " |-> " ++ show y ++ "; ")
  where
    y = f x

ord' :: Char -> Logger Int
ord' = debug ord

chr' :: Int -> Logger Char
chr' = debug chr

-- Exercise 1
bind :: (a -> Logger b) -> (Logger a -> Logger b)
bind = undefined

-- Using # instead of * for composition to avoid ambiguities
(#) :: (b -> Logger c) -> (a -> Logger b) -> (a -> Logger c)
g' # f' = bind g' . f'

-- Exercise 2
unit :: a -> Logger a
unit = undefined

-- lift --- lifting functions
lift :: (a -> b) -> (a -> Logger b)
lift f = unit . f

-- Test that (for a given value x) lift g # lift f = lift (g.f) 
-- For simplicity we restrict to Float functions as in the tutorial
check_lift :: (Float -> Float) -> (Float -> Float) -> Float -> Bool
check_lift f g x = undefined

test_lift :: IO ()
test_lift = quickCheck $ check_lift (+2) (*3)

-- Exercise Ten (a): Rewrite the module to make Logger instance of 
-- the Monad typeclass
-- Note: You first need to make it an instance of Functor and Applicative

