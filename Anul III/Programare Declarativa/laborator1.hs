import Test.QuickCheck
import Data.List

myInt = 5555555555555555555555555555555555555555555555555555555555555555555555555555555555555

double :: Integer -> Integer
double x = x+x

triple :: Integer -> Integer
triple x = x + x + x

main = print "Hello World!"

penta :: Integer -> Integer
penta x = x + x + x + x + x

test :: Integer -> Bool
test x = (double x + triple x) == (penta x)

maxim :: Integer -> Integer -> Integer 
maxim x y = if (x > y) then x else y 

maxim3 :: Integer -> Integer -> Integer -> Integer
maxim3 x y z = if (x > y && x > z)
                 then x
                 else if (y > x && y > z)
                        then y
                        else z 

maxim3_v2 x y z = let u = maxim x y in maxim u z 

maxim4 :: Integer -> Integer -> Integer -> Integer -> Integer
maxim4 x y z t = let 
                     u = maxim x y 
                     v = maxim z t 
                 in 
                     maxim u v  

testMaxim4 :: Integer -> Integer -> Integer -> Integer -> Bool
testMaxim4 x y z t = x <= maxim4 x y z t && y <= maxim4 x y z t && z <= maxim4 x y z t && t <= maxim4 x y z t


data Alegere = Piatra | Foarfeca | Hartie deriving (Eq, Show)
data Rezultat = Victorie | Infrangere | Egalitate deriving (Eq, Show)

partida :: Alegere -> Alegere -> Rezultat
partida x y = if x == Piatra && y == Piatra 
              then Egalitate 
              else if x == Foarfeca && y == Foarfeca 
                   then Egalitate 
                   else if x == Hartie && y == Hartie
                        then Egalitate
                        else if x == Piatra && y == Foarfeca 
                             then Victorie
                             else if x == Foarfeca && y == Hartie
                                  then Victorie
                                  else if x == Hartie && y == Piatra
                                       then Victorie
                                       else Infrangere

               
